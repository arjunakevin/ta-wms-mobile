import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wms_mobile/models/good_receive.dart';

class InboundCheckForm extends StatefulWidget {
  final String _id;

  InboundCheckForm(this._id);
  
  @override
  _State createState() => _State();
}

class _State extends State<InboundCheckForm> {
  late Future<GoodReceive> _data;
  late String _id;
  bool _loading = false;

  String _productCode = '';
  String _baseQuantity = '';

  Future<GoodReceive> _getData([data = null]) async {
    final response;

    if (data == null) {
      response = await http.get(Uri.parse(dotenv.env['API_URL'].toString() + '/gr_check/' + _id + '/data'));
    } else {
      response = data;
    }
    
    return GoodReceive.fromJson(jsonDecode(response.body));
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

  void _submitData(context) async {
    setState(() {
      _loading = true;
    });

    final response = await http.post(
      Uri.parse(dotenv.env['API_URL'].toString() + '/gr_check/' + _id + '/check'),
      headers: {
        'Accept': 'application/json'
      },
      body: {
        'product_code': _productCode,
        'base_quantity': _baseQuantity
      }
    );

    setState(() {
      _loading = false;
    });

    if (response.statusCode == 200) {
      setState(() {
        _data = _getData(response);
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Item check success.'),
        duration: Duration(
          seconds: 1
        ),
      ));
    } else {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;

      String message = jsonResponse['message'];

      _showAlertDialog(message);
    }
  }

  Widget _getOutstandingWidget(snapshot) {
    if (snapshot.data!.outstanding.isEmpty) {
      return Center(
        child: Text('No outstanding product.')
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: snapshot.data!.outstanding.length,
      itemBuilder: (BuildContext context, int index) {
        if (snapshot.data!.outstanding.isEmpty) {
          return Text('No outstanding item');
        }

        return Card(
          elevation: 2,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.zero,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      snapshot.data!.outstanding[index].productCode,
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      )
                    )
                  )
                ),
                Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Description :',
                        style: TextStyle(
                          fontWeight: FontWeight.w600
                        )
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(snapshot.data!.outstanding[index].description),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 10
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Outstanding Check Quantity :',
                          style: TextStyle(
                            fontWeight: FontWeight.w600
                          )
                        )
                      )
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(snapshot.data!.outstanding[index].baseQuantity)
                    )
                  ]
                )
              ],
            )
          )
        );
      },
    );
  }

  void initState() {
    super.initState();
    _id = widget._id;
    _data = _getData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GoodReceive>(
      future: _data,
      builder: (context, snapshot) {
        if (snapshot.hasData && !_loading) {
          return DefaultTabController(
            length: 3,
            initialIndex: 1,
            child: Scaffold(
              appBar: AppBar(
                title: Text('Inbound Item Check'),
                bottom: TabBar(
                  tabs: const [
                    Tab(
                      child: Text('Info')
                    ),
                    Tab(
                      child: Text('Item Check')
                    ),
                    Tab(
                      child: Text('Outstanding')
                    )
                  ]
                )
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 5
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 200.0,
                        child: TabBarView(
                          children: [
                            Card(
                              elevation: 2,
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Good Receive ID',
                                        style: TextStyle(fontWeight: FontWeight.bold)
                                      )
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        snapshot.data!.id.toString()
                                      )
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 10
                                      )
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Reference',
                                        style: TextStyle(fontWeight: FontWeight.bold)
                                      )
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        snapshot.data!.reference
                                      )
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 10
                                      )
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Client Code',
                                        style: TextStyle(fontWeight: FontWeight.bold)
                                      )
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        snapshot.data!.clientCode
                                      )
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 10
                                      )
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Status',
                                        style: TextStyle(fontWeight: FontWeight.bold)
                                      )
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        snapshot.data!.status
                                      )
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 10
                                      )
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Notes',
                                        style: TextStyle(fontWeight: FontWeight.bold)
                                      )
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        snapshot.data!.notes
                                      )
                                    ),
                                  ],
                                )
                              ),
                            ),
                            Card(
                              elevation: 2,
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Center(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          hintText: 'Product Code'
                                        ),
                                        onChanged: (value) => {
                                          setState(() {
                                            _productCode = value;
                                          })
                                        },
                                      ),
                                    ),
                                    Center(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          hintText: 'Base Quantity'
                                        ),
                                        onChanged: (value) => {
                                          setState(() {
                                            _baseQuantity = value;
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
                                        onPressed: () => _submitData(context)
                                      ),
                                    )
                                  ],
                                )
                              ),
                            ),
                            _getOutstandingWidget(snapshot)
                          ],
                        )
                      )
                    )
                  ],
                ),
              )
            )
          );
        }

        // By default, show a loading spinner.
        return Scaffold(
          body: Center(
            child: SpinKitThreeBounce(
              color: Theme.of(context).primaryColor,
              size: 20
            )
          )
        );
      }
    );
  }
}
