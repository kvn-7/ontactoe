import 'pin_model.dart';

class BoxModel {
  final int rowindex;
  final int columnindex;

  PinModel? currentpin;
  BoxModel(
      {required this.rowindex, required this.columnindex, this.currentpin});

  Map<String, dynamic> toJson() {
    return {
      'rowIndex': rowindex,
      'columnIndex': columnindex,
      'currentPin': currentpin?.toJson(),
    };
  }

  factory BoxModel.fromJson(Map<dynamic, dynamic> json) {
    return BoxModel(
        rowindex: json['rowIndex'],
        columnindex: json['columnIndex'],
        currentpin: json['currentPin']);
  }
}
