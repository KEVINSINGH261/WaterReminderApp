import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class PageHistorique extends StatefulWidget {
  PageHistorique({super.key});

  @override
  State<StatefulWidget> createState() => PageHistoriqueState();
}

class PageHistoriqueState extends State<PageHistorique> {
  List<BarChartGroupData> barGroups = [];
  bool isLoading = true;
  late DateTime firstDayOfWeek;

  @override
  void initState() {
    super.initState();
    firstDayOfWeek = DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));
    fetchWaterData();
  }

  Future<void> fetchWaterData() async {
    List<BarChartGroupData> fetchedBarGroups = [];

    for (int i = 0; i < 7; i++) {
      DateTime date = firstDayOfWeek.add(Duration(days: i));
      String formattedDate = DateFormat('yyyy-MM-dd').format(date);
      print('Fetching data for date: $formattedDate'); // Debug

      DocumentSnapshot doc =
      await FirebaseFirestore.instance.collection('Water').doc(formattedDate).get();
      double fillLevel = 0.0;

      if (doc.exists) {
        fillLevel = doc['eauQuotidienne'];
        print('Data for $formattedDate: fillLevel = $fillLevel'); // Debug
      } else {
        print('No data for $formattedDate'); // Debug
      }

      fetchedBarGroups.add(BarChartGroupData(
        x: i,
        barRods: [BarChartRodData(toY: fillLevel, color: Colors.blue)],
      ));
    }

    setState(() {
      barGroups = fetchedBarGroups;
      isLoading = false;
    });

    print('Fetched bar groups: $fetchedBarGroups'); // Debug
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'images/img.png',
          width: 50.0,
          height: 50.0,
        ),
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Container(
          width: 400,
          height: 400,
          margin: const EdgeInsets.only(right: 13),
          child: BarChart(
            BarChartData(
              gridData: FlGridData(show: false),
              barGroups: barGroups,
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      const style = TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      );
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        space: 8.0,
                        child: Text(value.toInt().toString(), style: style),
                      );
                    },
                    reservedSize: 50,
                  ),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      const style = TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      );
                      String text = DateFormat('E').format(firstDayOfWeek.add(Duration(days: value.toInt())));
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        child: Text(text, style: style),
                      );
                    },
                    reservedSize: 40,
                  ),
                ),
              ),
              borderData: FlBorderData(show: false),
            ),
          ),
        ),
      ),
    );
  }
}
