class ContactModel{
  late String name;
  late String number;
  late String email;
  late String path;

  ContactModel({required this.email, required this.name, required this.number, required this.path});

  ContactModel.fromJson(Map<String, Object?> json){
    name = json["name"] as String;
    number = json["number"] as String;
    email = json["email"] as String;
    path = json["path"] as String;
  }

  Map<String, Object?> toJson(){
    return {
      "name": name,
      "number": number,
      "email": email,
      "path": path
    };
  }
}