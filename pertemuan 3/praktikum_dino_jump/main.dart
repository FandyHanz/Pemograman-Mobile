import 'Bird.dart';
import 'Ground.dart';
import 'Obstacle.dart';

import 'Cactus.dart';
import 'Dino.dart';
import 'game_object.dart';
import 'ScoreCounter.dart';

void main() {
  var dino = Dino(0, 50);
  var ground = Ground(0, 0);
  var cactus = Cactus(500, 50);
  var scoreCounter = ScoreCounter(800, 600);
  var bird = Bird(700, 100);

  List<GameObject> GameObjects = [dino, ground, scoreCounter, cactus, bird];
  for (var obj in GameObjects) {
    obj.update();
    obj.render();
  }
   dino.jump();
  bird.fly();
  scoreCounter.addScore(100);
  Obstacle genericObstacle = Bird(900, 150);
  genericObstacle.checkCollition();
  scoreCounter.render();
}
