import 'package:first_app/core/Commons/Commons.dart';
import 'package:first_app/core/utiles/app_assets.dart';
import 'package:first_app/core/utiles/app_colors.dart';
import 'package:first_app/core/utiles/app_srtings.dart';
import 'package:first_app/core/widgets/Elevated_Button.dart';
import 'package:first_app/features/task/data/model/Task_model.dart';
import 'package:first_app/features/task/presentation/cubit/task_cubit.dart';
import 'package:first_app/features/task/presentation/cubit/task_state.dart';
import 'package:first_app/features/task/presentation/screens/Home_Screen/Add_Task_Screen/Add_Task_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
            padding: EdgeInsets.all(24),
            child: BlocBuilder<TaskCubit, TaskState>(builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat.yMMMMd().format(DateTime.now()),
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    AppString.today,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  DatePicker(
                    DateTime.now(),
                    initialSelectedDate: DateTime.now(),
                    selectionColor: AppColors.primary,
                    selectedTextColor: AppColors.text,
                    dateTextStyle: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(fontSize: 13.sp),
                    dayTextStyle: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(fontSize: 13.sp),
                    monthTextStyle: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(fontSize: 13.sp),
                    onDateChange: (date) {
                      BlocProvider.of<TaskCubit>(context).getSelectedDate(date);
                    },
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  BlocProvider.of<TaskCubit>(context).taskList.isEmpty
                      ? noTasksWidget(context)
                      : Expanded(
                          child: ListView.builder(
                              itemCount: BlocProvider.of<TaskCubit>(context)
                                  .taskList
                                  .length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  child: TaskComponent(
                                    task: BlocProvider.of<TaskCubit>(context)
                                        .taskList[index],
                                  ),
                                  onTap: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                            padding: EdgeInsets.all(24),
                                            height: 240.h,
                                            color: AppColors.bottomsheet,
                                            child: Column(
                                              children: [
                                                //task completed
                                                BlocProvider.of<TaskCubit>(
                                                                context)
                                                            .taskList[index]
                                                            .isCompleted ==
                                                        1
                                                    ? Container()
                                                    : SizedBox(
                                                        height: 48.h,
                                                        width: double.infinity,
                                                        child: MyElevatedButton(
                                                            text: AppString
                                                                .completed,
                                                            onPressed: () {
                                                              BlocProvider.of<
                                                                          TaskCubit>(
                                                                      context)
                                                                  .updateTasks(BlocProvider.of<
                                                                              TaskCubit>(
                                                                          context)
                                                                      .taskList[
                                                                          index]
                                                                      .id);
                                                              Navigator.pop(
                                                                  context);
                                                            }),
                                                      ),
                                                SizedBox(
                                                  height: 24.h,
                                                ),
                                                //delete task
                                                SizedBox(
                                                  height: 48,
                                                  width: double.infinity,
                                                  child: MyElevatedButton(
                                                      text: AppString.deletTask,
                                                      backgroundColor:
                                                          AppColors.bony,
                                                      onPressed: () {
                                                        BlocProvider.of<
                                                                    TaskCubit>(
                                                                context)
                                                            .deletTask(BlocProvider
                                                                    .of<TaskCubit>(
                                                                        context)
                                                                .taskList[index]
                                                                .id);
                                                        Navigator.pop(context);
                                                      }),
                                                ),
                                                SizedBox(
                                                  height: 24.h,
                                                ),
                                                //cancel
                                                SizedBox(
                                                  height: 48.h,
                                                  width: double.infinity,
                                                  child: MyElevatedButton(
                                                      text: AppString.cancel,
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      }),
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                );
                              }))
                ],
              );
            })),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            navigate(context: context, screen: AddTaskScrenn());
          },
          // ignore: sort_child_properties_last
          child: const Icon(Icons.add),
          backgroundColor: AppColors.primary,
        ),
      ),
    );
  }

  Column noTasksWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(AppAsset.noTasks),
        Text(
          AppString.noTasksTitle,
          style:
              Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 24),
        ),
        Text(
          AppString.noTasksSubTitle,
          style: Theme.of(context).textTheme.displayMedium,
        )
      ],
    );
  }
}

class TaskComponent extends StatelessWidget {
  const TaskComponent({super.key, required this.task});
  final TaskModel task;
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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      height: 190,
      decoration: BoxDecoration(
          color: getColor(task.color), borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(color: AppColors.text),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.timer,
                      color: AppColors.text,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      '${task.startTime}  - ${task.endTime} ',
                      style: Theme.of(context).textTheme.displayMedium,
                    )
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  task.note,
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(color: AppColors.text, fontSize: 30),
                ),
              ],
            )),
            Container(
              height: 75,
              width: 1,
              color: AppColors.text,
            ),
            SizedBox(
              width: 10,
            ),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                task.isCompleted == 1 ? AppString.completed : AppString.tODO,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            )
          ],
        ),
      ),
    );
  }
}
