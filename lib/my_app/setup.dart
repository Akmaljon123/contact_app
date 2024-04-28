import 'package:contact_app/models/contact_model.dart';
import 'package:contact_app/models/register_model.dart';
import 'package:contact_app/services/hive_service.dart';
import 'package:contact_app/services/path_provider_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';

late List<RegisterModel> userList;
late List<ContactModel> contactList;


Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(RegisterModelAdapter());
  userList = await HiveService.getData();
  contactList = await PathProviderService.getContact();
}
