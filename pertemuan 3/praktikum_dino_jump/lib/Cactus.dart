import 'package:praktikum_dino_jump/game_object.dart';

class Cactus extends GameObject {
  Cactus(double x, double y) : super(x, y);

  @override
  void move() {
    print('Cactus is moving to the left...');
  }

  @override
  void render() {
    print('Rendering Cactus at position ($x, $y)');
  }

  @override
  void update() {
    move();
  }
}
