// import 'package:intl/intl.dart';

// class TimeConverter {
//   // Convert UTC to Local Time with an optional custom format
//   static String convertUtcToLocal(String utcTime, {String? customFormat}) {
//     try {
//       // Parse UTC time to DateTime
//       DateTime utcDateTime = DateTime.parse(utcTime).toUtc();
//       DateTime localDateTime = utcDateTime.toLocal();

//       // Set default format if custom format is not provided
//       String format = customFormat ?? 'yyyy-MM-dd HH:mm:ss';

//       // Format the DateTime object using the specified or default format
//       String formattedDate = DateFormat(format).format(localDateTime);

//       return formattedDate;
//     } catch (e) {
//       return utcTime;
//     }
//   }

//   static String formatCustomDate(String utcTime) {
//     try {
//       DateTime utcDateTime = DateTime.parse(utcTime).toUtc();
//       DateTime localDateTime = utcDateTime.toLocal();

//       DateTime now = DateTime.now();
//       bool isToday = now.day == localDateTime.day &&
//           now.month == localDateTime.month &&
//           now.year == localDateTime.year;
//       bool isYesterday =
//           now.subtract(const Duration(days: 1)).day == localDateTime.day &&
//               now.month == localDateTime.month &&
//               now.year == localDateTime.year;

//       if (isToday) {
//         return DateFormat('HH:mm')
//             .format(localDateTime); // 24-hour format for today
//       } else if (isYesterday) {
//         return 'Yesterday'; // Format for yesterday
//       } else {
//         return DateFormat('EE').format(localDateTime); // Format for past dates
//       }
//     } catch (e) {
//       return utcTime;
//     }
//   }

//   // New method for formatting time to readable format (e.g. 10:30 AM)
//   static String formatToReadableTime(String isoTime) {
//     try {
//       DateTime dateTime = DateTime.parse(isoTime);
//       return DateFormat('HH:mm').format(dateTime);
//     } catch (e) {
//       return isoTime;
//     }
//   }
// }
