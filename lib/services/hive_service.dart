import 'package:contact_app/models/register_model.dart';
import 'package:hive/hive.dart';

enum Keys{
  regInfo
}

class HiveService{
  static Future<void> saveData({
    required String username,
    required String password,
    required String phoneNumber,
    required String email,
    required String path})async{
    var box = await Hive.openBox(Keys.regInfo.name);
    RegisterModel registerModel = RegisterModel(
        username: username,
        password: password,
        phoneNumber: phoneNumber,
        email: email,
        path: path
    );

    await box.add(registerModel);
  }


  static Future<List<RegisterModel>> getData()async{
    var box = await Hive.openBox(Keys.regInfo.name);
    List<RegisterModel> information = box.values.toList().cast<RegisterModel>();
    return information;
  }



}