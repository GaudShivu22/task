import 'package:flutter/material.dart';

class AnotherPage extends StatefulWidget {
  const AnotherPage({super.key, required this.fetchApi,required this.Quote});
  final Future<String> Function() fetchApi;
   final String Quote;


  @override
  State<AnotherPage> createState() => _AnotherPageState();
}

class _AnotherPageState extends State<AnotherPage> {
 late String quote;


  @override
  void initState() {
    super.initState();
    quote = widget.Quote;

  }

 Future<void> newquote() async {
   String newQuote = await widget.fetchApi();
   setState(() {
     quote = newQuote;
   });
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Another Page'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: newquote,
                child: const Text('Update Quote'),
              ),
              Text(
                quote,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

            ],
          ),
        ),
      ),
    );
  }
}
