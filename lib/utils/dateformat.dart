import 'package:intl/intl.dart';

String formatUpdatedTime(String updatedTime, List<String> months) {
   DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
   DateTime dateTime = dateFormat.parse(updatedTime.replaceAll('T', ' '));
   String lastUpdatedTime = months[dateTime.month - 1] + " " + dateTime.day.toString() + 
    ", " + dateTime.year.toString() + ", " + dateTime.hour.toString() + ":" + dateTime.minute.toString();

  return lastUpdatedTime;
}