import 'package:child_builder/child_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';

/// Builder that sets a value (or group of values) to the [JsonWidgetRegistry].
/// This doesn't actually have a widget and instead simply returns the child's
/// built widget.  See the [fromDynamic] for the format.
class JsonSetValueBuilder extends JsonWidgetBuilder {
  JsonSetValueBuilder({
    this.values,
  });

  static const type = 'set_value';

  final dynamic values;

  /// Builds the builder from a Map-like dynamic structure.  This expects the
  /// JSON format to be of the following structure:
  ///
  /// ```json
  /// {
  ///   "<key>": <dynamic>
  /// }
  /// ```
  ///
  /// Where the `key` is any arbitrary [String].  That `key` will be used as the
  /// `key` on [JsonWidgetRegistry.setValue] and the [dynamic] value will be
  /// used as the `value`.
  ///
  /// It's recommended against using
  static JsonSetValueBuilder fromDynamic(
    dynamic map, {
    JsonWidgetRegistry registry,
  }) {
    JsonSetValueBuilder result;

    if (map != null) {
      result = JsonSetValueBuilder(values: map);
      registry ??= JsonWidgetRegistry.instance;
      result.values?.forEach((key, value) => registry.setValue(key, value));
    }

    return result;
  }

  @override
  Widget buildCustom({
    ChildWidgetBuilder childBuilder,
    @required BuildContext context,
    @required JsonWidgetData data,
    Key key,
  }) {
    assert(
      data.children?.length == 1 || data.children?.isNotEmpty != true,
      '[JsonSetValueBuilder] only supports zero or one child.',
    );

    return data.children?.isNotEmpty == true
        ? data.children[0].build(
            childBuilder: childBuilder,
            context: context,
          )
        : SizedBox();
  }

  @override
  void remove(JsonWidgetData data) {
    values?.forEach((key, _) => data.registry.removeValue(key));

    super.remove(data);
  }
}
