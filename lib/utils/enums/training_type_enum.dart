enum TrainingType {
  hands,
  aerobic,
  mobility,
  feetMobility,
  feetBoost,
  superiorBoost,
  inferiorBoost,
  coreBoost,
  feetStretching,
  stretching;

  @override
  toString() {
    switch (this) {
      case TrainingType.hands:
        return 'MÃOS';
      case TrainingType.aerobic:
        return 'AERÓBICO';
      case TrainingType.mobility:
        return 'MOBILIDADE';
      case TrainingType.feetMobility:
        return 'PÉS MOBILIDADE';
      case TrainingType.feetBoost:
        return 'PÉS FORTALECIMENTO';
      case TrainingType.superiorBoost:
        return 'FORTALECIMENTO MEMBRO SUPERIOR';
      case TrainingType.inferiorBoost:
        return 'FORTALECIMENTO MEMBRO INFERIOR';
      case TrainingType.coreBoost:
        return 'FORTALECIMENTO CORE';
      case TrainingType.feetStretching:
        return 'PÉS ALONGAMENTO';
      case TrainingType.stretching:
        return 'ALONGAMENTO';
    }
  }
}
