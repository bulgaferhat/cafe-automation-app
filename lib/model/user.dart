class UserModel {
  UserModel(
      {required this.username,
      required this.email,
      required this.password,
      this.admin = false});
  String username;
  String email;
  String password;
  bool admin;

  factory UserModel.fromJson(json) => UserModel(
      username: json["username"],
      email: json["email"],
      password: json["password"],
      admin: json["admin"]);

  toJson() {
    return {
      "username": username,
      "email": email,
      "password": password,
      "admin": admin
    };
  }
}
