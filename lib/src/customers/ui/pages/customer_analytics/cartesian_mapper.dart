import 'package:flutter/material.dart';
import 'package:loands_flutter/src/loans/domain/entities/loan_entity.dart';
import 'package:loands_flutter/src/utils/core/format_date.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:utils/utils.dart';

class CartesianMapper {

  static List<LineSeries<LoanEntity, String>> getDefaultData(List<LoanEntity> loans) {
    
    const bool isDataLabelVisible = true,
        isMarkerVisible = true;

    double? lineWidth, markerWidth, markerHeight;
    
    return <LineSeries<LoanEntity, String>>[
      LineSeries<LoanEntity, String>(
          enableTooltip: true,
          dataSource: loans,
          xValueMapper: (LoanEntity loan, _) => loan.startDate.format(formatDate: FormatDate.analytics),
          yValueMapper: (LoanEntity loan, _) => loan.amount,
          width: lineWidth ?? 2,
          markerSettings: MarkerSettings(
              isVisible: isMarkerVisible,
              height: markerWidth ?? 4,
              width: markerHeight ?? 4,
              shape: DataMarkerType.circle,
              borderWidth: 3,
              borderColor: Colors.red),
          dataLabelSettings: const DataLabelSettings(
              isVisible: isDataLabelVisible,
              labelAlignment: ChartDataLabelAlignment.auto)),
    ];
  }
}
