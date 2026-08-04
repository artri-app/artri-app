enum BodyOptions {
  hands,
  arm,
  feet,
  shoulder,
  knee,
  hip,
  column,
  ankle;

  @override
  toString() {
    switch(this) {
      case BodyOptions.hands:
        return 'MÃOS';
      case BodyOptions.arm:
        return 'BRAÇO';
      case BodyOptions.feet:
        return 'PÉS';
      case BodyOptions.shoulder:
        return 'OMBRO';
      case BodyOptions.knee:
        return 'JOELHO';
      case BodyOptions.hip:
        return 'QUADRIL';
      case BodyOptions.column:
        return 'COLUNA';
      case BodyOptions.ankle:
        return 'TORNOZELO';
    }
  }
}