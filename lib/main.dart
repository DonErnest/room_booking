import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:room_booking/app_routes.dart';
import 'package:room_booking/providers/booking_provider.dart';

import 'booking.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (ctx) => NewBookingProvider(),
      child: MaterialApp(
        routes: {AppRoutes.home: (ctx) => BookingList()},
        initialRoute: AppRoutes.home,
        title: "Room Booking",
      ),
    ),
  );
}
