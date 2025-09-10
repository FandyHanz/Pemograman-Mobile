import 'Obstacle.dart';

class Bird extends Obstacle{
  Bird(double x, double y):super(x,y,20);

  void fly(){
    print('bird flying');
  }
}