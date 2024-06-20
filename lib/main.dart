import 'package:flutter/material.dart';
import 'package:task/anotherpage.dart';
import 'apiendpoint.dart';
import 'diocilent.dart';
import 'form_validation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Task(),
    );
  }
}
class  extends StatefulWidget {
  const Task({super.key});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {

  int num1=0;
  int num2=0;
  int result = 0;

 final key=GlobalKey<FormState>();




  void addNumbers() {
    setState(() {
      result = num1 + num2;
    });
  }

  List<String> calculationHistory = [];

  void addToHistory() {
    setState(() {
      calculationHistory.add("$num1 + $num2 = $result");
    });
  }

  Future<String> fetchApiResponse() async {
    try {
      final response = await DioClient.dioClient.getAPI(endPoint: ApiEndPoint.getQuotes);
      return  response.data[0]['q'];

    } catch (e) {
      return "Error: $e";
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key:key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 60),
              Text(
                "Adder",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 50),
              Row(
                children: [
                  SizedBox(width: 10),
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
                  onTap: () async {
                    if (key.currentState!.validate()) {
                      key.currentState!.save();
                      addNumbers();
                      addToHistory();
                      String quote = await fetchApiResponse();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AnotherPage(fetchApiResponse: fetchApiResponse, Quote: quote),
                        ),
                      );
                    }
                    },
                    child: const Text(
                      "=",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 35),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: TextFormField(

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

