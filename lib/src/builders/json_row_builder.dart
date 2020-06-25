import 'package:child_builder/child_builder.dart';
import 'package:flutter/material.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';
import 'package:json_theme/json_theme.dart';

/// Builder that can build an [Row] widget.  See the [fromDynamic] for the
/// format.
class JsonRowBuilder extends JsonWidgetBuilder {
  JsonRowBuilder({
    this.crossAxisAlignment,
    this.mainAxisAlignment,
    this.mainAxisSize,
    this.textBaseline,
    this.textDirection,
    this.verticalDirection,
  });

  static const type = 'row';

  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final TextBaseline textBaseline;
  final TextDirection textDirection;
  final VerticalDirection verticalDirection;

  /// Builds the builder from a Map-like dynamic structure.  This expects the
  /// JSON format to be of the following structure:
  ///
  /// ```json
  /// {
  ///   "crossAxisAlignment": <CrossAxisAlignment>,
  ///   "mainAxisAlignment": <MainAxisAlignment>,
  ///   "mainAxisSize": <MainAxisSize>,
  ///   "textBaseline": <TextBaseline>,
  ///   "textDirection": <TextDirection>,
  ///   "verticalDirection": <VerticalDirection>
  /// }
  /// ```
  ///
  /// See also:
  ///  * [ThemeDecoder.decodeCrossAxisAlignment]
  ///  * [ThemeDecoder.decodeMainAxisAlignment]
  ///  * [ThemeDecoder.decodeMainAxisSize]
  ///  * [ThemeDecoder.decodeTextBaseline]
  ///  * [ThemeDecoder.decodeTextDirection]
  ///  * [ThemeDecoder.decodeVerticalDirection]
  static JsonRowBuilder fromDynamic(
    dynamic map, {
    JsonWidgetRegistry registry,
  }) {
    JsonRowBuilder result;

    if (map != null) {
      result = JsonRowBuilder(
        crossAxisAlignment: ThemeDecoder.decodeCrossAxisAlignment(
              map['crossAxisAlignment'],
            ) ??
            CrossAxisAlignment.center,
        mainAxisAlignment: ThemeDecoder.decodeMainAxisAlignment(
              map['mainAxisAlignment'],
            ) ??
            MainAxisAlignment.start,
        mainAxisSize: ThemeDecoder.decodeMainAxisSize(map['mainAxisSize']) ??
            MainAxisSize.max,
        textBaseline: ThemeDecoder.decodeTextBaseline(map['textBaseline']),
        textDirection: ThemeDecoder.decodeTextDirection(map['textDirection']),
        verticalDirection:
            ThemeDecoder.decodeVerticalDirection(map['verticalDirection']) ??
                VerticalDirection.down,
      );
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
    return Row(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      textBaseline: textBaseline,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      children: [
        for (var child in data.children ?? [])
          child.build(
            childBuilder: childBuilder,
            context: context,
          ),
      ],
    );
  }
}
