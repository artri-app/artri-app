import 'package:flutter/material.dart';
import 'package:artriapp/models/api_responses/remedy.dart';


class RemedyViewModel extends ChangeNotifier {
  List<Remedy> _allRemedies = [];
  List<Remedy> get remedies => _allRemedies;
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Mapa local para o checklist da sessão (como o back não tem 'taken', 
  // controlamos no front para o usuário se organizar no dia)
  final Map<int, bool> _checklistStatus = {};

  bool isTaken(int id) => _checklistStatus[id] ?? false;

  void toggleTaken(int id) {
    _checklistStatus[id] = !isTaken(id);
    notifyListeners();
  }

  Future<void> fetchRemedies() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Aqui você usaria seu cliente HTTP (Dio/Http) configurado no AuthService/SecurityTokenService
      // Exemplo genérico baseado na sua estrutura:
      // final response = await api.get('/remedy/');
      // _allRemedies = (response.data as List).map((e) => Remedy.fromJson(e)).toList();
      
      // Dados mockados para teste enquanto você não pluga a URL final:
      await Future.delayed(const Duration(seconds: 1));
      _allRemedies = [
        Remedy(id: 1, name: 'Metotrexato', description: 'Tomar após o café da manhã.', quantity: 15, hour: '08:00', user: 1, daysOfWeek: const []),
        Remedy(id: 2, name: 'Ácido Fólico', description: 'Uso semanal conforme orientação médica.', quantity: 5, hour: '08:00', user: 1, daysOfWeek: const []),
        Remedy(id: 3, name: 'Prednisona', description: 'Tomar após o almoço.', quantity: 5, hour: '12:00', user: 1, daysOfWeek: const []),
      ];
    } catch (e) {
      debugPrint('Erro ao buscar medicamentos: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}