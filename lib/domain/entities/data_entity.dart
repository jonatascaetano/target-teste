class DataEntity {
  final String userId;
  final String data;

  DataEntity(this.userId, this.data);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DataEntity && other.userId == userId && other.data == data;
  }

  @override
  int get hashCode => userId.hashCode ^ data.hashCode;
}
