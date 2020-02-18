
import 'package:flutter/cupertino.dart';

class DateConversion{

  static String dateTimeToDateFormt(DateTime data){
    String day, month, year;
    if (data.day < 10){
      day = "0"+data.day.toString();
    } else {
       day = data.day.toString();
    }
    if(data.month < 10){
      month = "0"+ data.month.toString();
    } else {
      month = "0"+ data.month.toString();
    }
    if (data.year < 10){
      year = "000" + data.year.toString();
    } else if(data.year > 10 &&  data.year < 100){
      year = "00" + data.year.toString();
    } else if(data.year > 100 &&  data.year < 1000){
      year = "0" + data.year.toString();
    } else {
      year = data.year.toString();
    }
    
    return day+"/"+month+"/"+year;
  }

  static String dateTimeToDateSql(DateTime data){
    String day, month, year;
    if (data.day < 10){
      day = "0"+data.day.toString();
    } else {
       day = data.day.toString();
    }
    if(data.month < 10){
      month = "0"+ data.month.toString();
    } else {
      month = "0"+ data.month.toString();
    }
    if (data.year < 10){
      year = "000" + data.year.toString();
    } else if(data.year > 10 &&  data.year < 100){
      year = "00" + data.year.toString();
    } else if(data.year > 100 &&  data.year < 1000){
      year = "0" + data.year.toString();
    } else {
      year = data.year.toString();
    }
    
    return year+"-"+month+"-"+day;
  }

  static String dateFormtToDateSql(String data) {
    String day = data.substring(0, 2);
    String month = data.substring(3, 5);
    String year = data.substring(6, 10);
    return year + "-" + month + "-" + day;
  }

  static DateTime dateFormtToDateTime(String data) {
    debugPrint(">> $data");
    int day = int.parse(data.substring(0, 2));
    int month = int.parse(data.substring(3, 5));
    int year = int.parse(data.substring(6, 10));
    return DateTime(year, month, day);
  }

}
