enum UserRole { grandImam, imam, public }

class UserModel {
  final String id;
  final String name;
  final String email;
  final UserRole role;
  final List<String> assignedMosques;
  final String? phoneNumber;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.assignedMosques,
    this.phoneNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      role: UserRole.values.firstWhere(
        (role) => role.toString() == json['role'],
        orElse: () => UserRole.public,
      ),
      assignedMosques: List<String>.from(json['assignedMosques'] ?? []),
      phoneNumber: json['phoneNumber'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role.toString(),
      'assignedMosques': assignedMosques,
      'phoneNumber': phoneNumber,
    };
  }
}
