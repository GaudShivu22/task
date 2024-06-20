import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'diocilent.dart';
import 'apiendpoint.dart';
import 'anotherpage.dart';

final controllerProvider = ChangeNotifierProvider((ref) => Controller());

class Controller extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  String author = '';
  String quote = '';

  Future<void> fetchApiResponse() async {
    try {
      final response = await DioClient.dioClient.getAPI(endPoint: ApiEndPoint.getQuotes);
      final newAuthor = response.data[0]['a'].toString();
      final newQuote = response.data[0]['q'].toString();
      updateQuote(newAuthor, newQuote);
    } catch (e) {
      print('Error fetching API: $e');
      updateQuote('', 'Error fetching quote');
    }
  }

  void updateQuote(String newAuthor, String newQuote) {
    author = newAuthor;
    quote = newQuote;
    notifyListeners();
  }

  void callApi(BuildContext context) {
    if (formKey.currentState!.validate()) {
      fetchApiResponse().then((_) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AnotherPage(
              currentAuthor: author,
              currentQuote: quote,
              fetchApiResponse: fetchApiResponse,
            ),
          ),
        );
      });
    }
  }
}
