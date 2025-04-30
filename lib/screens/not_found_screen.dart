import 'package:flutter/material.dart';
import 'package:room_booking/widgets/canvas.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenCanvas(
      widgets: [
        Text("No route has been found (as backend developer, this is 404)"),
      ],
    );
  }
}
