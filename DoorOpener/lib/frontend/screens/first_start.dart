import 'package:flutter/material.dart';
import 'package:raspberry_pi_door_opener/utils/localizations/app_localizations.dart';
import 'package:raspberry_pi_door_opener/utils/other/data_manager.dart';

import 'loading_screen.dart';

class FirstStart extends StatefulWidget {
  @override
  _FirstStartState createState() => _FirstStartState();
}

class _FirstStartState extends State<FirstStart> {
  final _formKey = GlobalKey<FormState>();
  final ipController = TextEditingController();
  final portController = TextEditingController();
  final openController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        AppLocalizations.of(context)
                            .translate('first_start_explanation'),
                        style: Theme.of(context).textTheme.headline1.copyWith(
                            fontSize: 20, fontWeight: FontWeight.normal),
                        textAlign: TextAlign.center,
                      ),
                      // SizedBox(height: 10,),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 50.0, horizontal: 10.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                style: Theme.of(context).textTheme.bodyText1,
                                controller: ipController,
                                keyboardType: TextInputType.number,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (String value) {
                                  //return ipValidator(value, context);
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelStyle:
                                      Theme.of(context).textTheme.bodyText1,
                                  labelText: AppLocalizations.of(context)
                                      .translate('first_start_ip_label'),
                                  hintStyle:
                                      Theme.of(context).textTheme.bodyText1,
                                  hintText: AppLocalizations.of(context)
                                      .translate('first_start_ip_hint'),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                style: Theme.of(context).textTheme.bodyText1,
                                controller: portController,
                                keyboardType: TextInputType.number,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return AppLocalizations.of(context)
                                        .translate('first_start_port_validate');
                                  } else
                                    return null;
                                },
                                decoration: InputDecoration(
                                  labelStyle:
                                      Theme.of(context).textTheme.bodyText1,
                                  labelText: AppLocalizations.of(context)
                                      .translate('first_start_port_label'),
                                  hintStyle:
                                      Theme.of(context).textTheme.bodyText1,
                                  hintText: AppLocalizations.of(context)
                                      .translate('first_start_port_hint'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                style: Theme.of(context).textTheme.bodyText1,
                                controller: openController,
                                keyboardType: TextInputType.number,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return AppLocalizations.of(context)
                                        .translate('first_start_open_validate');
                                  } else
                                    return null;
                                },
                                decoration: InputDecoration(
                                  labelStyle:
                                      Theme.of(context).textTheme.bodyText1,
                                  labelText: AppLocalizations.of(context)
                                      .translate('first_start_open_label'),
                                  hintStyle:
                                      Theme.of(context).textTheme.bodyText1,
                                  hintText: AppLocalizations.of(context)
                                      .translate('first_start_open_hint'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.tealAccent,
          onPressed: () {
            print(_formKey.currentState.validate());
            if (_formKey.currentState.validate()) {
              String ipAddress = ipController.text.toString();
              int port = int.parse(portController.text.toString());
              int time = int.parse(openController.text.toString());
              time *= 1000;
              print(time);
              DataManager().safeIP(ipAddress);
              DataManager().safePort(port);
              DataManager().safeTime(time);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => LoadingScreen()));
            } else
              return Scaffold.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 3),
                  backgroundColor: Colors.redAccent,
                  content: Text(
                    AppLocalizations.of(context)
                        .translate('first_start_snackbar_message'),
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              );
          },
          child: Icon(Icons.arrow_forward),
        ),
      ),
    );
  }
}
