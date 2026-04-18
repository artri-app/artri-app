import 'package:artriapp/models/index.dart';
import 'package:artriapp/services/index.dart';
import 'package:artriapp/utils/enums/index.dart';
import 'package:artriapp/utils/index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([http.Client, Environment])
void main() async {
  var service = PhysicalExercisesService();
  group('Physical exercises service', () {
    when().thenAnswer(
      (_) async => [
        Training(
          id: 1,
          name: 'MÃOS - INICIANTE',
          description: 'Description 1',
          difficulty: ExerciseDifficulty.easy,
          exercises: [],
        ),
        Training(
          id: 1,
          name: 'MÃOS - INTERMEDIÁRIO',
          description: 'Description 1',
          difficulty: ExerciseDifficulty.medium,
          exercises: [],
        ),
        Training(
          id: 1,
          name: 'MÃOS - AVANÇADO',
          description: 'Description 1',
          difficulty: ExerciseDifficulty.hard,
          exercises: [],
        ),
        Training(
          id: 1,
          name: 'PÉS MOBILIDADE - INICIANTE',
          description: 'Description 1',
          difficulty: ExerciseDifficulty.easy,
          exercises: [],
        ),
        Training(
          id: 1,
          name: 'PÉS MOBILIDADE - INTERMEDIÁRIO',
          description: 'Description 1',
          difficulty: ExerciseDifficulty.medium,
          exercises: [],
        ),
        Training(
          id: 1,
          name: 'PÉS MOBILIDADE - AVANÇADO',
          description: 'Description 1',
          difficulty: ExerciseDifficulty.hard,
          exercises: [],
        ),
        Training(
          id: 1,
          name: 'PÉS FORTALECIMENTO - INICIANTE',
          description: 'Description 1',
          difficulty: ExerciseDifficulty.easy,
          exercises: [],
        ),
        Training(
          id: 1,
          name: 'PÉS FORTALECIMENTO - INTERMEDIÁRIO',
          description: 'Description 1',
          difficulty: ExerciseDifficulty.medium,
          exercises: [],
        ),
        Training(
          id: 1,
          name: 'PÉS FORTALECIMENTO - AVANÇADO',
          description: 'Description 1',
          difficulty: ExerciseDifficulty.hard,
          exercises: [],
        ),
      ],
    );
    test('get trainings that boost feet', () async {
      var feetTraingings =
          await service.getTrainingsFrom(TrainingType.feetBoost);

      expect(feetTraingings.length, 3);
    });
    test('get hand trainings', () async {
      var feetTraingings = await service.getTrainingsFrom(TrainingType.hands);

      expect(feetTraingings.length, 3);
    });
    test('get feet mobility trainings', () async {
      var feetTraingings =
          await service.getTrainingsFrom(TrainingType.feetMobility);

      expect(feetTraingings.length, 3);
    });
  });
}
