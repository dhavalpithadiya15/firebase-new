import 'package:bloc/bloc.dart';
import 'package:firebase_demo_app/main_screen/schedule_notification/schedule_notification_state.dart';
import 'package:firebase_demo_app/notification/notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class ScheduleNotificationCubit extends Cubit<ScheduleNotificationSate> {
  ScheduleNotificationCubit()
      : super(
          ScheduleNotificationSate(
            tittleController: TextEditingController(),
            descriptionController: TextEditingController(),
            dateAndTimeController: TextEditingController(),
          ),
        );

  Future<void> dateAndTimePicker(BuildContext context) async {
    DateTime initialDateTime = DateTime.now();
    await showDatePicker(
      context: context,
      initialDate: initialDateTime,
      firstDate: DateTime(1990),
      lastDate: DateTime(2025),
    ).then(
      (date) {
        if (date != null) {
          print("DATE FROM DATE PICKER  ==> $date");
          showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(
              initialDateTime,
            ),
          ).then(
            (time) {
              if (time != null) {
                print("TIME SELECTED FROM TIME PICKER ==> $time");
                DateTime selectedDateTime =
                    DateTime(date.year, date.month, date.day, time.hour, time.minute, date.second);
                print("SELECTED DATE AND TIME BOTH ==> $selectedDateTime");
                String formattedDateTime = DateFormat("dd-MM-yyy HH:mm:ss").format(selectedDateTime);
                emit(state.copyWith(selectedDateTime: formattedDateTime));
                print(state.selectedDateTime);
              }
            },
          );
        }
      },
    );
  }

  void save() {
    int id = math.Random().nextInt(1000);
    NotificationHandler().showTimeZoneNotification(
      id,
      state.tittleController.text,
      state.descriptionController.text,
      state.selectedDateTime,
    );
  }
}
