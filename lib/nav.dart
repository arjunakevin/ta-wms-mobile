import 'package:flutter/material.dart';
import 'package:wms_mobile/screens/dashboard.dart';
import 'package:wms_mobile/screens/inbound_check_search.dart';
import 'package:wms_mobile/screens/putaway_search.dart';
import 'package:wms_mobile/screens/picking_search.dart';
import 'package:wms_mobile/screens/outbound_check_search.dart';

class Nav extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Nav> {
  int _selectedIndex = 2;
  final List<Widget> _widgetOptions = <Widget>[
    InboundCheckSearch(),
    PutawaySearch(),
    Dashboard(),
    PickingSearch(),
    OutboundCheckSearch()
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        unselectedFontSize: 10,
        selectedFontSize: 10,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.arrow_downward), label: 'Inbound Check'),
          BottomNavigationBarItem(
              icon: Icon(Icons.file_download), label: 'Putaway'),
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(
              icon: Icon(Icons.file_upload), label: 'Picking'),
          BottomNavigationBarItem(
              icon: Icon(Icons.arrow_upward), label: 'Outbound Check')
        ],
        onTap: _onItemTap,
      )
    );
  }
}
