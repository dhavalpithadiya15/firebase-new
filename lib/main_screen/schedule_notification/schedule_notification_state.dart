import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class ScheduleNotificationSate extends Equatable {
  final TextEditingController tittleController;
  final TextEditingController descriptionController;
  final TextEditingController dateAndTimeController;
  final String selectedDateTime;

  @override
  List<Object?> get props => [selectedDateTime];

  const ScheduleNotificationSate({
    required this.tittleController,
    required this.descriptionController,
    required this.dateAndTimeController,
    this.selectedDateTime = "",
  });

  ScheduleNotificationSate copyWith({
    TextEditingController? tittleController,
    TextEditingController? descriptionController,
    TextEditingController? dateAndTimeController,
    String? selectedDateTime,
  }) {
    return ScheduleNotificationSate(
      tittleController: tittleController ?? this.tittleController,
      descriptionController: descriptionController ?? this.descriptionController,
      dateAndTimeController: dateAndTimeController ?? this.dateAndTimeController,
      selectedDateTime: selectedDateTime ?? this.selectedDateTime,
    );
  }
}
