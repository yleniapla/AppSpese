import 'package:app_spese/models/transazione.dart';
import 'package:app_spese/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transazione> transazioniRecenti;

  Chart(this.transazioniRecenti);

  List<Map<String, Object>> get valoreTransazioniRaggruppate {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(
        Duration(days: index),
      );

      double tot = 0;

      for (var i = 0; i < transazioniRecenti.length; i++) {
        if (transazioniRecenti[i].data.day == weekday.day &&
            transazioniRecenti[i].data.month == weekday.month &&
            transazioniRecenti[i].data.year == weekday.year) {
          tot += transazioniRecenti[i].importo;
        }
      }

      return {
        'day': DateFormat.E().format(weekday).substring(0, 1),
        'amount': tot,
      };
    }).reversed.toList();
  }

  double get spesaMassima {
    return valoreTransazioniRaggruppate.fold(0.0, (somma, item) {
      return somma + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: valoreTransazioniRaggruppate.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                data['day'],
                data['amount'],
                spesaMassima == 0
                    ? 0
                    : (data['amount'] as double) / spesaMassima,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
