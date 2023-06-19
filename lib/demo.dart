import 'package:flutter/material.dart';

class CustomRadioButton extends StatefulWidget {
  @override
  _CustomRadioButtonState createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  int selectedOption = 0;

  void selectOption(int option) {
    setState(() {
      selectedOption = option;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => selectOption(0),
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selectedOption == 0 ? Colors.blue : Colors.transparent,
                    border: Border.all(color: Colors.blue),
                  ),
                ),
              ),

              GestureDetector(
                onTap: () => selectOption(1),
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selectedOption == 1 ? Colors.blue : Colors.transparent,
                    border: Border.all(color: Colors.blue),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Text('Option 2'),
            ],
          ),
        ),
        // Add more GestureDetector and Container combinations for additional options
      ],
    );
  }
}

