import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transazione.dart';

class ListaTransazioni extends StatelessWidget {
  final List<Transazione> transazioni;
  final Function cancellazione;

  ListaTransazioni(this.transazioni, this.cancellazione);

  @override
  Widget build(BuildContext context) {
    return transazioni.isEmpty
        ? Column(
            children: <Widget>[
              Text('Ancora nessuna transazione!!!',
                  style: Theme.of(context).textTheme.title),
              SizedBox(
                height: 20,
              ),
              Container(
                child:
                    Image.asset('assets/images/waiting.png', fit: BoxFit.cover),
                height: 200,
              ),
            ],
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: FittedBox(
                        child: Text('€${transazioni[index].importo}'),
                      ),
                    ),
                  ),
                  title: Text(transazioni[index].titolo,
                      style: Theme.of(context).textTheme.title),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transazioni[index].data),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                    onPressed: () => cancellazione(transazioni[index].id),
                  ),
                ),
              );
            },
            itemCount: transazioni.length,
          );
  }
}
