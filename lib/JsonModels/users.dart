//In here first we create the users json model
// To parse this JSON data, do
//
class Users {
  final int? userid;
  final String username;
  final String password;
  final String? name;
  final String? email;
  final int? phone;
  final String? address;

  Users({
    this.userid,
    required this.username,
    required this.password,
    this.name,
    this.email,
    this.phone,
    this.address,
  });

  factory Users.fromMap(Map<String, dynamic> json) => Users(
        userid: json["userid"],
        username: json["username"],
        password: json["password"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
      );

  Map<String, dynamic> toMap() => {
        "userid": userid,
        "username": username,
        "password": password,
        "name": name,
        "email": email,
        "phone": phone,
        "address": address ?? '',
      };
}
