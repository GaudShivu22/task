import 'package:flutter/material.dart';
import 'apiendpoint.dart';
import 'diocilent.dart';

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

Future<void> fetchApiResponse() async {
    try {
      final response = await DioClient.dioClient.getAPI(endPoint: ApiEndPoint.getQuotes);
      updateQuote(response.data[0]['a'].toString(), response.data[0]['q'].toString());
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
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 60),
            const Center(child: Text('Quote of the day',style: TextStyle(fontSize: 16), textAlign: TextAlign.center,)),
            Text(' "$quote":$author ',style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10,),
            const Center(child: Text("Adder",style: TextStyle(fontSize: 40,fontWeight: FontWeight.w600),)),
            Row(
              children: <Widget>[
                Flexible(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: 'Enter number 1',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                    ),),
                    onChanged: (value) {
                      num1 = int.tryParse(value)?? 0;
                    },
                  ),
                ),
                const Icon(Icons.add),
                Flexible(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: 'Enter number 2',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    onChanged: (value) {
                      num2 = int.tryParse(value) ?? 0;
                    },
                  ),
                ),

                const SizedBox(width: 10,),

                GestureDetector(
                  onTap: () {
                    addNumbers();
                    addToHistory();
                    fetchApiResponse();},
                  child: const Text("=",style: TextStyle(fontWeight: FontWeight.w600,fontSize:35),),
                ),

                const SizedBox(width: 10),
                Flexible(
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: "$result"
                    ),

                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),
            const Center(child: Text("History",style: TextStyle(fontWeight: FontWeight.w400,fontSize:20),)),
            Expanded(
              child: ListView.builder(
                itemCount: calculationHistory.length,
                itemBuilder: (context, index) {
                  return ListTile(
                      title: Text(".${calculationHistory[index]}")
                  );
                },
              ),
            ),



          ],
        ),
      ),
    );
  }
}


