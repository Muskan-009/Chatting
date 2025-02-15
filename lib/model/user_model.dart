class User {
  final String id;
  final String name;
  final String imageUrl;

  User({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  // Factory constructor to create a User from Firestore data
  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      id: data['id'] ?? '', // Safely access data
      name: data['name'] ?? 'No name',
      imageUrl: data['image'] ?? '',
    );
  }

  // Convert a User instance to a Map (to save it in Firestore)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': imageUrl,
    };
  }
}
