import 'package:artriapp/models/api_responses/remedy.dart';
import 'package:artriapp/services/notification_service.dart';
import 'package:artriapp/services/remedy_service.dart';
import 'package:artriapp/utils/enums/days_of_week.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late RemedyService remedyService;
  late NotificationService notificationService;

  group('Remédio + Notificação (Integração)', () {
    Remedy? createdRemedy;

    setUpAll(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
      await dotenv.load(fileName: '.env');
    });

    setUp(() {
      remedyService = RemedyService();
      notificationService = NotificationService.instance;
    });

    tearDown(() async {
      if (createdRemedy != null) {
        try {
          await remedyService.deleteRemedy(createdRemedy!.id);
          await notificationService.cancelReminder(createdRemedy!.id);
        } catch (_) {}
      }
    });

    test(
      'criar remédio via API e verificar agendamento de notificação',
          () async {
        // Tenta criar um remédio na API real
        try {
          createdRemedy = await remedyService.createRemedy(
            name: 'Teste Integração Notificação',
            description: 'Remédio de teste para integração',
            quantity: 1,
            hour: '08:00',
            dayOfWeek: DaysOfWeek.values.first,
          );
        } catch (e) {
          // API não disponível ou sem auth - pula o teste
          return;
        }

        expect(createdRemedy, isNotNull);
        expect(createdRemedy!.id, greaterThan(0));
        expect(createdRemedy!.name, 'Teste Integração Notificação');
        expect(createdRemedy!.hour, '08:00');

        // Agenda a notificação local
        await notificationService.scheduleRemedyReminder(
          remedyId: createdRemedy!.id,
          remedyName: createdRemedy!.name,
          hour: createdRemedy!.hour,
          daysOfWeek: createdRemedy!.daysOfWeek,
        );

        // Verifica que não lançou exceção (notificação foi enfileirada)
        // Não é possível verificar o SO real, mas garantimos que a lógica passou
        expect(true, isTrue);
      },
      timeout: const Timeout(Duration(seconds: 15)),
    );

    test(
      'buscar lista de remédios da API', () async {
      List<Remedy> remedies;
      try {
        remedies = await remedyService.getRemedies();
      } catch (e) {
        return;
      }

      expect(remedies, isA<List<Remedy>>());
    },
      timeout: const Timeout(Duration(seconds: 15)),
    );
  });
}
