enum NewsCategory {
  technology,
  business,
  sports,
  entertainment;

  String get value {
    switch (this) {
      case NewsCategory.technology:
        return 'technology';
      case NewsCategory.business:
        return 'business';
      case NewsCategory.sports:
        return 'sports';
      case NewsCategory.entertainment:
        return 'entertainment';
    }
  }
}