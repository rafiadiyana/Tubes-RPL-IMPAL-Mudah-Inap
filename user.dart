class User {
  User({
    this.id,
    this.name,
    this.email,
    this.password,
    this.noTelp,
  });

  String? id;
  String? name;
  String? email;
  String? password;
  String? noTelp;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        noTelp: json["noTelp"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "password": password,
        "noTelp": noTelp,
      };
}
