import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
void main(){
  runApp(MaterialApp(
    title: "Contador de Pessoas",
    home: Home(),
  ));

}
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  String infoText = "Informe seus dados!";
  void resetFields(){
    weightController.text = "";
    heightController.text = "";
    setState(() {
      infoText = "Informe seus dados";
      _formKey = GlobalKey<FormState>();    // ADICIONE ESTA LINHA!
    });
  }
  void calculate(){
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text)/100;
      double imc = weight / (height*height);
      if(imc< 18.6){
        infoText = "Abaixo do Peso (${imc.toStringAsPrecision(3)} )";
        //infoText = "21";
      }else if(imc>18.6 && imc <= 24.9){
        infoText = "Peso ideal (${imc.toStringAsPrecision(3)} )";

      }else{
        infoText = "outra opçao";
      }

    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions:<Widget>[
         IconButton(icon: Icon(Icons.refresh),
             onPressed: (){resetFields();})
        ]
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
            child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(Icons.person_outline, size: 120.0, color:Colors.green),
                TextFormField(keyboardType:TextInputType.number ,
                  decoration: InputDecoration(
                      labelText: "Peso (kg)",
                      labelStyle: TextStyle(color:Colors.orange)
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25.0),
                  controller: weightController,
                  validator: (value){
                      if(value.isEmpty){
                        return "insira seu peso";
                      }
                  },
                ),
                TextFormField(keyboardType:TextInputType.number ,
                  decoration: InputDecoration(
                      labelText: "Altura (kg)",
                      labelStyle: TextStyle(color:Colors.orange)
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25.0),
                  controller: heightController,
                  validator: (value){
                    if(value.isEmpty){
                      return "insira seu peso";
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top:10.0,bottom:10.0),
                  child:
                  Container(
                      height: 70.0,
                      child: RaisedButton(
                          onPressed: (){
                            if(_formKey.currentState.validate()){
                              calculate();
                            }
},
                          child: Text ("Calcular",
                            style: TextStyle(color: Colors.white, fontSize: 25.0),
                          ),
                          color: Colors.green
                      )
                  ),
                ),

                Text(infoText,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25.0)
                )
              ],
            )
        )

      )

    );
  }
}
