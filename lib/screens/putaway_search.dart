import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wms_mobile/screens/putaway_form.dart';

class PutawaySearch extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<PutawaySearch> {
  String _id = '';
  bool _loading = true;

  void _submit() async {
    setState(() {
      _loading = true;
    });

    final response = await http.get(
      Uri.parse(dotenv.env['API_URL'].toString() + '/putaway/' + _id + '/status'),
      headers: {
        'Accept' : 'application/json',
        'Content-Type' : 'application/json'
      }
    );

    setState(() {
      _loading = false;
    });

    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PutawayForm(_id))
      );
    } else {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      String message = response.statusCode == 404
        ? "Good receive data not found."
        :  jsonResponse['message'];

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

  Widget _buildWidget(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Center(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Input Good Receive ID'
                ),
                onChanged: (value) => {
                  setState(() {
                    _id = value;
                  })
                },
              )
            ),
            Container(
              constraints: BoxConstraints.expand(width: double.infinity, height: 60.0),
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: ElevatedButton(
                child: Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white
                  )
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () => _submit()
              ),
            )
          ],
        )
      ),
    );
  }

  Widget _getWidget(BuildContext context) {
    if (!_loading) {
      return _buildWidget(context);
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
      await Future.delayed(Duration(milliseconds: 100));

      setState(() {
        _loading = false;
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Putaway - Search Good Receive'),
      ),
      body: _getWidget(context)
    );
  }
}
