import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wms_mobile/models/picklist.dart';

class PickingForm extends StatefulWidget {
  final String _id;

  PickingForm(this._id);
  
  @override
  _State createState() => _State();
}

class _State extends State<PickingForm> {
  late Future<Picklist> _data;
  late String _id;
  bool _loading = false;

  String _productCode = '';
  String _baseQuantity = '';
  String _locationCode = '';

  Future<Picklist> _getData([data = null]) async {
    final response;

    if (data == null) {
      response = await http.get(Uri.parse(dotenv.env['API_URL'].toString() + '/picking/' + _id + '/data'));
    } else {
      response = data;
    }
    
    return Picklist.fromJson(jsonDecode(response.body));
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
      Uri.parse(dotenv.env['API_URL'].toString() + '/picking/' + _id + '/submit'),
      headers: {
        'Accept': 'application/json'
      },
      body: {
        'product_code': _productCode,
        'base_quantity': _baseQuantity,
        'location_code': _locationCode
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
        content: Text('Picking success.'),
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
        child: Text('No outstanding item.')
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: snapshot.data!.outstanding.length,
      itemBuilder: (BuildContext context, int index) {
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
                          'Outstanding Pick Quantity :',
                          style: TextStyle(
                            fontWeight: FontWeight.w600
                          )
                        )
                      )
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(snapshot.data!.outstanding[index].baseQuantity)
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 10
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Source Location :',
                          style: TextStyle(
                            fontWeight: FontWeight.w600
                          )
                        )
                      )
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(snapshot.data!.outstanding[index].locationCode)
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
    return FutureBuilder<Picklist>(
      future: _data,
      builder: (context, snapshot) {
        if (snapshot.hasData && !_loading) {
          return DefaultTabController(
            length: 3,
            initialIndex: 1,
            child: Scaffold(
              appBar: AppBar(
                title: Text('Picking'),
                bottom: TabBar(
                  tabs: const [
                    Tab(
                      child: Text('Info')
                    ),
                    Tab(
                      child: Text('Picking')
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
                                        'Movement ID',
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
                                        'Movement Date',
                                        style: TextStyle(fontWeight: FontWeight.bold)
                                      )
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        snapshot.data!.date
                                      )
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 10
                                      )
                                    )
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
                                    Center(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          hintText: 'Source Location'
                                        ),
                                        onChanged: (value) => {
                                          setState(() {
                                            _locationCode = value;
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
