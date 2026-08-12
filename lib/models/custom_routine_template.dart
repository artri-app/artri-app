class TemplateCategory {
  final String key;
  final String title;
  final int requiredCount;
  final String prepText;
  final String prompt;

  const TemplateCategory({
    required this.key,
    required this.title,
    required this.requiredCount,
    required this.prepText,
    required this.prompt,
  });
}

class CustomRoutineTemplate {
  final String id;
  final String level;
  final List<TemplateCategory> categories;

  const CustomRoutineTemplate({
    required this.id,
    required this.level,
    required this.categories,
  });

  static final Map<String, CustomRoutineTemplate> _mockTemplates = {
    'iniciante': CustomRoutineTemplate(
      id: 'beginner',
      level: 'Iniciante',
      categories: const [
        TemplateCategory(
          key: 'mobilidade', title: 'Mobilidade',
          requiredCount: 2, prepText: 'de mobilidade',
          prompt: 'Selecione 2 exercícios de mobilidade:',
        ),
        TemplateCategory(
          key: 'aquecimento', title: 'Aquecimento',
          requiredCount: 2, prepText: 'de aquecimento',
          prompt: 'Selecione 2 exercícios de aquecimento:',
        ),
        TemplateCategory(
          key: 'pernas', title: 'Pernas',
          requiredCount: 2, prepText: 'para as pernas',
          prompt: 'Selecione 2 exercícios para as pernas:',
        ),
        TemplateCategory(
          key: 'bracos', title: 'Braços',
          requiredCount: 2, prepText: 'para os braços',
          prompt: 'Selecione 2 exercícios para os braços:',
        ),
        TemplateCategory(
          key: 'tronco', title: 'Tronco',
          requiredCount: 2, prepText: 'para o tronco',
          prompt: 'Selecione 2 exercícios para o tronco:',
        ),
        TemplateCategory(
          key: 'alongamento', title: 'Alongamento',
          requiredCount: 2, prepText: 'de alongamento',
          prompt: 'Selecione 2 exercícios de alongamento:',
        ),
      ],
    ),
    'intermediario': CustomRoutineTemplate(
      id: 'intermediate',
      level: 'Intermediário',
      categories: const [
        TemplateCategory(
          key: 'mobilidade', title: 'Mobilidade',
          requiredCount: 2, prepText: 'de mobilidade',
          prompt: 'Selecione 2 exercícios de mobilidade:',
        ),
        TemplateCategory(
          key: 'aquecimento', title: 'Aquecimento',
          requiredCount: 3, prepText: 'de aquecimento',
          prompt: 'Selecione 3 exercícios de aquecimento:',
        ),
        TemplateCategory(
          key: 'pernas', title: 'Pernas',
          requiredCount: 3, prepText: 'para as pernas',
          prompt: 'Selecione 3 exercícios para as pernas:',
        ),
        TemplateCategory(
          key: 'bracos', title: 'Braços',
          requiredCount: 3, prepText: 'para os braços',
          prompt: 'Selecione 3 exercícios para os braços:',
        ),
        TemplateCategory(
          key: 'tronco', title: 'Tronco',
          requiredCount: 3, prepText: 'para o tronco',
          prompt: 'Selecione 3 exercícios para o tronco:',
        ),
        TemplateCategory(
          key: 'alongamento', title: 'Alongamento',
          requiredCount: 2, prepText: 'de alongamento',
          prompt: 'Selecione 2 exercícios de alongamento:',
        ),
      ],
    ),
    'avancado': CustomRoutineTemplate(
      id: 'advanced',
      level: 'Avançado',
      categories: const [
        TemplateCategory(
          key: 'mobilidade', title: 'Mobilidade',
          requiredCount: 2, prepText: 'de mobilidade',
          prompt: 'Selecione 2 exercícios de mobilidade:',
        ),
        TemplateCategory(
          key: 'aquecimento', title: 'Aquecimento',
          requiredCount: 3, prepText: 'de aquecimento',
          prompt: 'Selecione 3 exercícios de aquecimento:',
        ),
        TemplateCategory(
          key: 'pernas', title: 'Pernas',
          requiredCount: 4, prepText: 'para as pernas',
          prompt: 'Selecione 4 exercícios para as pernas:',
        ),
        TemplateCategory(
          key: 'bracos', title: 'Braços',
          requiredCount: 4, prepText: 'para os braços',
          prompt: 'Selecione 4 exercícios para os braços:',
        ),
        TemplateCategory(
          key: 'tronco', title: 'Tronco',
          requiredCount: 4, prepText: 'para o tronco',
          prompt: 'Selecione 4 exercícios para o tronco:',
        ),
        TemplateCategory(
          key: 'alongamento', title: 'Alongamento',
          requiredCount: 3, prepText: 'de alongamento',
          prompt: 'Selecione 3 exercícios de alongamento:',
        ),
      ],
    ),
  };

  static CustomRoutineTemplate mock(String level) {
    return _mockTemplates[level] ?? _mockTemplates['iniciante']!;
  }
}
