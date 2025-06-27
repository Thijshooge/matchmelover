class ProfileModel {
  final String uid;
  final String? bio;
  final String? gender;
  final String? lookingFor;
  final int? height;
  final String? language;
  final String? location;
  final String? smoking;
  final String? sport;
  final String? travel;
  final String? party;
  final String? zodiac;
  final DateTime createdAt;
  final DateTime? updatedAt;

  ProfileModel({
    required this.uid,
    this.bio,
    this.gender,
    this.lookingFor,
    this.height,
    this.language,
    this.location,
    this.smoking,
    this.sport,
    this.travel,
    this.party,
    this.zodiac,
    required this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'bio': bio,
      'gender': gender,
      'looking_for': lookingFor,
      'height': height,
      'language': language,
      'location': location,
      'smoking': smoking,
      'sport': sport,
      'travel': travel,
      'party': party,
      'zodiac': zodiac,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  factory ProfileModel.fromMap(String uid, Map<String, dynamic> map) {
    return ProfileModel(
      uid: uid,
      bio: map['bio'],
      gender: map['gender'],
      lookingFor: map['looking_for'],
      height: map['height'],
      language: map['language'],
      location: map['location'],
      smoking: map['smoking'],
      sport: map['sport'],
      travel: map['travel'],
      party: map['party'],
      zodiac: map['zodiac'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'])
          : null,
    );
  }

  ProfileModel copyWith({
    String? bio,
    String? gender,
    String? lookingFor,
    int? height,
    String? language,
    String? location,
    String? smoking,
    String? sport,
    String? travel,
    String? party,
    String? zodiac,
    DateTime? updatedAt,
  }) {
    return ProfileModel(
      uid: uid,
      bio: bio ?? this.bio,
      gender: gender ?? this.gender,
      lookingFor: lookingFor ?? this.lookingFor,
      height: height ?? this.height,
      language: language ?? this.language,
      location: location ?? this.location,
      smoking: smoking ?? this.smoking,
      sport: sport ?? this.sport,
      travel: travel ?? this.travel,
      party: party ?? this.party,
      zodiac: zodiac ?? this.zodiac,
      createdAt: createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }
}
