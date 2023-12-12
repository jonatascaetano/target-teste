import 'dart:convert';

class UserEntity {
  final String username;
  final String password;

  UserEntity({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
    };
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      username: map['username'],
      password: map['password'],
    );
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  factory UserEntity.fromJson(String jsonString) {
    Map<String, dynamic> map = jsonDecode(jsonString);
    return UserEntity.fromMap(map);
  }

  @override
  String toString() => 'User(username: $username, password: $password)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserEntity &&
        other.username == username &&
        other.password == password;
  }

  @override
  int get hashCode => username.hashCode ^ password.hashCode;
}
