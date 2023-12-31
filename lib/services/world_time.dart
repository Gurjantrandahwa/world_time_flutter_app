import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String? location;
  String? time;
  String? flag;
  String? url;
  bool? isDaytime;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      http.Response response = await http
          .get(Uri.parse("http://worldtimeapi.org/api/timezone/$url"));
      Map<String, dynamic> data = jsonDecode(response.body);

      //  get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      // print(datetime);
      // DateTime object

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;

      time = DateFormat.jm().format(now);

      print(time);
    } catch (e) {
      print("Error : $e");
      time = "Could not get time!! ";
    }
  }
}
