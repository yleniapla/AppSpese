import 'dart:io';

import 'package:app_spese/widgets/bottone_adattivo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NuovaTransazione extends StatefulWidget {
  final Function aggiungiTx;

  NuovaTransazione(this.aggiungiTx);

  @override
  _NuovaTransazioneState createState() => _NuovaTransazioneState();
}

class _NuovaTransazioneState extends State<NuovaTransazione> {
  final _controllerTitolo = TextEditingController();
  final _controllerImporto = TextEditingController();
  DateTime _dataSelezionata;

  void _submit() {
    final titoloInserito = _controllerTitolo.text;
    final importoInserito = double.parse(_controllerImporto.text);

    if (titoloInserito.isEmpty ||
        importoInserito <= 0 ||
        _dataSelezionata == null) return;

    widget.aggiungiTx(
      titoloInserito,
      importoInserito,
      _dataSelezionata,
    );

    Navigator.of(context).pop();
  }

  void _mostraDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((dataScelta) {
      if (dataScelta == null) return;

      setState(() {
        _dataSelezionata = dataScelta;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Titolo'),
                controller: _controllerTitolo,
                onSubmitted: (_) => _submit(),
                /* onChanged: (val) {
                          nuovoTitolo = val;
                        }, */
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Importo'),
                controller: _controllerImporto,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submit(),
                /* onChanged: (val) {
                          nuovoImporto = val;
                  }, */
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(_dataSelezionata == null
                          ? 'Nessuna data scelta!'
                          : 'Data: ${DateFormat.yMd().format(_dataSelezionata)}'),
                    ),
                   Bottone(_mostraDatePicker, "Scegli una data")
                  ],
                ),
              ),
              Platform.isIOS
                  ? CupertinoButton(
                      child: Text(
                        'Aggiungi transazione',
                      ),
                      color: Theme.of(context).primaryColor,
                      onPressed: _submit,
                    )
                  : RaisedButton(
                      child: Text(
                        'Aggiungi transazione',
                      ),
                      color: Theme.of(context).primaryColor,
                      textColor: Theme.of(context).textTheme.button.color,
                      onPressed: _submit,
                    )
            ],
          ),
        ),
      ),
    );
  }
}
