import 'package:flutter_test/flutter_test.dart';
import 'package:teste_tecnico_target/domain/entities/user_entity.dart';

void main() {
  group('UserEntity', () {
    test('Deve serializar para JSON corretamente', () {
      final user = UserEntity(username: 'test_user', password: 'test_password');

      final jsonString = user.toJson();

      expect(jsonString, '{"username":"test_user","password":"test_password"}');
    });

    test('Deve desserializar a partir de JSON corretamente', () {
      const jsonString = '{"username":"test_user","password":"test_password"}';

      final user = UserEntity.fromJson(jsonString);

      expect(user.username, 'test_user');
      expect(user.password, 'test_password');
    });

    test('Dois objetos UserEntity iguais devem ser considerados iguais', () {
      final user1 =
          UserEntity(username: 'test_user', password: 'test_password');
      final user2 =
          UserEntity(username: 'test_user', password: 'test_password');

      expect(user1, equals(user2));
    });

    test('Dois objetos UserEntity diferentes devem ser considerados diferentes',
        () {
      final user1 =
          UserEntity(username: 'test_user', password: 'test_password');
      final user2 = UserEntity(
          username: 'different_user', password: 'different_password');

      expect(user1, isNot(equals(user2)));
    });
  });
}
