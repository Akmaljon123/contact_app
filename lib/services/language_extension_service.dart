import 'package:contact_app/data/ru.dart';
import 'package:contact_app/services/language_service.dart';
import '../data/en.dart';
import '../data/uz.dart';

extension LanguageExtension on String{
  String get translate{
    switch(LanguageService.getLanguage){
      case Languages.en:
        return en[this] ?? this;
      case Languages.ru:
        return ru[this] ?? this;
      case Languages.uz:
        return uz[this] ?? this;
    }
  }
}