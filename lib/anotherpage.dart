import 'package:flutter/material.dart';

class AnotherPage extends StatelessWidget {
  final String currentAuthor;
  final String currentQuote;
  final Future<void> Function() fetchApiResponse;

  AnotherPage({required this.currentAuthor, required this.currentQuote, required this.fetchApiResponse});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quote Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await fetchApiResponse();
                },
                child: Text('Fetch New Quote'),
              ),
            ),
            Text('Quote: $currentQuote'),
            Text('Author: $currentAuthor'),


          ],
        ),
      ),
    );
  }
}
