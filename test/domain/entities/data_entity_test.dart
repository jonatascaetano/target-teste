import 'package:flutter_test/flutter_test.dart';
import 'package:teste_tecnico_target/domain/entities/data_entity.dart';

void main() {
  group('DataEntity', () {
    test('Deve inicializar corretamente', () {
      const userId = 'user123';
      const data = 'Dados de teste';

      final dataEntity = DataEntity(userId, data);

      expect(dataEntity.userId, userId);
      expect(dataEntity.data, data);
    });

    test('Dois objetos DataEntity iguais devem ser considerados iguais', () {
      const userId = 'user123';
      const data = 'Dados de teste';

      final dataEntity1 = DataEntity(userId, data);
      final dataEntity2 = DataEntity(userId, data);

      expect(dataEntity1, equals(dataEntity2));
    });

    test('Dois objetos DataEntity diferentes devem ser considerados diferentes',
        () {
      const userId1 = 'user123';
      const data1 = 'Dados de teste 1';

      const userId2 = 'user456';
      const data2 = 'Dados de teste 2';

      final dataEntity1 = DataEntity(userId1, data1);
      final dataEntity2 = DataEntity(userId2, data2);

      expect(dataEntity1, isNot(equals(dataEntity2)));
    });
  });
}
