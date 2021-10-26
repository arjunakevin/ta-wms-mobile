import 'package:flutter/material.dart';

class InboundCheckForm extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<InboundCheckForm> {
  final _outstanding = [
    {'product_code': 'PRD-ZXBRSU-333694', 'open_check_quantity': '100 PCS', 'description': 'Exercitationem distinctio sunt voluptatum delectus non velit. Sit dolore voluptas occaecati velit. Unde fugit aut quas ut esse error qui aut.'},
    {'product_code': 'PRD-FZERFU-240681', 'open_check_quantity': '200 PCS', 'description': 'Repudiandae adipisci ut praesentium pariatur nesciunt corrupti. Dolorem libero minus tempora et qui quia. Asperiores id recusandae rem beatae. Omnis illo magnam fuga.'},
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black,
                                          ),
                                          children: const [
                                            TextSpan(
                                              text: 'Good Receive ID',
                                              style: TextStyle(fontWeight: FontWeight.bold)
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black,
                                          ),
                                          children: const [
                                            TextSpan(
                                              text: '1067',
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black,
                                          ),
                                          children: const [
                                            TextSpan(
                                              text: 'Reference',
                                              style: TextStyle(fontWeight: FontWeight.bold)
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black,
                                          ),
                                          children: const [
                                            TextSpan(
                                              text: 'RCV-LOYRDW-565690',
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black,
                                          ),
                                          children: const [
                                            TextSpan(
                                              text: 'Client Code',
                                              style: TextStyle(fontWeight: FontWeight.bold)
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black,
                                          ),
                                          children: const [
                                            TextSpan(
                                              text: 'CLT-MMVITE-589450',
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black,
                                          ),
                                          children: const [
                                            TextSpan(
                                              text: 'Status',
                                              style: TextStyle(fontWeight: FontWeight.bold)
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black,
                                          ),
                                          children: const [
                                            TextSpan(
                                              text: 'Draft',
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black,
                                          ),
                                          children: const [
                                            TextSpan(
                                              text: 'Notes',
                                              style: TextStyle(fontWeight: FontWeight.bold)
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black,
                                          ),
                                          children: const [
                                            TextSpan(
                                              text: 'Est assumenda dignissimos vitae temporibus ut. Aspernatur consequatur possimus ad autem velit praesentium id. Recusandae quasi et reprehenderit consequatur totam qui. Ullam iure iusto sit illum.',
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
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
                                )
                              ),
                              Center(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Base Quantity'
                                  ),
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
                                  onPressed: () => {}
                                ),
                              )
                            ],
                          )
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: 1,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: Container(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: ListTile(
                                isThreeLine: true,
                                title: Text('PRD-FZERFU-240681'),
                                subtitle: Text("Repudiandae adipisci ut praesentium pariatur nesciunt corrupti. Dolorem libero minus tempora et qui quia. Asperiores id recusandae rem beatae. Omnis illo magnam fuga. \n\n100 PCS"),
                              ),
                            ),
                            elevation: 2
                          );
                        },
                      )
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
}
