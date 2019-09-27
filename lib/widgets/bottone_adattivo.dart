import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Bottone extends StatelessWidget {

  final Function handler;
  final String testo;

  Bottone(this.handler, this.testo);

  @override
  Widget build(BuildContext context) {
    return  Platform.isIOS
                        ? CupertinoButton(
                            child: Text(
                              testo,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            onPressed: handler,
                          )
                        : FlatButton(
                            textColor: Theme.of(context).primaryColor,
                            child: Text(
                              testo,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            onPressed: handler,
                          );
  }
}