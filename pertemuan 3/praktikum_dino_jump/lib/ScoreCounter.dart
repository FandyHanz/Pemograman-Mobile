class ScoreCounter {
  int _score = 0;
  int get score => _score;
  void increment() => _score++;
  void reset() => _score = 0;
  void render() {
    print('Score: $_score');
  }
}
