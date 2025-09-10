import 'game_object.dart';

class Obstacle extends GameObject {
  int damage = 0;
  Obstacle(double x, double y, this.damage) : super(x, y);

  void checkCollition() {
    print('checking the colition: $damage');
  }

  @override
  void render() {
    print('rendering object at: $x, $y');
  }

  @override
  void update() {
    checkCollition();
  }
}
