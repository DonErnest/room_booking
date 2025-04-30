import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:room_booking/models/booking.dart';

class BookingRow extends StatelessWidget {
  final Booking booking;

  const BookingRow({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    var textColor = Colors.grey.shade800;
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Text(
                booking.meetingName,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: textColor, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Text(
                booking.userName,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: textColor, fontWeight: FontWeight.bold),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Row(
              children: [
                Text(
                  "Начало: ${booking.start.toIso8601String()} \nКонец: ${booking.end.toIso8601String()}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: textColor, fontWeight: FontWeight.bold),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
