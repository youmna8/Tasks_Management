import 'package:first_app/core/database/sqflite/sqflite_Helper.dart';
import 'package:first_app/core/utiles/app_colors.dart';
import 'package:first_app/features/task/data/model/Task_model.dart';
import 'package:first_app/features/task/presentation/cubit/task_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:first_app/core/Services/Service_Locator.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());
  DateTime currentDate = DateTime.now();
  DateTime selectedDate = DateTime.now();
  String startTime = DateFormat('hh:mm a').format(DateTime.now());
  String endTime = DateFormat('hh:mm a').format(DateTime.now());
  int currentIndex = 0;
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void getDate(context) async {
    emit(GetDateLoadingState());
    DateTime? PickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2040),
    );

    if (PickedDate != null) {
      currentDate = PickedDate;
      emit(GetDateSucessState());
    } else {
      print(PickedDate == null);
      emit(GetDateErrorState());
    }
  }

  void getStartTime(context) async {
    emit(GetStartTimeLoadingState());
    TimeOfDay? pickedStartTime = await showTimePicker(
        context: context, initialTime: TimeOfDay.fromDateTime(DateTime.now()));

    if (pickedStartTime != null) {
      startTime = pickedStartTime.format(context);
      emit(GetStartTimeLoadingState());
    } else {
      print(pickedStartTime == null);
      emit(GetStartTimeErrorState());
    }
  }

  void getEndTime(context) async {
    emit(GetEndTimeLoadingState());
    TimeOfDay? pickedStartTime = await showTimePicker(
        context: context, initialTime: TimeOfDay.fromDateTime(DateTime.now()));

    if (pickedStartTime != null) {
      startTime = pickedStartTime.format(context);
      emit(GetEndTimeSucessState());
    } else {
      print(pickedStartTime == null);
      emit(GetEndTimeErrorState());
    }
  }

  Color getColor(index) {
    switch (index) {
      case 0:
        return AppColors.red;
      case 1:
        return AppColors.green;
      case 2:
        return AppColors.burble;
      case 3:
        return AppColors.yellow;
      case 4:
        return AppColors.move;
      case 5:
        return AppColors.textfield;
      default:
        return AppColors.blue;
    }
  }

  void changeCheckIndex(index) {
    currentIndex = index;
    emit(changeCheck());
  }

  void getSelectedDate(date) {
    emit(GetLoadingSelectedDate());
    selectedDate = date;
    emit(GetSuccessSelectedDate());
    getTasks();
  }

  List<TaskModel> taskList = [];
//insert
  void insertTask() async {
    emit(InsertTaskLoadingState());
    try {
      await sl<SqfliteHelper>().insertToDB(TaskModel(
        title: titleController.text,
        note: noteController.text,
        startTime: startTime,
        endTime: endTime,
        date: DateFormat.yMd().format(currentDate),
        isCompleted: 0,
        color: currentIndex,
      ));
      getTasks();
      /*await Future.delayed(Duration(seconds: 3));

      taskList.add(
        TaskModel(
          id: '1',
          title: titleController.text,
          note: noteController.text,
          startTime: startTime,
          endTime: endTime,
          date: DateFormat.yMd().format(currentDate),
          isCompleted: false,
          color: currentIndex,
        ),
      );*/
      titleController.clear();
      noteController.clear();
      emit(InsertTaskSucessState());
    } catch (e) {
      emit(InsertTaskErrorState());
    }
  }

//get
  void getTasks() async {
    emit(GetDateLoadingState());
    await sl<SqfliteHelper>().getFromDB().then((value) {
      taskList = value
          .map((e) => TaskModel.fromJson(e))
          .toList()
          .where(
              (element) => element.date == DateFormat.yMd().format(selectedDate))
          .toList();
      emit(GetDateSucessState());
    }).catchError((e) {
      print(e.toString());
      emit(GetDateErrorState());
    });
  }
//update

  void updateTasks(id) async {
    emit(UpdateTaskLoadingState());
    await sl<SqfliteHelper>().updateDB(id).then((value) {
      emit(UpdateTaskSucessState());
      getTasks();
    }).catchError((e) {
      print(e.toString());
      emit(UpdateTaskErrorState());
    });
  }

//delete
  void deletTask(id) async {
    emit(DeleteTaskLoadingState());
    await sl<SqfliteHelper>().deleteFromDB(id).then((value) {
      emit(DeleteTaskSucessState());
      getTasks();
    }).catchError((e) {
      print(e.toString());
      emit(DeleteTaskErrorState());
    });
  }
}
