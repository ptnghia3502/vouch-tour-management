class TourGuide {
  String id;
  String name;
  int sex;
  String phoneNumber;
  String email;
  String status;
  String address;
  String adminId;

  //Contructor
  TourGuide(
      {
      required this.id,
      required this.name,
      required this.sex,
      required this.phoneNumber,
      required this.email,
      required this.status,
      required this.address,
      required this.adminId});

  factory TourGuide.fromJson(Map<String, dynamic> json) {
    return TourGuide(
          id : json['id'],
          name : json['name'],
          sex : json['sex'],
          phoneNumber : json['phoneNumber'],
          email : json['email'],
          status : json['status'],
          address : json['address'],
          adminId : json['adminId']
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = this.id;
    _data['name'] = this.name;
    _data['sex'] = this.sex;
    _data['phoneNumber'] = this.phoneNumber;
    _data['email'] = this.email;
    _data['status'] = this.status;
    _data['address'] = this.address;
    _data['adminId'] = this.adminId;
    return _data;
  }

}