class DatePickerViewModel {
  DateTime? parseDate(String dateString) {
    final parts = dateString.split(RegExp(r'[\s/,-]+'));
    if (parts.length == 3) {
      int? month;
      int? day;
      int? year;

      // Determine the order of month, day, and year based on the length of each part
      for (var part in parts) {
        final value = int.tryParse(part);
        if (value != null) {
          if (part.length <= 2) {
            if (day == null) {
              day = value;
            } else if (month == null) {
              month = value;
            } else {
              year ??= value;
            }
          } else if (part.length == 4) {
            year = value;
          }
        }
      }

      // Check if all parts are valid
      if (month != null && day != null && year != null) {
        return DateTime(year, month, day);
      }
    }
    // Return null if parsing fails
    return null;
  }
}
