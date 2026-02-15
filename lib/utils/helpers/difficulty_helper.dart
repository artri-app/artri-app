class DifficultyHelper {
  static String? getDifficultyText(String? difficulty) {
    switch (difficulty) {
      case 'easy':
        return 'Iniciante';
      case 'medium':
        return 'Intermediário';
      case 'hard':
        return 'Avançado';
      default:
        return null;
    }
  }
}
