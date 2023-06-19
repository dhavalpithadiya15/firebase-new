import 'package:firebase_demo_app/custom_widgets/custom_button.dart';
import 'package:firebase_demo_app/custom_widgets/custom_text_field.dart';
import 'package:firebase_demo_app/main_screen/schedule_notification/schedule_notification_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduleNotificationView extends StatelessWidget {
  const ScheduleNotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScheduleNotificationCubit(),
      child: Builder(builder: (context) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextField(
                  labelText: "Tittle",
                  controller: context.read<ScheduleNotificationCubit>().state.tittleController,
                ),
                CustomTextField(
                  labelText: "Description",
                  controller: context.read<ScheduleNotificationCubit>().state.descriptionController,
                ),
                CustomTextField(
                  onTap: () {
                    BlocProvider.of<ScheduleNotificationCubit>(context).dateAndTimePicker(context);
                  },
                  readOnly: true,
                  labelText: "Select time of Notification",
                  controller: context.read<ScheduleNotificationCubit>().state.dateAndTimeController,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomButton(
                  onTap: () {
                    BlocProvider.of<ScheduleNotificationCubit>(context).save();
                  },
                  text: "Save",
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
