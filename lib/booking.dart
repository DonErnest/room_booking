import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:room_booking/app_routes.dart';
import 'package:room_booking/providers/booking_provider.dart';
import 'package:room_booking/screens/booking_screen.dart';
import 'package:room_booking/widgets/booking_form/booking_form_controller.dart';
import 'package:room_booking/widgets/booking_row.dart';
import 'package:room_booking/widgets/canvas.dart';

import 'widgets/booking_form/booking_form.dart';

class BookingList extends StatefulWidget {
  const BookingList({super.key});

  @override
  State<BookingList> createState() => _BookingListState();
}

class _BookingListState extends State<BookingList> {
  late NewBookingProvider bookingProvider;
  final bookingController = BookingFormController();

  @override
  void dispose() {
    super.dispose();
    bookingController.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bookingProvider = context.watch<NewBookingProvider>();
  }

  void goToBookingScreen() {
    // I don't user ExpansionTile and there is no place where I could set
    // maintainState to True except for this, so, no pushNamed
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BookingScreen(),
        maintainState: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenCanvas(
      appBarActions: [
        IconButton(onPressed: goToBookingScreen, icon: const Icon(Icons.add)),
      ],
      widgets: [
        Expanded(
          child: ListView.builder(
            itemBuilder:
                (ctx, idx) =>
                    BookingRow(booking: bookingProvider.bookings[idx]),
            itemCount: bookingProvider.bookings.length,
          ),
        ),
      ],
    );
  }
}
