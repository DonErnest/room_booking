import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:room_booking/app_routes.dart';
import 'package:room_booking/providers/booking_provider.dart';
import 'package:room_booking/screens/booking_screen.dart';
import 'package:room_booking/screens/not_found_screen.dart';

import 'booking.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (ctx) => NewBookingProvider(),
      child: MaterialApp(
        routes: {
          AppRoutes.home: (ctx) => BookingList(),
          AppRoutes.bookForm: (ctx) => BookingScreen(),
        },
        initialRoute: AppRoutes.home,
        title: "Room Booking",
        onUnknownRoute:
          (s) => MaterialPageRoute(builder: (ctx) => NotFoundScreen()),
      ),
    ),
  );
}
