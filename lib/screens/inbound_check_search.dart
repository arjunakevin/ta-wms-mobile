import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wms_mobile/screens/inbound_check_form.dart';

class InboundCheckSearch extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<InboundCheckSearch> {
  String _id = '';
  bool _loading = false;

  void _submit() async {
    setState(() {
      _loading = true;
    });

    await Future.delayed(Duration(seconds: 1));

    setState(() {
      _loading = false;
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InboundCheckForm())
    );

    // _showAlertDialog(context);
  }

  void _showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: Text("Close"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Message"),
      content: Text("This is my message."),
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
              child: TextButton(
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Good Receive'),
      ),
      body: _getWidget(context)
    );
  }
}
