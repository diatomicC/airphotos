import 'package:flutter/material.dart';
import 'photo_memories_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Memory',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(), // This sets the home page of your app
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? destinationName;
  DateTime? selectedDate;

  _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  _navigateToNextPage() {
    if (destinationName != null && selectedDate != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PhotoMemoriesPage(
              destination: destinationName!, visitDate: selectedDate!),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('Please provide both destination name and visit date!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Travel Memory'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // TextField widget to input the destination name.
            TextField(
              decoration: const InputDecoration(
                labelText: 'Destination Name',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  destinationName = value;
                });
              },
            ),
            const SizedBox(height: 16),
            // ElevatedButton widget to call the date picker.
            ElevatedButton(
              child: Text(selectedDate != null
                  ? 'Selected Date: ${selectedDate!.toLocal()}'.split(' ')[0]
                  : 'Select Visit Date'),
              onPressed: () => _selectDate(context),
            ),
            // Displaying the selected date
            if (selectedDate != null)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  selectedDate != null
                      ? 'You selected: ${selectedDate!.toLocal().toIso8601String().split('T')[0]}'
                      : 'No date selected',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _navigateToNextPage,
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
