import 'game_object.dart';

class Ground extends GameObject{
  Ground(double x, double y):super(x,y);

  void move(){
    print('Ground is moving to the left...');
  }

  @override
  void render(){
    print('Ground now at position ($x, $y)');
  }

  @override
  void update(){
    move();
  }
}