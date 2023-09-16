import 'package:first_app/app/app.dart';
import 'package:first_app/core/Services/Service_Locator.dart';
import 'package:first_app/core/bloc/bloc_observer.dart';
import 'package:first_app/core/database/Cache/Cache_Helper.dart';
import 'package:first_app/core/database/sqflite/sqflite_Helper.dart';

import 'package:first_app/features/task/presentation/cubit/task_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  setup();
  WidgetsFlutterBinding.ensureInitialized();
  await sl<CacheHelper>().init();
   sl<SqfliteHelper>().initDB();
  runApp(BlocProvider(create: (context) => TaskCubit()..getTasks(),
   child: MyApp()));
}
