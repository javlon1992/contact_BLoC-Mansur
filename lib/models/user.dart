class User implements Comparable<User> {
  String name;
  String phoneNumber;
  bool isFovorite;

  User(
      {required this.name, required this.phoneNumber, this.isFovorite = false});

  bool operator ==(Object object) {
    return (object is User) &&
        (object.name == name) &&
        (object.phoneNumber == phoneNumber);
  }

  @override
  int compareTo(User other) {
    return isFovorite.hashCode.compareTo(other.isFovorite.hashCode);
  }
}
