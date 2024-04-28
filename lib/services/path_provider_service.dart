import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../models/contact_model.dart';
import '../my_app/setup.dart';

class PathProviderService {
  static Future<void> saveContact({required ContactModel contact}) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File("${directory.path}/data.txt");

    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }

    if (await file.exists()) {
      String fileContents = await file.readAsString();
      contactList = List<ContactModel>.from(jsonDecode(fileContents).map((x) => ContactModel.fromJson(x)));
    }

    contactList.add(contact);
    await file.writeAsString(jsonEncode(contactList));
  }

  static Future<void> updateContact({required ContactModel contact, required int i}) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File("${directory.path}/data.txt");

    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }

    if (await file.exists()) {
      String fileContents = await file.readAsString();
      contactList = List<ContactModel>.from(jsonDecode(fileContents).map((x) => ContactModel.fromJson(x)));
    }

    contactList[i] = contact;
    await file.writeAsString(jsonEncode(contactList));
  }

  static Future<void> deleteContact({required int i}) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File("${directory.path}/data.txt");

    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }

    contactList.removeAt(i);
    await file.writeAsString(jsonEncode(contactList));
  }

  static Future<List<ContactModel>> getContact() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File("${directory.path}/data.txt");

    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }

    if (await file.exists()) {
      String fileContents = await file.readAsString();
      List<ContactModel> contactModels = List<ContactModel>.from(jsonDecode(fileContents).map((e) => ContactModel.fromJson(e)));
      return contactModels;
    } else {
      return [];
    }
  }
}
