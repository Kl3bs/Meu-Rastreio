// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:meu_rastreio/controllers/tracking_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final _formKey = GlobalKey<FormBuilderState>();
var trackingData;

class _HomeScreenState extends State<HomeScreen> {
  late String txt;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meu Rastreio"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              FormBuilder(
                  key: _formKey,
                  child: Column(
                    children: [FormBuilderTextField(name: "code")],
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: 200,
                  height: 60,
                  color: Colors.blue,
                  child: TextButton(
                      onPressed: () async {
                        _formKey.currentState!.save();
                        var data = _formKey.currentState?.fields["code"]?.value;

                        var response = await TrackingController()
                            .getTranckingInformation(data);

                        print(response[0].description);
                      },
                      child: Text(
                        "Rastrear",
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ))),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
