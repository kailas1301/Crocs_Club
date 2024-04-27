class AddressModel {
  final int? id;
  final String city;
  final String houseName;
  final String name;
  final String phone;
  final String pin;
  final String state;
  final String street;

  AddressModel({
    this.id,
    required this.city,
    required this.houseName,
    required this.name,
    required this.phone,
    required this.pin,
    required this.state,
    required this.street,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json["id"],
      city: json['city'],
      houseName: json['house_name'],
      name: json['name'],
      phone: json['phone'],
      pin: json['pin'],
      state: json['state'],
      street: json['street'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'house_name': houseName,
      'name': name,
      'phone': phone,
      'pin': pin,
      'state': state,
      'street': street,
    };
  }
}
