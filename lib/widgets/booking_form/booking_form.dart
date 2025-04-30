import 'package:flutter/material.dart';
import 'package:room_booking/utils.dart';
import 'package:room_booking/widgets/booking_form/booking_form_controller.dart';

class BookingForm extends StatefulWidget {
  final BookingFormController controller;
  const BookingForm({super.key, required this.controller});

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

  void onStartDateTap() async {
    final now = DateTime.now();
    var lastDate = now;
    var firstDate = now.subtract(Duration(days: 365));

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
      });
    }
  }

  void onEndDateTap() async {
    final now = DateTime.now();
    var lastDate = now;
    var firstDate = now.subtract(Duration(days: 365));

    final dateFromUser = await showDatePicker(
      context: context,
      initialDate: endDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (dateFromUser != null) {
      setState(() {
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
        widget.controller.startTimeController.text = formatTime(pickedTime);
      });
    }
  }

  void onEndTimeTap() async {
    var initialTime = TimeOfDay.now();

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (pickedTime != null) {
      setState(() {
        endTime = pickedTime;
        widget.controller.endTimeController.text = formatTime(pickedTime);
      });
    }
  }

  @override
  void dispose() {
    bookingMeetingNameController.dispose();
    bookingUserNameController.dispose();
    startDateController.dispose();
    startTimeController.dispose();
    endDateController.dispose();
    endTimeController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: bookingMeetingNameController,
          onChanged: (value) => setState(() => bookingMeetingName = value),
          maxLines: 1,
          maxLength: 30,
          decoration: const InputDecoration(
            label: Text("Meeting title"),
          ),
        ),
        TextField(
          controller: bookingUserNameController,
          onChanged: (value) => setState(() => bookingUserName = value),
          maxLines: 10,
          decoration: const InputDecoration(
            label: Text("Booking User Name"),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                onTap: onStartDateTap,
                readOnly: true,
                controller: startDateController,
                decoration: InputDecoration(
                  label: Text('Meeting starts on'),
                ),
              ),
            ),
            SizedBox(width: 16),
            SizedBox(
              width: 100,
              child: TextField(
                onTap: onStartTimeTap,
                readOnly: true,
                controller: startTimeController,
                decoration: InputDecoration(
                  label: Text('At'),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                onTap: onEndDateTap,
                readOnly: true,
                controller: endDateController,
                decoration: InputDecoration(
                  label: Text('Meeting ends on: '),
                ),
              ),
            ),
            SizedBox(width: 16),
            SizedBox(
              width: 100,
              child: TextField(
                onTap: onEndTimeTap,
                readOnly: true,
                controller: endTimeController,
                decoration: InputDecoration(
                  label: Text('At'),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
