class Supplier{
  String id;
  String email;
  String supplierName;
  String address;
  String phoneNumber;
  String adminId;

  //Constructor
  Supplier({
    required this.id,
    required this.email,
    required this.supplierName,
    required this.address,
    required this.phoneNumber,
    required this.adminId
  });
  // List<Supplier>? suppliers ;
  //this is a static method
  // Supplier.fromJson(Map<String, dynamic> json){
  //    Supplier(id: json["id"],
  //             email: json["email"],
  //             supplierName: json["supplierName"],
  //             address: json["address"],
  //             phoneNumber: json["phoneNumber"],
  //             adminId: json["adminId"]);
  //     suppliers = List.from(json['suppliers']).map((e) => Supplier.fromJson(e)).toList();
  // }
  factory Supplier.fromJson(Map<String, dynamic> json){
    return Supplier(
      id: json['id'],
      email: json['email'],
      supplierName: json['supplierName'],
      address: json['address'],
      phoneNumber: json['phoneNumber'],
      adminId: json['adminId']
    );
  }
  Map<String, dynamic> toJson(){
    final _data = <String, dynamic>{};
    _data['id'] = this.id;
    _data['email'] = this.email;
    _data['supplierName'] = this.supplierName;
    _data['address'] = this.address;
    _data['phoneNumber'] = this.phoneNumber;
    _data['adminId'] = this.adminId;
    return _data; 
  }
}