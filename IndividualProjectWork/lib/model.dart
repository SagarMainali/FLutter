class UserDetail {
  String? id;
  final String fullName;
  final int phoneNumber;
  final String contactEmail;
  final String address;
  final String documentType;
  final String documentNumber;
  final String placeFound;
  final String district;

  UserDetail({
    this.id = '',
    required this.fullName,
    required this.phoneNumber,
    required this.contactEmail,
    required this.address,
    required this.documentType,
    required this.documentNumber,
    required this.placeFound,
    required this.district,
  });

  Map<String, dynamic> toJson() => {
        'id': '',
        'fullName': fullName,
        'phoneNumber': phoneNumber,
        'contactEmail': contactEmail,
        'address': address,
        'documentType': documentType,
        'documentNumber': documentNumber,
        'placeFound': placeFound,
        'district': district
      };

  static UserDetail fromJson(Map<String, dynamic> json) => UserDetail(
      id: json['id'],
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
      contactEmail: json['contactEmail'],
      address: json['address'],
      documentType: json['documentType'],
      documentNumber: json['documentNumber'],
      placeFound: json['placeFound'],
      district: json['district']);
}
