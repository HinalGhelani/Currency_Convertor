import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sky_scrapper_1/Modal_class.dart';
class APIHelper {
  APIHelper._();

  static final APIHelper apiHelper = APIHelper._();

  Future<Currency?> fetchData() async {
    String api = "https://v6.exchangerate-api.com/v6/da5315a00e6258a31dcdb21c/latest/USD";

    http.Response res = await http.get(Uri.parse(api));

    if(res.statusCode == 200){
      Map decodedData = jsonDecode(res.body);

      Currency currency = Currency.fromJson(json: decodedData);

      return currency;
    }
    else {
      return null;
    }
  }

}