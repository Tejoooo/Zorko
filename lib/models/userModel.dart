class UserModel{
  // String token;
  String uid;
  String phoneNumber;
  String name;
  String pincode;
  String address;
  String profilepic;
  String coins;

  UserModel({
    // required this.token,
    required this.uid,
    required this.phoneNumber,
    required this.name,
    required this.pincode,
    required this.address,
    required this.profilepic,
    required this.coins,
  });

  factory UserModel.fromJson(Map<String, dynamic> json, String uid) {
    return UserModel(
      // token: json['token'],
      uid: uid,
      phoneNumber: json['ph_no'],
      name: json['name'],
      pincode: json['pincode'],
      address: json['address'],
      profilepic: json['profilepic'],
      coins : json['coins'].toString(),
    );
  }
}