import 'package:first_app/core/Commons/Commons.dart';
import 'package:first_app/core/utiles/app_colors.dart';
import 'package:first_app/core/utiles/app_srtings.dart';
import 'package:first_app/core/widgets/Elevated_Button.dart';
import 'package:first_app/features/task/presentation/Components/add_task_component.dart';
import 'package:first_app/features/task/presentation/cubit/task_cubit.dart';
import 'package:first_app/features/task/presentation/cubit/task_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';


// ignore: must_be_immutable
class AddTaskScrenn extends StatelessWidget {
  AddTaskScrenn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_forward_ios, color: AppColors.text),
          ),
          title: Text(
            AppString.addTask,
            style: Theme.of(context).textTheme.displayLarge,
          ),
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24),
            child:
                BlocConsumer<TaskCubit, TaskState>(listener: (context, state) {
              if (state is InsertTaskSucessState) {
                showToast(msg: 'Added Sucessfully', state: ToastStates.success);

                Navigator.pop(context);
              }
            }, builder: (context, state) {
              final cubit = BlocProvider.of<TaskCubit>(context);
              return Form(
                  key: BlocProvider.of<TaskCubit>(context).formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AddTaskComponent(
                          title: AppString.title,
                          controller: BlocProvider.of<TaskCubit>(context)
                              .titleController,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return AppString.validateTitle;
                            }
                            return null;
                          },
                          hintTxt: AppString.titleHint),
                      SizedBox(
                        height: 24.h,
                      ),
                      AddTaskComponent(
                          title: AppString.note,
                          controller: BlocProvider.of<TaskCubit>(context)
                              .noteController,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return AppString.validateNote;
                            }
                            return null;
                          },
                          hintTxt: AppString.noteHint),
                      SizedBox(
                        height: 24.h,
                      ),
                      AddTaskComponent(
                        readOnly: true,
                        title: AppString.date,
                        hintTxt: DateFormat.yMd().format(cubit.currentDate),
                        sffixIcon: IconButton(
                            onPressed: () async {
                              cubit.getDate(context);
                            },
                            icon: Icon(
                              Icons.calendar_month_outlined,
                              color: AppColors.text,
                            )),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: AddTaskComponent(
                              readOnly: true,
                              title: AppString.startTime,
                              hintTxt: cubit.startTime,
                              sffixIcon: IconButton(
                                icon: Icon(
                                  Icons.timer_outlined,
                                  color: AppColors.text,
                                ),
                                onPressed: () async {
                                  cubit.getStartTime(context);
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 26.w,
                          ),
                          Expanded(
                            child: AddTaskComponent(
                              title: AppString.endTime,
                              hintTxt: cubit.endTime,
                              sffixIcon: IconButton(
                                icon: Icon(
                                  Icons.timer_outlined,
                                  color: AppColors.text,
                                ),
                                onPressed: () async {
                                  cubit.getEndTime(context);
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      SizedBox(
                        height: 68.h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppString.color,
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            Expanded(
                                child: ListView.separated(
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                          onTap: () {
                                            cubit.changeCheckIndex(index);
                                          },
                                          child: CircleAvatar(
                                            backgroundColor:
                                                cubit.getColor(index),
                                            child: index == cubit.currentIndex
                                                ? Icon(Icons.check)
                                                : null,
                                          ));
                                    },
                                    scrollDirection: Axis.horizontal,
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                          width: 8,
                                        ),
                                    itemCount: 6))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 90.h,
                      ),
                      state is InsertTaskLoadingState
                          ? Center(
                              child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ))
                          : SizedBox(
                              height: 48.h,
                              width: double.infinity,
                              child: MyElevatedButton(
                                text: AppString.createtask,
                                onPressed: () {
                                  if (BlocProvider.of<TaskCubit>(context)
                                      .formKey
                                      .currentState!
                                      .validate()) {
                                    BlocProvider.of<TaskCubit>(context)
                                        .insertTask();
                                  }
                                  ;
                                },
                              ),
                            ),
                    ],
                  ));
            }),
          ),
        ));
  }
}
