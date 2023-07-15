class SupplierChartModel {
  late String id;
  late String email;
  late String supplierName;
  late int numberOfProducts;
  late int numberOfOrders;
  late double totalMoneySold;
  late List<SupplierDataChartModel> supplierDataChartList;
  SupplierChartModel(
      {required this.id,
      required this.email,
      required this.supplierName,
      required this.numberOfProducts,
      required this.numberOfOrders,
      required this.totalMoneySold,
      required this.supplierDataChartList});
  factory SupplierChartModel.fromJson(Map<String, dynamic> json) {
    return SupplierChartModel(
      id: json['id'],
      email: json['email'],
      supplierName: json['supplierName'],
      numberOfProducts: json['numberOfProducts'],
      numberOfOrders: json['numberOfOrder'],
      totalMoneySold: json['totalMoneySold'],
      supplierDataChartList: json['chartDatas'],
    );
  }
}

class SupplierDataChartModel {
  late DateTime date;
  late int numberOfOrdersInDate;
  late double totalMoneyInDate;
}
