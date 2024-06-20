import 'package:flutter/material.dart';

class AnotherPage extends StatefulWidget {
  final String currentAuthor;
  final String currentQuote;
  final Future<void> Function() fetchApiResponse;

  AnotherPage({required this.currentAuthor, required this.currentQuote, required this.fetchApiResponse});

  @override
  State<AnotherPage> createState() => _AnotherPageState();
}

class _AnotherPageState extends State<AnotherPage> {
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
                  await widget.fetchApiResponse();
                },
                child: Text('Fetch New Quote'),
              ),
            ),
            Text('Quote: ${widget.currentQuote}'),
            Text('Author: ${widget.currentAuthor}'),


          ],
        ),
      ),
    );
  }
}
