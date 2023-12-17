  String formatNameFromEmail(String email) {
    List<String> parts = email.split('@');

    if (parts.length != 2 || parts[0].isEmpty) {
      return "Unknown";
    }

    String username = parts.first;
    List<String> firstpart = username.split('').toList();
    List<String> secondpart = username.split('').toList();

    firstpart.removeAt(firstpart.length - 1);

    String firstname = firstpart.join('')[0].toUpperCase() + firstpart.join('').substring(1);

    String lastname = secondpart.removeLast().toUpperCase();

    return "$firstname $lastname.";
  }