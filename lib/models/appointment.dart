class Appointment {
  final String id;
  final String doctor;
  final String date;
  final String time;

  Appointment({
    required this.id,
    required this.doctor,
    required this.date,
    required this.time,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      doctor: json['doctor'],
      date: json['date'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'doctor': doctor,
        'date': date,
        'time': time,
      };
}
