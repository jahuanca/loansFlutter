import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/data/requests/customer_address_request.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_address_entity.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/customer_address/create_customer_address_use_case.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/customer_address/update_customer_address_use_case.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/customer_address/upload_customer_address_image_use_case.dart';
import 'package:loands_flutter/src/utils/core/helpers.dart';
import 'package:loands_flutter/src/utils/core/ids_get.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:loands_flutter/src/utils/ui/widgets/loading/loading_service.dart';
import 'package:utils/utils.dart';

/// Formulario de direccion: crea (original == null) o edita (original != null).
/// - Editar: tipo, direccion, referencia, principal y (opcional) volver a capturar la ubicacion;
///   la foto se mantiene.
/// - Crear: ademas pide la foto, que el backend exige. Se sube primero (upload-image)
///   y la clave que devuelve se envia en `image` del create. La ubicacion (GPS) es obligatoria.
class EditCustomerAddressController extends GetxController {
  CreateCustomerAddressUseCase createCustomerAddressUseCase;
  UpdateCustomerAddressUseCase updateCustomerAddressUseCase;
  UploadCustomerAddressImageUseCase uploadCustomerAddressImageUseCase;
  final int idCustomer;
  final CustomerAddressEntity? original;

  /// Al crear: si el cliente no tiene direcciones, el backend la marca como principal.
  final bool isFirstAddress;

  late CustomerAddressType type;
  ValidateResult<String>? address;
  String? reference;
  late bool isPrimary;
  File? imageFile;
  double? latitude;
  double? longitude;
  /// Precision en metros de la ultima captura (solo informativa, no se guarda).
  double? accuracyInMeters;

  EditCustomerAddressController({
    required this.createCustomerAddressUseCase,
    required this.updateCustomerAddressUseCase,
    required this.uploadCustomerAddressImageUseCase,
    required this.idCustomer,
    this.original,
    this.isFirstAddress = false,
  }) {
    final CustomerAddressEntity? current = original;
    type = current?.typeOfAddress ?? CustomerAddressType.home;
    address = current == null
        ? null
        : ValidateResult.initialize(label: addressString, value: current.address);
    reference = current?.reference;
    isPrimary = current?.isPrimary ?? isFirstAddress;
    latitude = current?.latitude;
    longitude = current?.longitude;
  }

  bool get isEditing => original != null;

  String get title => isEditing ? editAddressString : addAddressString;

  /// No se puede desmarcar la principal (regla del backend) y la primera siempre lo es.
  bool get canChangePrimary =>
      isEditing ? !original!.isPrimary : !isFirstAddress;

  String? get primaryLockedMessage {
    if (canChangePrimary) return null;
    return isEditing ? primaryAddressLockedString : firstAddressIsPrimaryString;
  }

  void onChangedType(dynamic value) {
    type = CustomerAddressType.fromValue(value);
    update([addressTypeIdGet]);
  }

  void onChangedAddress(String value) {
    address = validateText<String>(
      rules: {
        RuleValidator.isRequired: true,
        RuleValidator.maxLength: CustomerAddressEntity.maxLengthOfAddress,
      },
      text: value,
      label: addressString,
    );
  }

  void onChangedReference(String value) {
    reference = value.trim().isEmpty ? null : value.trim();
  }

  void onChangedIsPrimary(bool value) {
    if (!canChangePrimary) return;
    isPrimary = value;
    update([isPrimaryIdGet]);
  }

  void pickImage() async {
    final FilePickerResult? result =
        await FilePicker.pickFiles(type: FileType.image);
    final String? path = result?.files.single.path;
    if (path == null) return;
    imageFile = File(path);
    update([addressImageIdGet]);
  }

  bool get hasLocation => latitude != null && longitude != null;

  /// Pide permiso (si hace falta) y toma la posicion actual del telefono con el GPS.
  Future<void> captureLocation() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      _showError(locationServiceDisabledString);
      return;
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      // Android/iOS ya no vuelven a preguntar: solo se puede activar desde ajustes.
      final bool openSettings = await showDialogWidget(
          context: Get.context!, message: locationPermissionForeverString);
      if (openSettings) await Geolocator.openAppSettings();
      return;
    }
    if (permission == LocationPermission.denied) {
      _showError(locationPermissionDeniedString);
      return;
    }

    showLoading();
    try {
      final Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 20),
        ),
      );
      // 6 decimales (~10 cm): lo que guarda DECIMAL(9,6) y acepta el Joi.
      latitude = double.parse(position.latitude.toStringAsFixed(6));
      longitude = double.parse(position.longitude.toStringAsFixed(6));
      accuracyInMeters = position.accuracy;
    } catch (_) {
      _showError(locationErrorString);
    } finally {
      hideLoading();
    }
    update([locationIdGet]);
  }

  void goToMap() {
    if (!hasLocation) return;
    openMap(latitude: latitude, longitude: longitude);
  }

  void save() async {
    onChangedAddress(address?.value.orEmpty() ?? '');
    String? message = findErrorInValidations([address])?.error;
    if (message == null && !isEditing && !hasLocation) {
      message = locationRequiredString;
    }
    if (message == null && !isEditing && imageFile == null) {
      message = photoRequiredString;
    }
    if (message != null) {
      _showError(message);
      return;
    }
    final bool confirm = await showDialogWidget(
      context: Get.context!,
      message: isEditing ? areSureToEditAddress : areSureToAddAddress,
    );
    if (!confirm) return;

    showLoading();
    final String? image = isEditing ? original!.image : await _uploadImage(imageFile!);
    if (image == null) {
      hideLoading();
      return;
    }
    final CustomerAddressRequest request = CustomerAddressRequest(CustomerAddressEntity(
      id: original?.id ?? 0,
      idCustomer: idCustomer,
      type: type.value,
      address: address!.value!.trim(),
      reference: reference,
      latitude: latitude,
      longitude: longitude,
      image: image,
      isPrimary: isPrimary,
    ));
    final Result<CustomerAddressEntity> result = isEditing
        ? await updateCustomerAddressUseCase.execute(request)
        : await createCustomerAddressUseCase.execute(idCustomer, request);
    hideLoading();
    final CustomerAddressEntity? data = executeResultUI<CustomerAddressEntity>(result);
    if (data != null) Get.back(result: data);
  }

  /// Sube la foto y devuelve la clave que se guarda en `image` (null si fallo;
  /// executeResultUI ya mostro el error).
  Future<String?> _uploadImage(File file) async {
    final Result<String> result = await uploadCustomerAddressImageUseCase.execute(file);
    return executeResultUI<String>(result);
  }

  void _showError(String message) {
    showSnackbarWidget(
        context: Get.context!, typeSnackbar: TypeSnackbar.error, message: message);
  }
}
