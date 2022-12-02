extension StringExtension on String {
  bool isEmailValid() {
    final regex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    return regex.hasMatch(this);
  }
}
