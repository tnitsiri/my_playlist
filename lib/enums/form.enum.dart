import 'package:json_annotation/json_annotation.dart';
import 'package:recase/recase.dart';

// ANCHOR Form Mode Enum
@JsonEnum()
enum FormModeEnum {
  @JsonValue('CREATE')
  create,

  @JsonValue('UPDATE')
  update;

  // Key
  String get key {
    return name.constantCase;
  }
}
