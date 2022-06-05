class User {
  final String id;
  final String name;
  final String email;
  User({
    required this.id,
    required this.name,
    required this.email,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['email'],
      name: json['id'],
      email: json['name'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
    };
  }
}
