import 'package:praktikum_dino_jump/Cactus.dart';
import 'package:praktikum_dino_jump/Dino.dart';
import 'package:praktikum_dino_jump/game_object.dart';

void main() {
  var dino = Dino(0, 0);
  var cactus = Cactus(10, 0);

  List<GameObject> GameObjects = [dino, cactus];
  for (var obj in GameObjects) {
    obj.update();
    obj.render();
  }
// Trigger specific behavior
  dino.jump();
}
