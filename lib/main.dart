import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Controladores para os campos de texto
  var txtCep = TextEditingController();
  var txtLogradouro = TextEditingController();
  var txtBairro = TextEditingController();
  var txtCidade = TextEditingController();
  var txtEstado = TextEditingController();

  // Função para verificar o CEP
  void verifica() async {
    if (txtCep.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Digite um CEP",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        webPosition: 'center',
        timeInSecForIosWeb: 1,
        webBgColor: '#ff0000',
        textColor: Colors.white,
        fontSize: 18.0,
      );
    }else{
    try{
    // Obtem dados da API
    var url = 'https://viacep.com.br/ws/${txtCep.text}/json/';
    // Aguarda a resposata da requisição e armazena na variável response
    var response = await http.get(Uri.parse(url));
    // converte a resposta em JSON
    var dados = json.decode(response.body);
    // Coloca as informações nos campos de texto
    txtLogradouro.text = dados['logradouro'];
    txtBairro.text = dados['bairro'];
    txtCidade.text = dados['localidade'];
    txtEstado.text = dados['uf'];
    }catch (e){
      txtCep.text = '';
      Fluttertoast.showToast(
        msg: "CEP inválido",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        webPosition: 'center',
        timeInSecForIosWeb: 1,
        webBgColor: '#ff0000',
        textColor: Colors.white,
        fontSize: 18.0,
      );
    }
    }
  }
  void limpar() {
      // Limpa os campos de texto
      txtCep.text = '';
      txtLogradouro.text = '';
      txtBairro.text = '';
      txtCidade.text = '';
      txtEstado.text = '';
    }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: false),
      home: Scaffold(
        appBar: AppBar(title: Text('Verifica CEP')),
        body: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            spacing: 20,
            children: [
              TextField(
                controller: txtCep,
                decoration: InputDecoration(
                  labelText: 'CEP',
                  hintText: 'Digite seu CEP',
                  border: OutlineInputBorder(),
                ),
              ),
              TextField(
                controller: txtLogradouro,
                decoration: InputDecoration(
                  labelText: 'Logradouro',
                  border: OutlineInputBorder(),
                ),
              ),
              TextField(
                controller: txtBairro,
                decoration: InputDecoration(
                  labelText: 'Bairro',
                  border: OutlineInputBorder(),
                ),
              ),
              TextField(
                controller: txtCidade,
                decoration: InputDecoration(
                  labelText: 'Cidade',
                  hintText: 'Digite a cidade',
                  border: OutlineInputBorder(),
                ),
              ),
              TextField(
                controller: txtEstado,
                decoration: InputDecoration(
                  labelText: 'Estado',
                  border: OutlineInputBorder(),
                ),
              ),
              ElevatedButton(onPressed: verifica, child: Text('Verificar CEP')),
              ElevatedButton(onPressed: limpar, child: Text('Limpar')),
            ],
          ),
        ),
      ),
    );
  }
}
