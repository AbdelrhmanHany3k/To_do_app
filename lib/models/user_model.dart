class Usermodel{
  String id;
  String email;
  String name;
  String password;
  String number;

  Usermodel({this.id='',
    required this.email,
    required this.name,
    required this.password,
    required this.number});

  Usermodel.fromJson(Map<String,dynamic>json):this(
    id: json["id"],
    email: json["email"],
    name: json["name"],
    password: json["password"],
    number: json["number"]
  );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "email": email,
      "name": name,
      "password": password,
      "number": number,
    };
  }

}