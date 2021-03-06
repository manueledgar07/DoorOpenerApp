import 'package:flutter/material.dart';
import 'package:raspberry_pi_door_opener/frontend/screens/password_auth.dart';
import 'package:raspberry_pi_door_opener/frontend/screens/password_change.dart';
import 'package:raspberry_pi_door_opener/frontend/screens/share_credentials.dart';
import 'package:raspberry_pi_door_opener/utils/localizations/app_localizations.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('settings_screen_title')),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 10),
            Card(
              elevation: 8,
              margin: const EdgeInsets.fromLTRB(12, 8, 12, 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.lock_outlined, color: Colors.teal,),
                    title: Text(AppLocalizations.of(context).translate('settings_screen_change_password'), style: Theme.of(context).textTheme.headline1.copyWith(fontSize:20, fontWeight: FontWeight.normal),),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => PasswordChange()));
                    },
                  ),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey.shade300,
                  ),
                  ListTile(
                    leading: const Icon(Icons.qr_code_outlined, color: Colors.teal,),
                    title: Text(AppLocalizations.of(context).translate('settings_screen_add_device'), style: Theme.of(context).textTheme.headline1.copyWith(fontSize:20, fontWeight: FontWeight.normal),),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => PasswordAuth(hint: 'share_credentials_hint', explanation: 'share_credentials_explanation', label: 'share_credentials_label', route: ShareCredentials())));
                    },
                  ),  Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey.shade300,
                  ),
                  ListTile(
                    leading: const Icon(Icons.api_outlined, color: Colors.teal,),
                    title: Text(AppLocalizations.of(context).translate('settings_screen_ip_reset'), style: Theme.of(context).textTheme.headline1.copyWith(fontSize:20, fontWeight: FontWeight.normal),),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    onTap: () {},
                  ),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey.shade300,
                  ),
                  ListTile(
                    leading: const Icon(Icons.reset_tv, color: Colors.teal,),
                    title: Text(AppLocalizations.of(context).translate('settings_screen_reset'), style: Theme.of(context).textTheme.headline1.copyWith(fontSize:20, fontWeight: FontWeight.normal),),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    onTap: () {},
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// TODO: Add function to reset button