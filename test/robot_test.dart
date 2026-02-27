// import 'package:my_first_project/robot.dart';
// import 'package:test/test.dart';

// main() {
//   test('Move robot - Case 1', () {
//     Robot robot = Robot(x: 7, y: 3, direction: Direction.north);
//     robot.process(Action.parse("RAALAL"));

//     print("Final state = $robot");

//     expect(robot.x, equals(9));
//     expect(robot.y, equals(4));
//     expect(robot.direction, equals(Direction.west));
//   });

//   test('Move robot - Case 2', () {
//     Robot robot = Robot(x: 0, y: 0, direction: Direction.east);
//     robot.process(Action.parse("LAAARALA"));

//     print("Final state = $robot");

//     expect(robot.x, equals(1));
//     expect(robot.y, equals(4));
//     expect(robot.direction, equals(Direction.north));
//   });

//   test('Move robot - Case 3', () {
//     Robot robot = Robot(x: 2, y: 5, direction: Direction.south);
//     robot.process(Action.parse("RRAAAAALA"));

//     print("Final state = $robot");

//     expect(robot.x, equals(1));
//     expect(robot.y, equals(10));
//     expect(robot.direction, equals(Direction.west));
//   });

//   test('Move robot - Case 4', () {
//     Robot robot = Robot(x: 5, y: 5, direction: Direction.west);
//     robot.process(Action.parse("AAAA"));

//     print("Final state = $robot");

//     expect(robot.x, equals(1));
//     expect(robot.y, equals(5));
//     expect(robot.direction, equals(Direction.west));
//   });

//   test('Move robot - Case 5', () {
//     Robot robot = Robot(x: 3, y: 3, direction: Direction.north);
//     robot.process(Action.parse("AAAA"));

//     print("Final state = $robot");

//     expect(robot.x, equals(3));
//     expect(robot.y, equals(7));
//     expect(robot.direction, equals(Direction.north));
//   });
// }
