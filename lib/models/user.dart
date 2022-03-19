class User {
  User({
    required this.uId,
    required this.firstName,
    required this.lastName,
    required this.registerDate,
    required this.email,
    required this.dateOfBirth,
  });

  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      uId: data['uId'],
      firstName: data["firstName"],
      lastName: data["lastName"],
      registerDate: data["resgisterDate"].toDate(),
      email: data['email'],
      dateOfBirth: data['dateOfBirth'],
    );
  }

  final String uId;
  final String email;
  final String dateOfBirth;
  final String firstName;
  final String lastName;
  final DateTime registerDate;
}
