import 'package:first_app/core/database/Cache/Cache_Helper.dart';
import 'package:first_app/core/database/sqflite/sqflite_Helper.dart';


import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void setup() {
  sl.registerLazySingleton<CacheHelper>(()=> CacheHelper());
  sl.registerLazySingleton<SqfliteHelper>(()=> SqfliteHelper());

}
