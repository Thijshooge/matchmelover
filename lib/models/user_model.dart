class UserModel {
  final String uid;
  final String name;
  final String? username;
  final int age;
  final String email;
  final String? phoneNumber;
  final DateTime birthDate;
  final DateTime createdAt;

  final DateTime? updatedAt;

  UserModel({
    required this.uid,
    required this.name,
    this.username,
    required this.age,
    required this.email,
    this.phoneNumber,
    required this.birthDate,
    required this.createdAt,

    this.updatedAt,
  });

  Map<String, dynamic> toGebruikerInfoMap() {
    return {
      'naam': name,
      'gebruikersnaam': username,
      'leeftijd': age,
      'email': email,
      'telefoonnummer': phoneNumber,
      'geboorte datum': birthDate.toIso8601String(),
      'datum van aanmaak': createdAt.toIso8601String(),

      'bijgewerkt op': updatedAt?.toIso8601String(),
    };
  }

  factory UserModel.fromMap(String uid, Map<String, dynamic> map) {
    return UserModel(
      uid: uid,
      name: map['naam'] ?? '',
      username: map['gebruikersnaam'],
      age: map['leeftijd'] ?? 0,
      email: map['email'] ?? '',
      phoneNumber: map['telefoonnummer'],
      birthDate: DateTime.parse(map['geboorte datum']),
      createdAt: DateTime.parse(map['datum van aanmaak']),

      updatedAt: map['bijgewerkt op'] != null
          ? DateTime.parse(map['bijgewerkt op'])
          : null,
    );
  }

  // Copy with methode om updates te maken
  UserModel copyWith({
    String? name,
    String? username,
    String? phoneNumber,
    String? bio,
    List<String>? photoUrls,
    DateTime? updatedAt,
  }) {
    return UserModel(
      uid: uid,
      name: name ?? this.name,
      username: username ?? this.username,
      age: age,
      email: email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      birthDate: birthDate,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
