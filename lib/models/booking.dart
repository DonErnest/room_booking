import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Booking {
  final String id;

  final String userName;
  final String meetingName;

  final DateTime start;
  final DateTime end;

  const Booking({
    required this.id,
    required this.userName,
    required this.meetingName,
    required this.start,
    required this.end,
  });

  Booking copyWith({
    String? id,
    String? userName,
    String? meetingName,
    DateTime? start,
    DateTime? end,
  }) {
    return Booking(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      meetingName: meetingName ?? this.meetingName,
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }
}

final sampleBookings = List<Booking>.from([
  Booking(
    id: uuid.v4(),
    userName: "Belmek",
    meetingName: "How to bit the shit",
    start: DateTime(2025, 4, 30, 10, 0),
    end: DateTime(2025, 4, 30, 11, 0),
  ),
]);
