
import 'package:greenmind/data/models/field_model/field_model.dart';


abstract class BaseFieldRepository{
  Future<FieldCreated?> createdNewField(String name, String year, String sowingDate, String cropType, List<List<double>> coordinates) async {}
}