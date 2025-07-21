class LogEntry {
  final String id;
  final String note;
  final String date;

  LogEntry({
    required this.id,
    required this.note,
    required this.date,
  });

  factory LogEntry.fromJson(Map<String, dynamic> json) {
    return LogEntry(
      id: json['id'],
      note: json['note'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'note': note,
        'date': date,
      };
}
