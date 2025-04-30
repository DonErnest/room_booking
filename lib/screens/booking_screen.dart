import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:room_booking/providers/booking_provider.dart';
import 'package:room_booking/widgets/booking_form/booking_form.dart';
import 'package:room_booking/widgets/booking_form/booking_form_controller.dart';
import 'package:room_booking/widgets/canvas.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  late NewBookingProvider bookingProvider;
  final bookingFormController = BookingFormController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bookingProvider = context.watch<NewBookingProvider>();
  }

  void addBooking() {
    if (bookingFormController.formKey.currentState!.validate()) {
      final booking = bookingFormController.getBooking();
      bookingProvider.addBooking(booking);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    super.dispose();
    bookingFormController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenCanvas(
      widgets: [
        BookingForm(
          controller: bookingFormController,
          bookings: bookingProvider.bookings,
        ),
        TextButton(onPressed: addBooking, child: Text("Book room")),
      ],
    );
  }
}
