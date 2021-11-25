import 'package:http/http.dart' as http;
import 'http_get_model.dart';
var url = Uri.parse("https://asap-dms-backend.herokuapp.com/api/rescuemap/");

class VicMapRepository {
  Future<List<Vicmap>> getVics() async {
    final response = await http.get(url);
    return vicmapFromJson(response.body);
  }
}