import 'package:http/http.dart' as http;
import 'dart:convert';

class WorldTime {
  String? location;
  String? time;
  String? flag;
  String? url;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    final http.Response response =
        await http.get(Uri.parse("http://worldtimeapi.org/api/timezone/$url"));
    final Map<String, dynamic> data = jsonDecode(response.body);

    //  get properties from data
    String datetime = data['datetime'];
    String offset = data['utc_offset'].substring(1, 3);
    // print(datetime);
    // DateTime object

    DateTime now = DateTime.parse(datetime);
    now = now.add(Duration(hours: int.parse(offset)));

    time = now.toString();
  }
}


