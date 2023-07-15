import 'package:admin/controllers/supplier_controller.dart';
import 'package:admin/models/supplier_chart_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import '../../../constants.dart';
import '../../../Authentication/sharedPreferencesManager.dart';

class SupplierChartWidget extends StatefulWidget {
  const SupplierChartWidget({Key? key}) : super(key: key);

  @override
  _SupplierChartWidgetState createState() => _SupplierChartWidgetState();
}

class _SupplierChartWidgetState extends State<SupplierChartWidget> {
  late SupplierChartModel _data;
  List<SupplierDataChartModel>? _chartData;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    super.initState();
    //_loadChartData();
  }

  Future<void> _loadChartData() async {
    SharedPreferencesManager sharedPreferencesManager =
        SharedPreferencesManager();
    _data = await supplierController
        .getDataSupplierChart(sharedPreferencesManager.getString('id'));
    setState(() {
      _chartData = _data.supplierDataChartList;
      _tooltipBehavior = TooltipBehavior(enable: true);
    });
  }

  Future<SupplierChartModel> _fetchChartData() async {
    SharedPreferencesManager sharedPreferencesManager =
        SharedPreferencesManager();
    SupplierChartModel data = await supplierController
        .getDataSupplierChart(sharedPreferencesManager.getString('id'));
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Scaffold(
            body: FutureBuilder<SupplierChartModel>(
              future: _fetchChartData(), // Call _loadChartData() here
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                return Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: SfCartesianChart(
                    title: ChartTitle(text: 'Yearly sales analysis'),
                    legend: Legend(isVisible: true),
                    tooltipBehavior: _tooltipBehavior,
                    series: <SplineSeries>[
                      SplineSeries<SupplierDataChartModel, double>(
                        name: 'Sales',
                        dataSource: _chartData!,
                        xValueMapper: (SupplierDataChartModel sups, _) =>
                            sups.totalMoneyInDate,
                        yValueMapper: (SupplierDataChartModel sups, _) =>
                            sups.date.difference(sups.date).inDays.toDouble(),
                        dataLabelSettings: DataLabelSettings(isVisible: true),
                        enableTooltip: true,
                        color: Colors.orange,
                        width: 4,
                        opacity: 1,
//dashArray: <double>[5, 5],
                        splineType: SplineType.cardinal,
                        cardinalSplineTension: 0.9,
                      ),
                    ],
                    primaryXAxis: NumericAxis(
                      edgeLabelPlacement: EdgeLabelPlacement.shift,
                    ),
                    primaryYAxis: NumericAxis(
                      labelFormat: '{value}M',
                      numberFormat:
                          NumberFormat.simpleCurrency(decimalDigits: 0),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
