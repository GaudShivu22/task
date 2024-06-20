import 'package:flutter/material.dart';
import 'anotherpage.dart';
import 'apiendpoint.dart';
import 'diocilent.dart';
import 'form_validation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Tasks',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  var num1 = 0;
  var num2 = 0;
  var result = 0;
  var author = '';
  var quote = '';

  final Key = GlobalKey<FormState>();

  void addNumbers() {
    if (Key.currentState!.validate()) {
      setState(() {
        result = num1 + num2;
        addToHistory();
        fetchApiResponse();
      });
    }
  }

  List<String> calculationHistory = [];

  void addToHistory() {
    setState(() {
      calculationHistory.add("$num1 + $num2 = $result");
    });
  }

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
    setState(() {
      author = newAuthor;
      quote = newQuote;
    });
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
  }












  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: Key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 60),
              const Center(
                child: Text(
                  "Adder",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
                ),
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Enter number 1',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      validator: validateNumericalInput,
                      onChanged: (value) {
                        num1 = int.tryParse(value) ?? 0;
                      },
                    ),
                  ),
                  const Icon(Icons.add),
                  Flexible(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Enter number 2',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      validator: validateNumericalInput,
                      onChanged: (value) {
                        num2 = int.tryParse(value) ?? 0;
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: addNumbers,
                    child: const Text(
                      "=",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 35),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "$result",
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              const Center(
                child: Text(
                  "History",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: calculationHistory.length,
                  itemBuilder: (context, index) {
                    return ListTile(title: Text(".${calculationHistory[index]}"));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
