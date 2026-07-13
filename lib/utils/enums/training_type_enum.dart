enum TrainingType {
  hands,
  aerobic,
  mobility,
  feet,
  superiorBoost,
  inferiorBoost,
  coreBoost,
  stretching;


/*
Tipos de treino no backend:

- técnicas de relaxamento
- relaxamento e alongamento
- MÃOS
- PÉS
- MOBILIDADE
- AQUECIMENTO
- PERNAS
- BRAÇOS
- TRONCO
- ALONGAMENTO
*/

  @override
  toString() {
    switch (this) {
      case TrainingType.hands:
        return 'MÃOS';
      case TrainingType.feet:
        return 'PÉS';
      case TrainingType.aerobic:
        return 'AQUECIMENTO';
      case TrainingType.mobility:
        return 'MOBILIDADE';
      case TrainingType.superiorBoost:
        return 'BRAÇOS';
      case TrainingType.inferiorBoost:
        return 'PERNAS';
      case TrainingType.coreBoost:
        return 'TRONCO';
      case TrainingType.stretching:
        return 'ALONGAMENTO';
    }
  }
}

