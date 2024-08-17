String? emailValidator(String? value) {
  if (value == null) {
    return null;
  }
  if (value.contains('@')) {
    return null;
  }
  return 'Please provide a valid email';
}
