enum TrainingType {
  hands,
  aerobic,
  mobility,
  feet,
  superiorBoost,
  inferiorBoost,
  coreBoost,
  stretching,
  custom;

  @override
  toString() {
    switch (this) {
      case TrainingType.hands:
        return 'MÃOS';
      case TrainingType.feet:
        return 'PÉS';
      case TrainingType.aerobic:
        return 'AERÓBICO';
      case TrainingType.mobility:
        return 'MOBILIDADE';
      case TrainingType.superiorBoost:
        return 'FORTALECIMENTO MEMBRO SUPERIOR';
      case TrainingType.inferiorBoost:
        return 'FORTALECIMENTO MEMBRO INFERIOR';
      case TrainingType.coreBoost:
        return 'FORTALECIMENTO CORE';
      case TrainingType.stretching:
        return 'ALONGAMENTO';
      case TrainingType.custom:
        return 'PERSONALIZADO';
    }
  }
}
