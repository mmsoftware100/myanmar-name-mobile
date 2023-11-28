import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:myanmarname/myanmar_name_converter.dart';

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
      // showSemanticsDebugger: false,
      title: 'Myanmar Name',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _myanmarInput = true;
  TextEditingController tec = TextEditingController();
  String result = "";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text("Myanmar Name"),
      ),
      body: _mainWidget(),
    );
  }

  Widget _mainWidget(){
    return Column(
      children: [
        // indicator
        _row(),
        // result
        _result(),
        // _switchValue ? Text("Enter Myanmar") : Text("Enter English"),
        SizedBox(height: 8.0,),
        _textBox()
      ],
    );
  }

  Widget _row(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [

        Expanded(
            child: Text(_myanmarInput ? "Myanmar" : "English", textAlign: TextAlign.end,)
        ),

        Container(
            margin: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(8.0)
            ),
            child: TextButton(onPressed: (){ _toggleSwitch(!_myanmarInput); }, child: Icon(Icons.arrow_forward_ios, color: Colors.green,))),


        Expanded(child: Text(_myanmarInput ? "English" : "Myanmar")),
        /*
            Switch(
              value: _myanmarInput,
              inactiveTrackColor: Colors.greenAccent,
              inactiveThumbColor: Colors.green,
              onChanged: (value) {
                _toggleSwitch(value);
              },
            ),
            */
        // Text('English'),
      ],
    );
  }

  Widget _result(){
    return result.isEmpty ? Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.all(8.0),
        child: Text("Enter English Name / မြန်မာ နာမည် ရိုက်ထည့်ပါ", style: TextStyle(color: Colors.black26),)) :
    Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: Text(result, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),)
    );
  }

  Widget _textBox(){
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: tec,
          // textAlign: TextAlign.center,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: _myanmarInput ? "Enter Myanmar" : "Enter English",
            label:  _myanmarInput ? Text("Enter Myanmar") : Text("Enter English"),
          ),
          onChanged: (String? text){
            _convert(text: text ?? "");
          },

        ),
      );
  }

  void _toggleSwitch(bool status){
    setState(() {
      // clear
      result = "";
      tec.clear();
      _myanmarInput = status;
    });
  }

  void _convert({required String text}){
    // check mode and text is match

    print(checkEnglish(text));
    print("_myanmar is $_myanmarInput");

    if(text.isNotEmpty){
      if(checkEnglish(text[0])){
        // user type english
        if(_myanmarInput == true ){
          // we're expection myanmar
          // so change
          setState(() {
            _myanmarInput = false;
          });
        }
      }
      else{
        if(_myanmarInput == false){
          // မြန်မာစာ လက်မခံဘူးဆိုပေမယ့် မြန်မာစာတွေ ရိုက်နေတယ်။
          setState(() {
            _myanmarInput = true;
          });
        }
      }
    }

    print("_myanmar is $_myanmarInput");


    setState(() {
      result = _myanmarInput ?   MyanmarNameConverter.mm2en(text) : MyanmarNameConverter.en2mm(text);
    });
  }

  bool checkEnglish(String input) {
    RegExp regex = RegExp(r'^[a-zA-Z]');
    return regex.hasMatch(input);
  }
}
