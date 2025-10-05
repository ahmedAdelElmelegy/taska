String getDuration(String start) {
  DateTime startDate = DateTime.parse(start);
  final now = DateTime.now();
  final difference = now.difference(startDate);
  if (difference.inHours < 1) {
    return '${difference.inMinutes} minutes ago';
  }
  if (difference.inHours < 24) {
    return '${difference.inHours} hours ago';
  }
  if (difference.inDays < 7) {
    return '${difference.inDays} days ago';
  }
  if (difference.inDays < 30) {
    return '${difference.inDays ~/ 7} weeks ago';
  }
  if (difference.inDays < 365) {
    return '${difference.inDays ~/ 30} months ago';
  } else {
    return '${difference.inDays ~/ 365} years ago';
  }
}
