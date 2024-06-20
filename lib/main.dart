import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'controller.dart';
import 'form_validation.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
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

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
 ConsumerState<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends ConsumerState<MyHomePage> {
  var num1 = 0;
  var num2 = 0;
  var result = 0;



  void addNumbers() {

      setState(() {
        result = num1 + num2;
        addToHistory();
        ref.read(controllerProvider).callApi(context);
      });

  }

  List<String> calculationHistory = [];

  void addToHistory() {
    setState(() {
      calculationHistory.add("$num1 + $num2 = $result");
    });
  }


  @override
  Widget build(BuildContext context) {
    final textcontroller=ref.watch(controllerProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key:textcontroller.formKey,
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
