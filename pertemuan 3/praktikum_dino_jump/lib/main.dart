import 'Cactus.dart';
import 'Dino.dart';
import 'game_object.dart';
import 'ScoreCounter.dart';

void main() {
  var dino = Dino(0, 0);
  var cactus = Cactus(10, 0);
  var scoreCounter = ScoreCounter();

  List<GameObject> GameObjects = [dino, cactus];
  for (var obj in GameObjects) {
    obj.update();
    obj.render();
  }
  dino.jump();
  cactus.move();
  scoreCounter.increment();
  scoreCounter.render();
}
