import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:room_booking/models/booking.dart';

class BookingFormController {
  final bookingMeetingNameController = TextEditingController();
  final bookingUserNameController = TextEditingController();

  final startDateController = TextEditingController();
  final startTimeController = TextEditingController();

  final endDateController = TextEditingController();
  final endTimeController = TextEditingController();

  void dispose() {
    bookingMeetingNameController.dispose();
    bookingUserNameController.dispose();
    startDateController.dispose();
    startTimeController.dispose();
    endDateController.dispose();
    endTimeController.dispose();
  }

  Booking getBooking() {
    final startDateTime = DateTime.parse(startDateController.text);
    var startHour = startTimeController.text.split(":")[0];
    var startMinute = startTimeController.text.split(":")[1];
    final startTime = TimeOfDay(hour: int.parse(startHour), minute: int.parse(startMinute));

    final endDateTime = DateTime.parse(endDateController.text);
    var endHour = endTimeController.text.split(":")[0];
    var endMinute = endTimeController.text.split(":")[1];
    final endTime = TimeOfDay(hour: int.parse(endHour), minute: int.parse(endMinute));

    return Booking(
        id: uuid.v4(),
        userName: bookingUserNameController.text,
        meetingName: bookingMeetingNameController.text,
        start: DateTime(
          startDateTime.year,
          startDateTime.month,
          startDateTime.day,
          startTime.hour,
          startTime.minute,
        ),
        end: DateTime(
          endDateTime.year,
          endDateTime.month,
          endDateTime.day,
          endTime.hour,
          endTime.minute,
        ),
    );
  }

}