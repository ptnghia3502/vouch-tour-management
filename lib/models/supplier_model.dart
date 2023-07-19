class Supplier{
  String id;
  String? email;
  String? supplierName;
  String? address;
  String? phoneNumber;

  //Constructor
  Supplier({
    required this.id,
     this.email,
     this.supplierName,
     this.address,
     this.phoneNumber,
  });

  factory Supplier.fromJson(Map<String, dynamic> json){
    return Supplier(
      id: json['id'],
      email: json['email'],
      supplierName: json['supplierName'],
      address: json['address'],
      phoneNumber: json['phoneNumber'],
    );
  }
  
  Map<String, dynamic> toJson(){
    final _data = <String, dynamic>{};
    _data['id'] = this.id;
    _data['email'] = this.email;
    _data['supplierName'] = this.supplierName;
    _data['address'] = this.address;
    _data['phoneNumber'] = this.phoneNumber;
    return _data; 
  }
}