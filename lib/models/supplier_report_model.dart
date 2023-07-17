class SupplierReport{
  String id;
  String email;
  String supplierName;
  int numberOfProducts;
  int numberOfOrder;
  double totalMoneySold;
  List<ChartData> chartDatas;

  //Constructor
  SupplierReport({
    required this.id,
    required this.email,
    required this.supplierName,
    required this.numberOfOrder,
    required this.numberOfProducts,
    required this.totalMoneySold,
    required this.chartDatas
  });

  factory SupplierReport.fromJson(Map<String, dynamic> json){
    var chartDataList = json['chartDatas'] as List<dynamic>;
    List<ChartData> chartDatas = chartDataList.map((chartData) => ChartData.fromJson(chartData)).toList();
    return SupplierReport(
      id: json['id'],
      email: json['email'],
      supplierName: json['supplierName'],
      numberOfOrder: json['numberOfOrder'],
      numberOfProducts: json['numberOfProducts'],
      totalMoneySold: json['totalMoneySold'],
      chartDatas: chartDatas
    );
  }
  
  Map<String, dynamic> toJson(){
    final _data = <String, dynamic>{};
    _data['id'] = this.id;
    _data['email'] = this.email;
    _data['supplierName'] = this.supplierName;
    _data['numberOfOrder'] = this.numberOfOrder;
    _data['numberOfProducts'] = this.numberOfProducts;
    _data['chartDatas'] = this.chartDatas;
    return _data; 
  }
}

class ChartData{
  String date;
  int numberOfOrderInDate;
  double totalMoneyInDate;

  ChartData({
    required this.date,
    required this.numberOfOrderInDate,
    required this.totalMoneyInDate
  });

  factory ChartData.fromJson(Map<String, dynamic> json){
    return ChartData(
      date: json['date'],
      numberOfOrderInDate: json['numberOfOrderInDate'],
      totalMoneyInDate: json['totalMoneyInDate']
    );
  }
}