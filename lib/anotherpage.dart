import 'package:flutter/material.dart';


class AnotherPage extends StatefulWidget {
  final String author;
  final String quote;

  const AnotherPage({Key? key, required this.author, required this.quote}) : super(key: key);

  @override
  _AnotherPageState createState() => _AnotherPageState();
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
            const Center(
              child: Text(
                'Quote of the day',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              ' "${widget.quote}" : ${widget.author} ',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
