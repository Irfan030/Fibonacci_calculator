import 'package:flutter/material.dart';
import 'dart:collection';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fibonacci Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FibonacciCalculator(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FibonacciCalculator extends StatefulWidget {
  const FibonacciCalculator({super.key});

  @override
  _FibonacciCalculatorState createState() => _FibonacciCalculatorState();
}

class _FibonacciCalculatorState extends State<FibonacciCalculator> {
  final TextEditingController _positionController = TextEditingController();
  int? result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fibonacci Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _positionController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter position',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  int position = int.tryParse(_positionController.text) ?? 0;
                  result = fibonacci(position);
                });
              },
              child: const Text('Calculate'),
            ),
            const SizedBox(height: 20),
            result != null
                ? Text(
                    'Fibonacci value at position ${_positionController.text}: $result',
                    style: const TextStyle(fontSize: 18),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  // Function to calculate Fibonacci value using recursion and memoization
  int fibonacci(int n) {
    // Using a HashMap to store previously calculated values
    Map<int, int> memo = HashMap<int, int>();

    int fib(int k) {
      if (k <= 1) {
        return k;
      }

      // Check if the value is already calculated and stored in the memo
      if (memo.containsKey(k)) {
        return memo[k]!;
      }

      // Calculate Fibonacci value and store it in the memo
      memo[k] = fib(k - 1) + fib(k - 2);

      return memo[k]!;
    }

    // Call the helper function
    return fib(n);
  }
}
