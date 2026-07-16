class RemedyIntake {
  final int id;
  final int remedyId;
  final String date;

  RemedyIntake({
    required this.id,
    required this.remedyId,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'remedy': remedyId,
      'date': date,
    };
  }

  factory RemedyIntake.fromMap(Map<String, dynamic> map) {
    return RemedyIntake(
      id: map['id'],
      remedyId: map['remedy'],
      date: map['date'],
    );
  }
}
