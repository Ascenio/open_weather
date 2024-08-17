import 'package:flutter_test/flutter_test.dart';
import 'package:open_weather/weather/domain/either.dart';

void main() {
  group('Left', () {
    test('should have equality', () {
      expect(
          const Left<String, int>('error'), const Left<String, int>('error'));
    });

    test('should have hashCode equality', () {
      expect(const Left<String, int>('error').hashCode,
          const Left<String, int>('error').hashCode);
    });
  });

  group('Right', () {
    test('should have equality', () {
      expect(const Right<String, int>(42), const Right<String, int>(42));
    });

    test('should have hashCode equality', () {
      expect(const Right<String, int>(42).hashCode,
          const Right<String, int>(42).hashCode);
    });
  });
}
