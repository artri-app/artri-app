enum DiaryOptions {
  fatigue,
  pain,
  sleep,
  swelling;

  @override
  toString() {
    switch(this) {
      case DiaryOptions.fatigue:
        return 'Fadiga';
      case DiaryOptions.pain:
        return 'Dor';
      case DiaryOptions.sleep:
        return 'Sono';
      case DiaryOptions.swelling:
        return 'Inchaço';
    }
  }
}