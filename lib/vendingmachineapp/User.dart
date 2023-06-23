class User {
  int user_ID;
  String first_name;
  String last_name;
  String email;



  User({
    required this.user_ID,
    required this.first_name,
    required this.last_name,
    required this.email,
  });

  static User? _loggedInUser;

  static User? get loggedInUser => _loggedInUser;

  static void saveLoggedInUser(User user) {
    _loggedInUser = user;
  }

  static User? getLoggedInUser() {
    return _loggedInUser;
  }

  static void deleteLoggedInUser() {
    _loggedInUser = null;
  }
}