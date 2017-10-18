class Sequence {
  boolean turnSequenceActivate = false;
  int sequenceTriggerIndex = 0;
  boolean bangSequence = false;
  int turnSequenceIndex = 0;
  int turnSequenceCount = 0;
  int turnSequenceCountLimit = 5;
  int[][] sequenceSet;
  int[] sequence;
  int signal = 0;
  boolean bang = false;

  Sequence(int[][] _ss) {
    init(_ss);
  }
  Sequence(int[][] _ss, int _l) {
    init(_ss);
    turnSequenceCountLimit = _l;
  }
  void init(int[][] _ss) {
    sequenceSet = _ss;
  }

  void trigger() {
    trigger(sequenceTriggerIndex);
  }
  void trigger(int index) {
    if (index == sequenceTriggerIndex) {
      turnSequenceActivate = !turnSequenceActivate;
    } else {
      turnSequenceActivate = true;
    }

    sequenceTriggerIndex = index;
    sequence = sequenceSet[index%sequenceSet.length];
    turnSequenceIndex = 0;
    turnSequenceCount = 0;
  }
  void bang(int index) {
    trigger(index);
    bangSequence = true;
  }
  void update() {
    if (turnSequenceActivate) {
      turnSequenceCount++;
      if (turnSequenceCount > turnSequenceCountLimit) {


        bang = true;
        signal = sequence[turnSequenceIndex];
        turnSequenceIndex = (turnSequenceIndex + 1) % sequence.length;
        turnSequenceCount = 0;

        if (bangSequence && turnSequenceIndex == 0) {
          trigger();
          bangSequence = false;
        }
      } else {
        bang = false;
      }
    } else {
      bang = false;
    }
  }
  boolean getBang() {
    return bang;
  }
  int getSignal() {
    return signal;
  }
}
