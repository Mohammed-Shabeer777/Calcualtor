import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:calc/Colors.dart';

void main() {
  runApp(
    MaterialApp(
      home: CalculatorApp(),
    ),
  );
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {

  var input = '';
  var output = '';
  var op = '';
  var fs;
  var hide = false;

  OnClick(value)
  {
      if(value == 'AC')
        {
          input = '';
          output = '';
        }
      else if(value == '<-')
        {
          if(input.isNotEmpty){
          input = input.substring(0,input.length-1);
        }
        }
      else if(value=='=')
        {
          if(input.isNotEmpty) {
            Parser p = Parser();
            Expression exp = p.parse(input);
            ContextModel cm = ContextModel();
            var Answer = exp.evaluate(EvaluationType.REAL, cm);
            output = Answer.toString();
            if(output.endsWith('.0')){
              output = output.substring(0,output.length-2);
            }
            hide = true;
            input = output;
            fs = 64.0;
          }
        }
      else{
        hide = false;
        fs = 34.0;
        input = input + value;
      }
      setState(() {

      });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[300],
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              color: Colors.deepPurple[300],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    hide?'':input,
                    style: tsi(),
                  ),
                  SizedBox(height: 25),
                  Text(
                    output,
                    style: tso(fs),
                  )
                ],
              ),
            ),
          ),
          Row(
            children: [
              button(text: 'AC', bcolor: Opbg, tcolor: optxt),
              button(text: '<-', bcolor: Opbg, tcolor: optxt),
              button(text: '%', bcolor: Opbg, tcolor: optxt),
              button(text: '/', bcolor: Opbg, tcolor: optxt),
            ],
          ),
          Row(
            children: [
              button(text: '7', bcolor: numbg, tcolor: numtxt),
              button(text: '8', bcolor: numbg, tcolor: numtxt),
              button(text: '9', bcolor: numbg, tcolor: numtxt),
              button(text: '*', bcolor: Opbg, tcolor: optxt),
            ],
          ),
          Row(
            children: [
              button(text: '4', bcolor: numbg, tcolor: numtxt),
              button(text: '5', bcolor: numbg, tcolor: numtxt),
              button(text: '6', bcolor: numbg, tcolor: numtxt),
              button(text: '-', bcolor: Opbg, tcolor: optxt),
            ],
          ),
          Row(
            children: [
              button(text: '1', bcolor: numbg, tcolor: numtxt),
              button(text: '2', bcolor: numbg, tcolor: numtxt),
              button(text: '3', bcolor: numbg, tcolor: numtxt),
              button(text: '+', bcolor: Opbg, tcolor: optxt),
            ],
          ),
          Row(
            children: [
              button(text: '', bcolor: numbg, tcolor: numtxt),
              button(text: '0', bcolor: numbg, tcolor: numtxt),
              button(text: '.', bcolor: numbg, tcolor: numtxt),
              button(text: '=', bcolor: Opbg, tcolor: optxt),
            ],
          ),
        ],
      ),
    );
  }

  Widget button({text, tcolor, bcolor}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            primary: bcolor,
            padding: EdgeInsets.all(22),
          ),
          onPressed: () => OnClick(text),
          child: Text(
            text,
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: tcolor),
          ),
        ),
      ),
    );
  }
}
