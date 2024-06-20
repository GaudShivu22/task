import 'package:flutter/material.dart';

class AnotherPage extends StatefulWidget {
  final String currentAuthor;
  final String currentQuote;
  final Future<void> Function() fetchApiResponse;

  const AnotherPage({
    Key? key,
    required this.currentAuthor,
    required this.currentQuote,
    required this.fetchApiResponse,
  }) : super(key: key);

  @override
  State<AnotherPage> createState() => _AnotherPageState();
}

class _AnotherPageState extends State<AnotherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Another Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 60),

         //  call fetchapi function here
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await widget.fetchApiResponse();
                },
                child: const Text("Fetch New Quote"),
              ),
            ),
            const Center(
              child: Text(
                'Quote of the day',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              ' "${widget.currentQuote}" : ${widget.currentAuthor} ',
              style: const TextStyle(fontSize: 16),
            ),

          ],
        ),
      ),
    );
  }
}
