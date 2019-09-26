import 'package:app_spese/widgets/chart.dart';
import 'package:app_spese/widgets/lista_transazioni.dart';

import 'models/transazione.dart';
import 'widgets/nuova_transazione.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Spese',
      theme: ThemeData(
          primarySwatch: Colors.lightGreen,
          accentColor: Colors.lightBlue,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                button: TextStyle(
                  color: Colors.white,
                ),
              ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // String nuovoTitolo;
  // String nuovoImporto;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transazione> _transazioniUtente = [
    // Transazione(
    //   id: 't1',
    //   titolo: 'prova',
    //   importo: 50.99,
    //   data: DateTime.now(),
    // ),
    // Transazione(
    //   id: 't2',
    //   titolo: 'prova2',
    //   importo: 530.99,
    //   data: DateTime.now(),
    // ),
    // Transazione(
    //   id: 't3',
    //   titolo: 'prova3',
    //   importo: 24.93,
    //   data: DateTime.now(),
    // ),
  ];

  bool _mostraGrafico = false;

  List<Transazione> get _transazioniRecenti {
    return _transazioniUtente.where((tx) {
      return tx.data.isAfter(
        DateTime.now().subtract(Duration(days: 7)),
      );
    }).toList();
  }

  void _aggiungiTransazione(
      String titoloNew, double importoNew, DateTime dataNew) {
    final newTx = new Transazione(
        titolo: titoloNew,
        importo: importoNew,
        data: dataNew,
        id: DateTime.now().toString());

    setState(() {
      _transazioniUtente.add(newTx);
    });
  }

  void _startNuovaTransazione(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NuovaTransazione(_aggiungiTransazione);
      },
    );
  }

  void _cancellaTransazione(String idToDelete) {
    setState(() {
      _transazioniUtente.removeWhere((tx) => tx.id == idToDelete);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool orizzontale =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text(
        'Spese',
        style: TextStyle(fontFamily: 'OpenSans'),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startNuovaTransazione(context),
        )
      ],
    );

    final widgetLista = Container(
      child: ListaTransazioni(_transazioniUtente, _cancellaTransazione),
      height: (MediaQuery.of(context).size.height -
          appBar.preferredSize.height -
          MediaQuery.of(context).padding.top),
    );

    return Scaffold(
        appBar: appBar,
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            if (orizzontale)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Mostra grafico"),
                  Switch(
                    value: _mostraGrafico,
                    onChanged: (val) {
                      setState(() {
                        _mostraGrafico = val;
                      });
                    },
                  ),
                ],
              ),
            if (!orizzontale)
              Container(
                child: Chart(_transazioniRecenti),
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.3,
              ),
            if (!orizzontale) widgetLista,
            if (orizzontale)
              _mostraGrafico
                  ? Container(
                      child: Chart(_transazioniRecenti),
                      height: (MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.7,
                    )
                  : widgetLista,
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _startNuovaTransazione(context),
        ));
  }
}
