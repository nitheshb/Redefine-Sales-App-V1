import 'package:intl/intl.dart';


class MyDateUtils {
  String formatDateTime(String dateString) {
    DateFormat formatter = DateFormat('d-MMM-yy hh:mm a');
    DateTime dateTime = DateFormat('d-MMM-yy hh:mm a').parse(dateString);
    return formatter.format(dateTime);
  }
}

void main() {
  MyDateUtils dateUtils = MyDateUtils();
  String dateString = '23-Feb-22 10:30 PM';
  String formattedDateTime = dateUtils.formatDateTime(dateString);
  print(formattedDateTime); // Output: "23-Feb-22 10:30 PM"
}
