class CustomUser {
  final String email;
  final String password;
  final String username;
  final String bio;
  final String photoUrl;
  final List followers;
  final List following;

  const CustomUser({
    required this.email,
    required this.password,
    required this.username,
    required this.bio,
    required this.photoUrl,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'username': username,
        'bio': bio,
        'photoUrl': photoUrl,
        'followers': [], // list of uids
        'following': [], // list of uids
      };
}
