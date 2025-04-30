import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:room_booking/providers/booking_provider.dart';
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bookingProvider = context.watch<NewBookingProvider>();
  }

  void openAddBookingSheet() {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (ctx) => Wrap(children: [
        BookingForm(),
      ]),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return ScreenCanvas(
      appBarActions: [
        IconButton(
          onPressed: openAddBookingSheet,
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        )
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
