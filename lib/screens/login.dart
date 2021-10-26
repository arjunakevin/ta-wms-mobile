import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wms_mobile/nav.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

class Login extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Login> {
  bool _loading = true;
  String _username = '';
  String _password = '';

  Future<bool> _setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);

    return true;
  }

  void _login() async {
    setState(() {
      _loading = false;
    });

    final response = await http.post(
      Uri.parse(dotenv.env['API_URL'].toString() + '/login'),
      headers: {
        'Accept': 'application/json'
      },
      body: {
        'username': _username,
        'password': _password,
        'device_name': 'Mobile App'
      }
    );

    setState(() {
      _loading = false;
    });

    if (response.statusCode == 200) {
      await _setToken(response.body);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => Nav()),
        (Route<dynamic> route) => false
      );
    } else {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      String message = jsonResponse['message'];

      _showAlertDialog(message);
    }
  }

  void _showAlertDialog(String message) {
    Widget okButton = TextButton(
      child: Text("Close"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Message"),
      content: Text(message.replaceAll('\\n', '\n')),
      actions: [
        okButton
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget _getWidget(BuildContext context) {
    if (!_loading) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                  child: Container(
                    width: 300,
                    height: 150,
                    child: Image.asset('assets/images/logo.png')),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                    hintText: 'Username'
                  ),
                  onChanged: (value) => {
                    setState(() {
                      _username = value;
                    })
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15, bottom: 15),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Password'
                  ),
                  onChanged: (value) => {
                    setState(() {
                      _password = value;
                    })
                  },
                ),
              ),
              Container(
                constraints: BoxConstraints.expand(width: double.infinity, height: 60.0),
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: ElevatedButton(
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white
                    )
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: _login
                ),
              ),
              SizedBox(
                height: 130,
              )
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: SpinKitThreeBounce(
            color: Theme.of(context).primaryColor,
            size: 20
          )
        )
      );
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = (prefs.getString('token') ?? '');

      if (token.isEmpty) {
        setState(() {
          _loading = false;
        });
      } else {
        final response = await http.get(Uri.parse(dotenv.env['API_URL'].toString() + '/session'));

        if (response.statusCode == 200) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => Nav()),
            (Route<dynamic> route) => false
          );
        } else {
          setState(() {
            _loading = false;
          });
        }
      }
    });
  }
  
  Widget build(BuildContext context) {
    return _getWidget(context);
  }
}
