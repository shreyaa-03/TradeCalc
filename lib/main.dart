import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Advanced Calculator',
      theme: _isDarkMode
          ? ThemeData.dark().copyWith(
              colorScheme: const ColorScheme.dark(primary: Colors.teal),
              scaffoldBackgroundColor: Colors.black,
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.teal,
              ),
              textTheme: const TextTheme(
                bodyLarge: TextStyle(color: Colors.white),
                bodyMedium: TextStyle(color: Colors.white),
                headlineMedium: TextStyle(color: Colors.white),
              ),
            )
          : ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light(primary: Colors.teal),
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.teal,
              ),
              textTheme: const TextTheme(
                bodyLarge: TextStyle(color: Colors.black87),
                bodyMedium: TextStyle(color: Colors.black87),
                headlineMedium: TextStyle(color: Colors.black87),
              ),
            ),
      home: CalculatorScreen(
        isDarkMode: _isDarkMode,
        toggleDarkMode: _toggleDarkMode,
      ),
    );
  }

  void _toggleDarkMode(bool value) {
    setState(() {
      _isDarkMode = value;
    });
  }
}

class CalculatorScreen extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> toggleDarkMode;

  const CalculatorScreen({super.key, required this.isDarkMode, required this.toggleDarkMode});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController highController = TextEditingController();
  final TextEditingController lowController = TextEditingController();

  String buyAbove = "";
  String sellBelow = "";
  String buyAbove1 = "";
  String buyAbove5 = "";
  String buyAbove10 = "";
  String sellBelow1 = "";
  String sellBelow5 = "";
  String sellBelow10 = "";

  bool showResults = false;

  void calculate() {
    double? high = double.tryParse(highController.text);
    double? low = double.tryParse(lowController.text);

    if (high != null && low != null) {
      double diff = high - low;
      double buyAboveValue = (diff / 2) + high;
      double sellBelowValue = low - (diff / 2);

      double buyAbove1Value = (0.01 * buyAboveValue) + buyAboveValue;
      double buyAbove5Value = (0.05 * buyAboveValue) + buyAboveValue;
      double buyAbove10Value = (0.10 * buyAboveValue) + buyAboveValue;

      double sellBelow1Value = sellBelowValue - (0.01 * sellBelowValue);
      double sellBelow5Value = sellBelowValue - (0.05 * sellBelowValue);
      double sellBelow10Value = sellBelowValue - (0.10 * sellBelowValue);

      setState(() {
        buyAbove = buyAboveValue.toStringAsFixed(2);
        sellBelow = sellBelowValue.toStringAsFixed(2);

        buyAbove1 = buyAbove1Value.toStringAsFixed(2);
        buyAbove5 = buyAbove5Value.toStringAsFixed(2);
        buyAbove10 = buyAbove10Value.toStringAsFixed(2);

        sellBelow1 = sellBelow1Value.toStringAsFixed(2);
        sellBelow5 = sellBelow5Value.toStringAsFixed(2);
        sellBelow10 = sellBelow10Value.toStringAsFixed(2);

        showResults = true;
      });
    } else {
      setState(() {
        buyAbove = "Please enter valid numbers!";
        sellBelow = "";
        buyAbove1 = "";
        buyAbove5 = "";
        buyAbove10 = "";
        sellBelow1 = "";
        sellBelow5 = "";
        sellBelow10 = "";
        showResults = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = MediaQuery.of(context).size.width < 700;

    return Scaffold(
      appBar: AppBar(
       title: FittedBox(
    fit: BoxFit.scaleDown, // Ensures text scales down if necessary
    child: Text(
      'Masha Allah Money Miner by Tamseel',
      style: TextStyle(
        fontSize: min(MediaQuery.of(context).size.width * 0.08, 40.0),
        fontFamily: 'Times New Roman',
        color: Colors.white,
        fontWeight: FontWeight.bold,
            shadows: [
        Shadow(
          offset: Offset(3.0, 3.0), // Shadow offset (horizontal, vertical)
          blurRadius: 5.0, // Blur radius of the shadow
          color: Colors.black.withOpacity(0.5), // Shadow color with opacity
        ),
      ],
    
      ),
      softWrap: true, // Allows the text to wrap into the next line if it's too long
      overflow: TextOverflow.visible, // No ellipsis at the end, text can break to the next line
    ),
  ),
        actions: [
          Switch(
            value: widget.isDarkMode,
            onChanged: widget.toggleDarkMode,
            activeColor: Colors.white,
            inactiveThumbColor: Colors.teal,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(child: _buildInputField("High Value", highController)),
                  const SizedBox(width: 16),
                  Expanded(child: _buildInputField("Low Value", lowController)),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: calculate,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Calculate",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              const SizedBox(height: 24),
              if (buyAbove == "Please enter valid numbers!") ...[
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    buyAbove,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ] else if (showResults) ...[
                if (isSmallScreen)
                  Column(
                    children: [
                      _buildResultBox("Buy Above:", buyAbove),
                      const SizedBox(height: 5),
                      _buildResultBox("Sell Below:", sellBelow),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(child: _buildResultBox("Buy Above", buyAbove)),
                      const SizedBox(width: 16),
                      Expanded(child: _buildResultBox("Sell Below", sellBelow)),
                    ],
                  ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: widget.isDarkMode ? Colors.grey[800] : Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        "Target Values",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      if (isSmallScreen)
                        Column(
                          children: [
                            _buildTargetValues("Buy Above", buyAbove1, buyAbove5, buyAbove10),
                            const SizedBox(height: 16),
                            _buildTargetValues("Sell Below", sellBelow1, sellBelow5, sellBelow10),
                          ],
                        )
                      else
                        Row(
                          children: [
                            Expanded(child: _buildTargetValues("Buy Above", buyAbove1, buyAbove5, buyAbove10)),
                            const SizedBox(width: 16),
                            Expanded(child: _buildTargetValues("Sell Below", sellBelow1, sellBelow5, sellBelow10)),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 18, color: Colors.teal),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.teal, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

Widget _buildResultBox(String label, String value) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: const EdgeInsets.symmetric(vertical: 4),
    decoration: BoxDecoration(
      color: widget.isDarkMode ? Colors.grey[700] : Colors.grey[300],
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Ensures space between label and value
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: widget.isDarkMode ? Colors.white : Colors.black87,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: widget.isDarkMode ? Colors.white : Colors.black87,
          ),
        ),
      ],
    ),
  );
}


Widget _buildTargetValues(String title, String value1, String value5, String value10) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.teal),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 8),
      _buildTargetBox("1% Target", value1),
      const SizedBox(height: 4),
      _buildTargetBox("5% Target", value5),
      const SizedBox(height: 4),
      _buildTargetBox("10% Target", value10),
    ],
  );
}

Widget _buildTargetBox(String label, String value) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16), // Padding for a larger box
    margin: const EdgeInsets.symmetric(vertical: 2),
    decoration: BoxDecoration(
      color: widget.isDarkMode ? Colors.grey[700] : Colors.grey[300],
      borderRadius: BorderRadius.circular(6),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16, // Increased font size
            fontWeight: FontWeight.bold, // Bold text for label
            color: widget.isDarkMode ? Colors.white : Colors.black87,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16, // Increased font size
            fontWeight: FontWeight.bold, // Bold text for value
            color: widget.isDarkMode ? Colors.white : Colors.black87,
          ),
        ),
      ],
    ),
  );
}

}
