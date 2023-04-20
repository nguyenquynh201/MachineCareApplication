class AuthEntity {
   String? accessToken;
   String? refreshToken;

  AuthEntity({
     this.accessToken,
     this.refreshToken,
  });

  factory AuthEntity.fromJson(Map<String, dynamic> json) {
    return AuthEntity(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'accessToken' : accessToken,
      'refreshToken' : refreshToken,
    };
  }
}
