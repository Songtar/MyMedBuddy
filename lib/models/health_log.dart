class HealthLog {
  final String id;
  final String title;
  final String description;
  final String date;
  final String time;

  HealthLog({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
  });

  factory HealthLog.fromJson(Map<String, dynamic> json) {
    return HealthLog(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: json['date'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'date': date,
    'time': time,
  };
}
