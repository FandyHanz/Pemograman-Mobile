import 'game_object.dart';

class ScoreCounter extends GameObject {
   int score = 0;
  ScoreCounter(double x, double y):super(x,y);

  void addScore(int point){
    this.score += point;

  }

  @override
  void render(){
    print('Score: $score');
  }

  @override
  void update(){
    print('update score');
  }

}
