import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {

  runApp(MyCalculator());

}

class MyCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "",
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Calculator();
  }
}

class _Calculator extends State<Calculator> {

  String text = "";
  double numOne = 0;
  double numTwo = 0;
  String result = "";
  String finalResult = "0";
  String oper = "";
  String preOper = "";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: null,
      backgroundColor: Colors.deepOrange,
      body: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                  text,
                  style: TextStyle(color: Colors.white, fontSize: 60),
                  maxLines: 1,
                  textAlign: TextAlign.right,
                )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                button("C", Color(0xffa5a5a5), 1),
                button("+/-", Color.fromRGBO(165, 165, 165, 1), 1),
                button("%", Colors.grey, 1),
                button("/", Colors.amber, 1),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                button("7", Colors.black, 1),
                button("8", Colors.black, 1),
                button("9", Colors.black, 1),
                button("x", Colors.amber, 1),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                button("4", Color(0xff000000), 1),
                button("5", Color(0xff000000), 1),
                button("6", Color(0xff000000), 1),
                button("-", Colors.amber, 1),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                button("1", Color(0xff000000), 1),
                button("2", Color(0xff000000), 1),
                button("3", Color(0xff000000), 1),
                button("+", Colors.amber, 1),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                button("0", Color(0xff000000), 0),
                button(".", Color(0xff000000), 1),
                button("=", Colors.amber, 1),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget button(String btnTxt, Color color, int num) {
    Container container = null;

    if (num == 0) {
      container = Container(
        padding: EdgeInsets.only(bottom: 10),
        child: RaisedButton(
          onPressed: () {
            calculate(btnTxt);
          },
          child: Text(
            btnTxt,
            style: TextStyle(
              fontSize: 30,
              color: Colors.deepOrange
            ),
          ),
          color: color,
          padding: EdgeInsets.only(left: 81, top: 20, right: 81, bottom: 20),
          shape: StadiumBorder(),
        ),
      );
    } else {
      container = Container(
        padding: EdgeInsets.only(bottom: 20),
        child: RaisedButton(
          onPressed: () {
            calculate(btnTxt);
          },
          child: Text(
            btnTxt,
            style: TextStyle(
              fontSize: 30,
              color: Colors.deepOrange
            ),
          ),
          color: color,
          padding: EdgeInsets.all(20),
          shape: CircleBorder(),
        ),
      );
    }
    return container;
  }

  void calculate(txtBtn) {

    if (txtBtn == "C") {
      text = "0";
      numOne = 0;
      numTwo = 0;
      result = "0";
      finalResult = "0";
      oper = "";
      preOper = "";
    }
    else if(oper=="=" && txtBtn=="="){

      switch(preOper){
        case "+":
          finalResult = add();
          break;
        case "-":
          finalResult = sub();
          break;
        case "x":
          finalResult = mult();
          break;
        case "/":
          finalResult = div();
          break;
      }

  }else if (txtBtn == "+" ||
        txtBtn == "-" ||
        txtBtn == "x" ||
        txtBtn == "/"||
        txtBtn=="=" ) {

      if (numOne == 0) {

        numOne = double.parse(result);
      }
      else {

        numTwo = double.parse(result);
      }

      switch (oper) {
        case "+":
          result = add();
          break;
        case "-":
          result = sub();
          break;
        case "x":
          result = mult();
          break;
        case "/":
          result = div();
          break;
      }
      preOper = oper;
      oper = txtBtn;
      result="";

    }
    else if(txtBtn=="%"){
      result = (numOne/100).toString();
      finalResult = result;
    }

    else if(txtBtn=="."){
      if(!result.contains(".")){
        result = result + ".";
        finalResult = result;
      }
    }
    else if(txtBtn=="+/-"){
     result.startsWith("-")? result=result.substring(1) : result = "-" + result;
     finalResult = result;
    }
    else {
      if(result=="0"){
        result = txtBtn;
      }
      result = result + txtBtn;
      finalResult = result;
    }

    setState(() {
      text = finalResult;
    });

  }
   // all operators
  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return decimalRemove(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return decimalRemove(result);
  }

  String mult() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return decimalRemove(result);
  }

  String div() {

      result = (numOne + numTwo).toString();
      numOne = double.parse(result);
    return decimalRemove(result);
  }

  String decimalRemove(String _result){

     if(_result.contains(".")){
      List<String> list =  _result.split(".");
      if(!(int.parse(list[1])>0))
      return list[0];
     }
     return _result;
  }

}
