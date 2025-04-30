import 'package:flutter/material.dart';
import 'package:room_booking/models/booking.dart';

class NewBookingProvider extends ChangeNotifier {
  List<Booking> _bookings = sampleBookings;

  List<Booking> get bookings => _bookings;

  void addBooking(Booking newBooking) {
    _bookings = [..._bookings, newBooking];
    notifyListeners();
  }
}
