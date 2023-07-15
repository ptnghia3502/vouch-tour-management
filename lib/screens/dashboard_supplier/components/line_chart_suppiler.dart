// import 'package:admin/controllers/supplier_controller.dart';
// import 'package:admin/models/supplier_chart_model.dart';
// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:intl/intl.dart';
// import '../../../constants.dart';
// import '../../../Authentication/sharedPreferencesManager.dart';

// class SupplierChartWidget extends StatefulWidget {
//   const SupplierChartWidget({super.key});

//   @override
//   State<SupplierChartWidget> createState() => _SupplierChartWidgetState();
// }

// class _SupplierChartWidgetState extends State<SupplierChartWidget> {
//   late SupplierChartModel _data;
//   List<SupplierDataChartModel> _chartData = [];
//   SharedPreferencesManager sharedPreferencesManager =
//       SharedPreferencesManager();

//   late TooltipBehavior _tooltipBehavior;

//   @override
//   void initState() {
//     _chartData = _data.supplierDataChartList;
//     _tooltipBehavior = TooltipBehavior(enable: true);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//             body: SfCartesianChart(
//       title: ChartTitle(text: 'Yearly sales analysis'),
//       legend: Legend(isVisible: true),
//       tooltipBehavior: _tooltipBehavior,
//       series: <SplineSeries>[
//         SplineSeries<SupplierDataChartModel, double>(
//             name: 'Sales',
//             dataSource: _chartData,
//             xValueMapper: (SupplierDataChartModel sups, _) =>
//                 sups.totalMoneyInDate,
//             yValueMapper: (SupplierDataChartModel sups, _) =>
//                 sups.date.difference(sups.date).inDays.toDouble(),
//             dataLabelSettings: DataLabelSettings(isVisible: true),
//             enableTooltip: true,
//             color: Colors.orange,
//             width: 4,
//             opacity: 1,
//             //dashArray: <double>[5, 5],
//             splineType: SplineType.cardinal,
//             cardinalSplineTension: 0.9),
//       ],
//       primaryXAxis: NumericAxis(
//         edgeLabelPlacement: EdgeLabelPlacement.shift,
//       ),
//       primaryYAxis: NumericAxis(
//           labelFormat: '{value}M',
//           numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0)),
//     )));
//   }
// }
