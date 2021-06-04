import 'dart:math';

import 'package:flutter/material.dart';
import '../common/enum.dart';

class Calculo extends StatefulWidget {
  Calculo({Key key, this.tipoCalculo, this.bar}) : super(key: key);

  final TipoCalculo tipoCalculo;

  final AppBar bar;

  @override
  State<StatefulWidget> createState() =>
      CalculoState(tipoCalculo: tipoCalculo, bar: bar);
}

class CalculoState extends State<Calculo> {
  CalculoState({this.tipoCalculo, this.bar});

  final AppBar bar;
  final TipoCalculo tipoCalculo;

  String tituloCalculo() {
    switch (tipoCalculo) {
      case TipoCalculo.Consumo:
        return "Cálculo de Consumo de Combustível";
      case TipoCalculo.Imc:
        return "Cálculo de IMC";
      default:
        return "";
    }
  }

  double valueField1 = 0;
  double valueField2 = 0;

  String result = "";

  String setValueField1(String value) {
    setState(() {
      if (value.isEmpty)
        valueField1 = 0;
      else
        valueField1 = double.parse(value);
    });
    calcular();
    return value;
  }

  String setValueField2(String value) {
    setState(() {
      if (value.isEmpty)
        valueField2 = 0;
      else
        valueField2 = double.parse(value);
    });
    calcular();
    return value;
  }

  String getField1() {
    switch (tipoCalculo) {
      case TipoCalculo.Consumo:
        return "KM Rodados";
      case TipoCalculo.Imc:
        return "Peso";
      default:
        return "";
    }
  }

  String getField2() {
    switch (tipoCalculo) {
      case TipoCalculo.Consumo:
        return "Litros";
      case TipoCalculo.Imc:
        return "Altura em Metro";
      default:
        return "";
    }
  }

  void calcular() {
    setState(() {
      if (valueField1 == 0 || valueField2 == 0) {
        result = "";
        return;
      }
      switch (tipoCalculo) {
        case TipoCalculo.Consumo:
          result = "O consumo de combustível calculado é: " +
              (valueField1 / valueField2).toStringAsFixed(2);
          break;
        case TipoCalculo.Imc:
          result = "O IMC calculado é: " +
              (valueField1 / pow(valueField2, 2)).toStringAsFixed(2);
          break;
        default:
          result = "";
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: bar,
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 300,
                  child: Column(
                    children: [
                      SizedBox(
                          width: 300,
                          child: Column(
                            children: [Text(tituloCalculo())],
                          )),
                      SizedBox(
                          width: 300,
                          child: Column(
                            children: [
                              TextField(
                                decoration:
                                    InputDecoration(labelText: getField1()),
                                keyboardType: TextInputType.number,
                                onChanged: setValueField1,
                              )
                            ],
                          )),
                      SizedBox(
                          width: 300,
                          child: Column(
                            children: [
                              TextField(
                                decoration:
                                    InputDecoration(labelText: getField2()),
                                keyboardType: TextInputType.number,
                                onChanged: setValueField2,
                              )
                            ],
                          )),
                      Divider(),
                      SizedBox(
                          width: 300,
                          child: Column(
                            children: [Text(result)],
                          ))
                    ],
                  ),
                )
              ]),
        ));
  }
}
