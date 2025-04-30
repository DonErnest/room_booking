import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:room_booking/models/booking.dart';
import 'package:room_booking/providers/booking_provider.dart';
import 'package:room_booking/utils.dart';
import 'package:room_booking/widgets/booking_form/booking_form_controller.dart';

class BookingForm extends StatefulWidget {
  final BookingFormController controller;
  final List<Booking> bookings;

  const BookingForm({
    super.key,
    required this.controller,
    required this.bookings,
  });

  @override
  State<BookingForm> createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  var bookingMeetingName = "";
  var bookingUserName = "";
  DateTime? startDate;
  TimeOfDay? startTime;
  DateTime? endDate;
  TimeOfDay? endTime;

  bool startTimeIsOccupied(DateTime? startDate, TimeOfDay? startTime) {
    if (startDate == null || startTime == null) {
      return true;
    }
    final DateTime startDateTime = DateTime(
      startDate.year,
      startDate.month,
      startDate.day,
      startTime.hour,
      startTime.minute,
    );
    return widget.bookings
        .where(
          (booking) =>
              booking.start.year == startDate.year &&
              booking.start.month == startDate.month &&
              booking.start.day == startDate.day &&
              booking.start.isBefore(startDateTime) &&
              booking.end.isAfter(startDateTime),
        )
        .isNotEmpty;
  }

  bool endTimeIsOccupied(DateTime? endDate, TimeOfDay? endTime) {
    if (endDate == null || endTime == null) {
      return true;
    }
    final DateTime endDateTime = DateTime(
      endDate.year,
      endDate.month,
      endDate.day,
      endTime.hour,
      endTime.minute,
    );
    print(endDateTime);
    print(widget.bookings);
    return widget.bookings
        .where(
          (booking) =>
              booking.end.year == endDateTime.year &&
              booking.end.month == endDateTime.month &&
              booking.end.day == endDateTime.day &&
              booking.start.isBefore(endDateTime) &&
              booking.end.isAfter(endDateTime),
        )
        .isNotEmpty;
  }

  bool meetingDateTimeIsDuplicated(
    DateTime? startDate,
    TimeOfDay? startTime,
    DateTime? endDate,
    TimeOfDay? endTime,
  ) {
    if (startDate == null ||
        startTime == null ||
        endDate == null ||
        endTime == null) {
      return true;
    }

    return widget.bookings
        .where(
          (booking) =>
              booking.start.year == startDate.year &&
              booking.start.month == startDate.month &&
              booking.start.day == startDate.day &&
              booking.start.hour == startTime.hour &&
              booking.start.minute == startTime.minute &&
              booking.end.year == endDate.year &&
              booking.end.month == endDate.month &&
              booking.end.day == endDate.day &&
              booking.end.hour == endTime.hour &&
              booking.end.minute == endTime.minute,
        )
        .isNotEmpty;
  }

  void onStartDateTap() async {
    final now = DateTime.now();
    var lastDate = now.add(Duration(days: 180));
    var firstDate = now;

    final dateFromUser = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (dateFromUser != null) {
      setState(() {
        startDate = dateFromUser;
        widget.controller.startDateController.text = formatDate(dateFromUser);
        endDate = dateFromUser;
        widget.controller.endDateController.text = formatDate(dateFromUser);
      });
    }
  }

  void onStartTimeTap() async {
    var initialTime = TimeOfDay.now();

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (pickedTime != null) {
      setState(() {
        startTime = pickedTime;
        if (startTime!.hour < 23) {
          endTime = pickedTime.replacing(hour: pickedTime.hour + 1);
          endDate = startDate;
        } else {
          endDate = DateTime(
            startDate!.year,
            startDate!.month,
            startDate!.day,
            startTime!.hour,
            startTime!.minute,
          ).add(Duration(hours: 1));
          endTime = TimeOfDay(hour: endDate!.hour, minute: endDate!.minute);

          widget.controller.endDateController.text = formatDate(endDate!);
        }
        widget.controller.endTimeController.text = formatTime(endTime!);
        widget.controller.startTimeController.text = formatTime(pickedTime);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.controller.formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Column(
          children: [
            TextFormField(
              controller: widget.controller.bookingMeetingNameController,
              onChanged: (value) => setState(() => bookingMeetingName = value),
              maxLines: 1,
              maxLength: 30,
              decoration: const InputDecoration(label: Text("Meeting title")),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter meeting title';
                }
                return null;
              },
            ),
            TextFormField(
              controller: widget.controller.bookingUserNameController,
              onChanged: (value) => setState(() => bookingUserName = value),
              maxLines: 1,
              maxLength: 15,
              decoration: const InputDecoration(
                label: Text("Booking User Name"),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter meeting title';
                }
                return null;
              },
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    onTap: onStartDateTap,
                    readOnly: true,
                    controller: widget.controller.startDateController,
                    decoration: InputDecoration(
                      label: Text('Meeting starts on'),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter meeting start date';
                      }
                      if (startTimeIsOccupied(startDate, startTime)) {
                        return 'Start time is occupied! Select other';
                      }
                      if (meetingDateTimeIsDuplicated(
                        startDate,
                        startTime,
                        endDate,
                        endTime,
                      )) {
                        return 'There is already a meeting for the selected time slot!';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(width: 16),
                SizedBox(
                  width: 100,
                  child: TextFormField(
                    onTap: onStartTimeTap,
                    readOnly: true,
                    controller: widget.controller.startTimeController,
                    decoration: InputDecoration(label: Text('At')),
                    validator: (value) {
                      if (startDate == null) {
                        return 'Please enter meeting start date first!';
                      }
                      if (value == null || value.isEmpty) {
                        return 'Please enter meeting start time';
                      }
                      if (startTimeIsOccupied(startDate, startTime)) {
                        return 'Start time is occupied! Select other';
                      }
                      if (meetingDateTimeIsDuplicated(
                        startDate,
                        startTime,
                        endDate,
                        endTime,
                      )) {
                        return 'There is already a meeting for the selected time slot!';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 50,),
            SizedBox(
              child: Text("End time is generated automatically"),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    onTap: () {},
                    readOnly: true,
                    controller: widget.controller.endDateController,
                    decoration: InputDecoration(
                      label: Text('Meeting ends on: '),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter meeting end date';
                      }
                      if (endTimeIsOccupied(endDate, endTime)) {
                        return 'End time falls into booked interval!';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(width: 16),
                SizedBox(
                  width: 100,
                  child: TextFormField(
                    onTap: () {},
                    readOnly: true,
                    controller: widget.controller.endTimeController,
                    decoration: InputDecoration(label: Text('At')),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter meeting end time';
                      }
                      if (endTimeIsOccupied(endDate, endTime)) {
                        return 'End time falls into booked interval!';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
