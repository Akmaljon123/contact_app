import 'package:hive/hive.dart';
part 'register_model.g.dart';

@HiveType(typeId: 0)
class RegisterModel{
  @HiveField(0)
  late String username;
  @HiveField(1)
  late String password;
  @HiveField(2)
  late String phoneNumber;
  @HiveField(3)
  late String email;
  @HiveField(4)
  late String path;

  RegisterModel({
    required this.username,
    required this.password,
    required this.phoneNumber,
    required this.email,
    required this.path
  });

  RegisterModel.fromJson(Map<String, Object?> json){
    username = json["username"] as String;
    password = json["password"] as String;
    phoneNumber = json["phoneNumber"] as String;
    email = json["email"] as String;
    path = json["path"] as String;
  }

  Map<String, Object?> toJson(){
    return {
      "username": username,
      "password": password,
      "phoneNumber": phoneNumber,
      "email": email,
      "path": path
    };
  }
}