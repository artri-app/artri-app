class TrainingReport {
  final String id;
  final DateTime date;
  final String userId;
  final int trainingId;

  TrainingReport({
    required this.id,
    required this.userId,
    required this.date,
    required this.trainingId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'user': userId,
      'training': trainingId,
    };
  }

  TrainingReport fromMap(Map<String, dynamic> map) {
    return TrainingReport(
      id: map['id'],
      date: DateTime.parse(map['date']),
      userId: map['user'],
      trainingId: map['training'],
    );
  }
}
