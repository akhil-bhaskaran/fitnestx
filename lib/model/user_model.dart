class UserProfile {
  final String id;
  final String name;
  final String email;
  final double height; // in cm
  final double weight; // in kg
  final int age;
  final String gender;

  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.height,
    required this.weight,
    required this.age,
    required this.gender,
  });
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'height': height,
      'weight': weight,
      'age': age,
      'gender': gender,
    };
  }

  factory UserProfile.fromMap(String id, Map<String, dynamic> map) {
    return UserProfile(
      id: id,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      height: (map['height'] ?? 0).toDouble(),
      weight: (map['weight'] ?? 0).toDouble(),
      age: map['age'] ?? 0,
      gender: map['gender'] ?? '',
    );
  }
}
