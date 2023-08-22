String generateFakeString(
  int length,
) {
  if (length <= 0) {
    return '';
  }

  StringBuffer result = StringBuffer();
  for (int i = 0; i < length; i++) {
    result.write('a');
  }

  return result.toString();
}
