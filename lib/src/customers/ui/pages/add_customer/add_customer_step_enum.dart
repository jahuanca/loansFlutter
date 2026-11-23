/// Pasos del formulario de cliente, en el orden en que se muestran en el PageView.
enum AddCustomerStep {
  personalData('Información personal'),
  addressData('Domicilio'),
  paymentData('Datos de pago'),
  manageData('Manejo de cliente');

  final String title;

  const AddCustomerStep(this.title);
}
