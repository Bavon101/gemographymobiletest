import 'package:intl/intl.dart';

String gitUrl({required int wayBack, String page = ''}) =>
    'https://api.github.com/search/repositories?q=created:>${getDateBack(wayBack: wayBack)}&sort=stars&order=desc$page';

String getDateBack({required int wayBack}) {
  var wayBackDate = DateTime.now().subtract(Duration(days: wayBack));
  String formattedDate = DateFormat('yyyy-MM-dd').format(wayBackDate);
  return formattedDate;
}


String getEditedNumeric({required int value}) => NumberFormat.compact().format(value);
