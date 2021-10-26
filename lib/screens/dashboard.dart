import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Dashboard extends StatefulWidget {
  @override
  _State createState() => _State();
}

class DashboardData {
  late int inboundCount;
  late int grCount;
  late int outboundCount;
  late int doCount;

  DashboardData({
    required this.inboundCount,
    required this.grCount,
    required this.outboundCount,
    required this.doCount
  });

  DashboardData.fromJson(Map<String, dynamic> json) {
    inboundCount = json['inbound_count'];
    grCount = json['gr_count'];
    outboundCount = json['outbound_count'];
    doCount = json['do_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['inbound_count'] = this.inboundCount;
    data['gr_count'] = this.grCount;
    data['outbound_count'] = this.outboundCount;
    data['do_count'] = this.doCount;
    return data;
  }
}

class _State extends State<Dashboard> {
  late Future<DashboardData> _data;

  Future<DashboardData> _getData() async {
    final response = await http.get(Uri.parse(dotenv.env['API_URL'].toString() + '/dashboard'));

    return DashboardData.fromJson(jsonDecode(response.body));
  }

  Card _makeDashboardItem(String title, IconData icon, int count) {
    return Card(
      elevation: 1.0,
      margin: EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
        child: InkWell(
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              SizedBox(height: 50.0),
              Center(
                child: Icon(
                  icon,
                  size: 40.0,
                  color: Colors.black,
                )
              ),
              SizedBox(height: 20.0),
              Center(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: title,
                        style: TextStyle(
                          fontSize: 18.0, color: Colors.black
                        ),
                      ),
                      TextSpan(
                        text: "\nTotal: " + count.toString(),
                        style: TextStyle(
                          fontSize: 12.0, color: Colors.black
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }

  @override
  void initState() {
    super.initState();
    _data = _getData();
  }

  Widget build(BuildContext context) {
    return FutureBuilder<DashboardData>(
      future: _data,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Dashboard'),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
              child: GridView.count(
                crossAxisCount: 2,
                padding: EdgeInsets.all(3.0),
                children: <Widget>[
                  _makeDashboardItem("Inbound Delivery", Icons.arrow_downward, snapshot.data!.inboundCount),
                  _makeDashboardItem("Good Receive", Icons.file_download, snapshot.data!.grCount),
                  _makeDashboardItem("Outbound Delivery", Icons.arrow_upward, snapshot.data!.outboundCount),
                  _makeDashboardItem("Delivery Order", Icons.file_upload, snapshot.data!.doCount),
                ],
              )
            )
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
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
      },
    );
  }
}
