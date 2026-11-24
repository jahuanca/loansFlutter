/// Body de PUT /customer/update-manage-data (seccion Tipo de cliente).
class UpdateCustomerManageDataRequest {
  int id;
  int? idTypeCustomer;
  int? idAssignedRecoveryAgent;

  UpdateCustomerManageDataRequest({
    required this.id,
    this.idTypeCustomer,
    this.idAssignedRecoveryAgent,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'idTypeCustomer': idTypeCustomer,
        'idAssignedRecoveryAgent': idAssignedRecoveryAgent,
      };
}
