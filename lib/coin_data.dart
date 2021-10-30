import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'CAD',
  'EUR',
  'GBP',
  'JPY',
  'NOK',
  'NZD',
  'USD',
  'NGN',
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'BNB',
  'LTC',
];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'CF2BC5CD-FCC1-444C-9306-1363C005C4D2';

class CoinData {

  Future<dynamic> getCoinData(String currency) async {
    String selectedCurrency = currency;
    //TODO 4: Use a for loop here to loop through the cryptoList and request the data for each of them in turn.

    Map<String, String> cryptoPrices  = {};
    for (String crypto in cryptoList) {
      //TODO 5: Return a Map of the results instead of a single value.

      http.Response reply = await http.get(
          '$coinAPIURL/$crypto/$selectedCurrency?apikey=$apiKey');

      if (reply.statusCode == 200) {
      var price = await jsonDecode(reply.body)['rate'];

      cryptoPrices[crypto]= price.toStringAsFixed(0);
      }else {
        print(reply.statusCode);
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;

  }
}
