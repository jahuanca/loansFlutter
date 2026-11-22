import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_payment_account_entity.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer_payment_account/add_customer_payment_account_ui.dart';
import 'package:loands_flutter/src/utils/core/extensions.dart';
import 'package:loands_flutter/src/utils/core/ids_get.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:loands_flutter/src/utils/core/strings_arguments.dart';
import 'package:loands_flutter/src/utils/domain/entities/payment_provider_entity.dart';
import 'package:utils/utils.dart';

/// Formulario de una cuenta de pago. No llama a la API: valida y devuelve la
/// entidad con Get.back(result: ...). Quien la abre (AddCustomerController)
/// decide si la guarda en memoria (cliente nuevo) o contra el endpoint (edicion).
class AddCustomerPaymentAccountController extends GetxController {
  List<PaymentProviderEntity> paymentProviders = PaymentProviderEntity.defaults;
  PaymentProviderEntity? paymentProviderSelected;

  AddCustomerPaymentAccountUi ui = AddCustomerPaymentAccountUi();
  bool isEditing = false;

  @override
  void onInit() {
    setInitialValues();
    super.onInit();
  }

  void setInitialValues() {
    CustomerPaymentAccountEntity? account = Get.setArgument(customerPaymentAccountArgument);
    if (account != null) {
      isEditing = true;
      ui.setValuesOfAccount(account);
      onChangedPaymentProvider(ui.idPaymentProvider?.value);
    }
  }

  void onChangedPaymentProvider(dynamic value) {
    int index = paymentProviders.indexWhere(
      (e) => e.id == value,
    );
    if (index != notFoundPosition) {
      paymentProviderSelected = paymentProviders[index];
      ui.idPaymentProvider = ValidateResult.initialize(
        label: paymentProviderString,
        value: value,
      );
    }
    update([paymentProvidersIdGet]);
  }

  void onChangedAccountNumber(String value) {
    ui.accountNumber = validateText<String>(
      rules: {
        RuleValidator.maxLength: CustomerPaymentAccountEntity.maxLengthOfAccountNumber,
      },
      text: value,
      label: accountNumberString,
    );
  }

  void onChangedCci(String value) {
    ui.cci = validateText<String>(
      rules: {
        RuleValidator.maxLength: CustomerPaymentAccountEntity.maxLengthOfCci,
      },
      text: value,
      label: cciString,
    );
  }

  void onChangedPaymentPhone(String value) {
    ui.paymentPhone = validateText<String>(
      rules: {
        if (value.isNotEmpty)
          RuleValidator.minLength: CustomerPaymentAccountEntity.maxLengthOfPhone,
        RuleValidator.maxLength: CustomerPaymentAccountEntity.maxLengthOfPhone,
      },
      text: value,
      label: paymentPhoneString,
    );
  }

  void onChangedHolderName(String value) {
    ui.holderName = validateText<String>(
      rules: {
        RuleValidator.isRequired: true,
        RuleValidator.maxLength: CustomerPaymentAccountEntity.maxLengthOfHolderName,
      },
      text: value,
      label: holderNameString,
    );
  }

  void onChangedObservation(String value) {
    ui.observation = validateText<String>(
      rules: {
        RuleValidator.maxLength: CustomerPaymentAccountEntity.maxLengthOfObservation,
      },
      text: value,
      label: observationString,
    );
  }

  void onChangedIsDefault(bool value) {
    ui.isDefault = value;
    update();
  }

  /// Misma regla que normalizeAccountByCategory en loans_node:
  /// se valida aqui para avisar antes de llamar a la API.
  String? _validateByCategory() {
    final provider = paymentProviderSelected;
    if (provider == null) return selectPaymentProviderString;
    final bool hasBankData = (ui.cci?.value).orEmpty().isNotEmpty ||
        (ui.accountNumber?.value).orEmpty().isNotEmpty;
    if (provider.isBank && !hasBankData) return bankRequiresAccountString;
    if (provider.isWallet && (ui.paymentPhone?.value).orEmpty().isEmpty) {
      return walletRequiresPhoneString;
    }
    return null;
  }

  String? validate() {
    onChangedAccountNumber(ui.accountNumber?.value ?? '');
    onChangedCci(ui.cci?.value ?? '');
    onChangedPaymentPhone(ui.paymentPhone?.value ?? '');
    onChangedHolderName(ui.holderName?.value ?? '');
    onChangedObservation(ui.observation?.value ?? '');
    return ui.validate()?.error ?? _validateByCategory();
  }

  void goConfirm() {
    String? message = validate();
    if (message != null) {
      showSnackbarWidget(
          context: Get.context!,
          typeSnackbar: TypeSnackbar.error,
          message: message);
      return;
    }
    final account = ui.toEntity()..paymentProvider = paymentProviderSelected;
    Get.back(result: account);
  }
}
