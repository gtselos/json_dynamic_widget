import 'package:child_builder/child_builder.dart';
import 'package:flutter/material.dart';
import 'package:form_validation/form_validation.dart';
import 'package:json_class/json_class.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';
import 'package:json_theme/json_theme.dart';

/// Builder that can build an [DropdownButtonFormField] widget.  See the
/// [fromDynamic] for the format.
class JsonDropdownButtonFormFieldBuilder extends JsonWidgetBuilder {
  JsonDropdownButtonFormFieldBuilder({
    this.autofocus,
    this.autovalidate,
    this.decoration,
    this.disabledHint,
    this.dropdownColor,
    this.elevation,
    this.enabled,
    this.focusColor,
    this.focusNode,
    this.hint,
    this.icon,
    this.iconSize,
    this.items,
    this.iconDisabledColor,
    this.iconEnabledColor,
    this.isDense,
    this.isExpanded,
    this.itemHeight,
    this.onChanged,
    this.onSaved,
    this.onTap,
    this.selectedItemBuilder,
    this.validator,
    this.style,
    this.value,
  });

  static const type = 'dropdown_button_form_field';

  final bool autofocus;
  final bool autovalidate;
  final dynamic decoration;
  final JsonWidgetData disabledHint;
  final Color dropdownColor;
  final int elevation;
  final bool enabled;
  final Color focusColor;
  final FocusNode focusNode;
  final JsonWidgetData hint;
  final JsonWidgetData icon;
  final dynamic items;
  final Color iconDisabledColor;
  final double iconSize;
  final Color iconEnabledColor;
  final bool isDense;
  final bool isExpanded;
  final double itemHeight;
  final ValueChanged onChanged;
  final FormFieldSetter onSaved;
  final VoidCallback onTap;
  final dynamic selectedItemBuilder;
  final Validator validator;
  final TextStyle style;
  final dynamic value;

  /// Builds the builder from a Map-like dynamic structure.  This expects the
  /// JSON format to be of the following structure:
  ///
  /// ```json
  /// {
  ///   "autofocus": <bool>,
  ///   "autovalidate": <bool>,
  ///   "decoration": <InputDecorationDecoder>,
  ///   "disabledHint": <JsonWidgetData>,
  ///   "dropdownColor": <Color>,
  ///   "elevation": <int>,
  ///   "enabled": <bool>,
  ///   "focusColor": <Color>,
  ///   "focusNode": <FocusNode>,
  ///   "hint": <JsonWidgetData>,
  ///   "icon": <JsonWidgetData>,
  ///   "items": <String[] | Map<String, dynamic>>,
  ///   "iconDisabledColor": <Color>,
  ///   "iconEnabledColor": <Color>,
  ///   "iconSize": <double>,
  ///   "isDense": <bool>,
  ///   "isExpanded": <bool>,
  ///   "itemHeight": <double>,
  ///   "onChanged": <ValueChanged>,
  ///   "onSaved": <FormFieldSetter>,
  ///   "onTap": <VoidCallback>,
  ///   "selectedItemBuilder": <DropdownButtonBuilder | JsonWidgetData>,
  ///   "validators": <ValueValidator[]>,
  ///   "style": <TextStyle>,
  ///   "value": <dynamic>,
  /// }
  /// ```
  ///
  /// As a note, the [FocusNode], [ValueChanged], [FormFieldSetter], and
  /// [VoidCallback] objects cannot be decoded via JSON.  Instead, the only way
  /// to bind those values to the builder is to use a function or a variable
  /// reference via the [JsonWidgetRegistry].
  ///
  /// The `selectedItemBuilder` can be a [DropdownButtonBuilder] or
  /// [JsonWidgetData].  The [DropdownButtonBuilder] cannot be decoded via JSON
  /// and would have to be bound via the [JsonWidgetRegistry].  If a
  /// [JsonWidgetData] object is used then the item's display will be bound to
  /// the `dropdown_item_display` variable on the registry and the item's value
  /// will be bound to `dropdown_item_value`.  This way the widget can associate
  /// properties to those two keys for proper rendering.
  ///
  /// The `items` can be either a string array where the string will be used for
  /// both the display and the value or a map of strings to values where the key
  /// will be used as the display and the value will be the internal dropdown
  /// value.
  ///
  /// See also:
  ///  * [buildCustom]
  ///  * [InputDecorationDecoder.fromDynamic]
  ///  * [JsonWidgetData.fromDynamic]
  ///  * [ThemeDecoder.decodeColor]
  ///  * [ThemeDecoder.decodeTextStyle]
  ///  * [Validator]
  static JsonDropdownButtonFormFieldBuilder fromDynamic(
    dynamic map, {
    JsonWidgetRegistry registry,
  }) {
    JsonDropdownButtonFormFieldBuilder result;

    if (map != null) {
      result = JsonDropdownButtonFormFieldBuilder(
        autofocus: JsonClass.parseBool(map['autofocus']),
        autovalidate: JsonClass.parseBool(map['autovalidate']),
        decoration: map['decoration'],
        disabledHint: JsonWidgetData.fromDynamic(map['disabledHint']),
        dropdownColor: ThemeDecoder.decodeColor(
          map['dropdownColor'],
          validate: false,
        ),
        elevation: JsonClass.parseInt(map['elevation'], 8),
        enabled:
            map['enabled'] == null ? true : JsonClass.parseBool(map['enabled']),
        hint: JsonWidgetData.fromDynamic(map['hint']),
        icon: JsonWidgetData.fromDynamic(map['icon']),
        items: map['items'],
        iconDisabledColor: ThemeDecoder.decodeColor(
          map['iconDisabledColor'],
          validate: false,
        ),
        iconEnabledColor: ThemeDecoder.decodeColor(
          map['iconEnabledColor'],
          validate: false,
        ),
        iconSize: JsonClass.parseDouble(map['iconSize'], 24.0),
        isDense:
            map['isDense'] == null ? true : JsonClass.parseBool(map['isDense']),
        isExpanded: JsonClass.parseBool(map['isExpanded']),
        itemHeight: JsonClass.parseDouble(map['itemHeight']),
        onChanged: map['onChanged'],
        onSaved: map['onSaved'],
        onTap: map['onTap'],
        selectedItemBuilder: map['selectedItemBuilder'],
        validator: map['validators'] == null
            ? null
            : Validator.fromDynamic({'validators': map['validators']}),
        style: ThemeDecoder.decodeTextStyle(
          map['style'],
          validate: false,
        ),
        value: map['value'],
      );
    }

    return result;
  }

  /// Removes any / all values this builder may have set from the
  /// [JsonWidgetRegistry].
  @override
  void remove(JsonWidgetData data) {
    if (data.id?.isNotEmpty == true) {
      data.registry.removeValue(data.id);
    }

    super.remove(data);
  }

  /// Builds the widget to render to the tree.  If the [data] object has a
  /// non-empty `id` associated with it and the [enabled] property is [true]
  /// then this will attach the selected value to the [JsonWidgetRegistry]
  /// using the `id` as the key any time the selected value is changed.
  ///
  /// Likewise, this will set any error messages using the key '$id.error'.  An
  /// empty string will be used to represent no error message.
  @override
  Widget buildCustom({
    ChildWidgetBuilder childBuilder,
    @required BuildContext context,
    @required JsonWidgetData data,
    Key key,
  }) {
    assert(
      data.children?.isNotEmpty != true,
      '[JsonDropdownButtonFormFieldBuilder] does not support children.',
    );

    return _JsonDropdownButtonFormFieldWidget(
      builder: this,
      childBuilder: childBuilder,
      data: data,
    );
  }
}

class _JsonDropdownButtonFormFieldWidget extends StatefulWidget {
  _JsonDropdownButtonFormFieldWidget({
    this.builder,
    this.childBuilder,
    this.data,
    Key key,
  }) : super(key: key);

  final JsonDropdownButtonFormFieldBuilder builder;
  final ChildWidgetBuilder childBuilder;
  final JsonWidgetData data;

  @override
  _JsonDropdownButtonFormFieldWidgetState createState() =>
      _JsonDropdownButtonFormFieldWidgetState();
}

class _JsonDropdownButtonFormFieldWidgetState
    extends State<_JsonDropdownButtonFormFieldWidget> {
  InputDecoration _decoration;
  List<DropdownMenuItem> _items;
  DropdownButtonBuilder _selectedItemBuilder;
  dynamic _value;

  @override
  void initState() {
    super.initState();

    if (widget.builder.decoration != null) {
      _decoration = InputDecorationDecoder.fromDynamic(
        widget.builder.decoration,
        childBuilder: widget.childBuilder,
        context: context,
        registry: widget.data.registry,
      );
    }

    var itemEntries = <String, dynamic>{};
    if (widget.builder.items != null) {
      var items = <DropdownMenuItem>[];

      if (widget.builder.items is List) {
        widget.builder.items.forEach((value) {
          items.add(
            DropdownMenuItem(
              value: value,
              child: Text(value.toString()),
            ),
          );
          itemEntries[value] = value;
        });
      } else {
        widget.builder.items.forEach((key, value) {
          items.add(
            DropdownMenuItem(
              value: value,
              child: Text(key),
            ),
          );
          itemEntries[key] = value;
        });
      }

      _items = items;
    }

    if (widget.builder.selectedItemBuilder != null) {
      if (widget.builder.selectedItemBuilder is JsonWidgetData) {
        _selectedItemBuilder = (BuildContext context) {
          var widgets = <Widget>[];
          itemEntries.forEach((key, value) {
            widget.data.registry.setValue('dropdown_item_display', key);
            widget.data.registry.setValue('dropdown_item_value', value);

            widget.builder.selectedItemBuilder.recreate().build(
                  childBuilder: widget.childBuilder,
                  context: context,
                );
          });

          return widgets;
        };
      } else {
        _selectedItemBuilder = widget.builder.selectedItemBuilder;
      }
    }

    _value = widget.builder.value;
  }

  @override
  Widget build(BuildContext context) => DropdownButtonFormField(
        autofocus: widget.builder.autofocus,
        autovalidate: widget.builder.autovalidate,
        decoration: _decoration ?? const InputDecoration(),
        disabledHint: widget.builder.disabledHint?.build(
          childBuilder: widget.childBuilder,
          context: context,
        ),
        dropdownColor: widget.builder.dropdownColor,
        elevation: widget.builder.elevation,
        focusColor: widget.builder.focusColor,
        focusNode: widget.builder.focusNode,
        hint: widget.builder.hint?.build(
          childBuilder: widget.childBuilder,
          context: context,
        ),
        icon: widget.builder.icon?.build(
          childBuilder: widget.childBuilder,
          context: context,
        ),
        items: _items,
        iconDisabledColor: widget.builder.iconDisabledColor,
        iconEnabledColor: widget.builder.iconEnabledColor,
        iconSize: widget.builder.iconSize,
        isDense: widget.builder.isDense,
        isExpanded: widget.builder.isExpanded,
        itemHeight: widget.builder.itemHeight,
        onChanged: widget.builder.enabled != true
            ? null
            : (value) {
                if (widget.builder.onChanged != null) {
                  widget.builder.onChanged(value);
                }
                _value = value;
                if (mounted == true) {
                  setState(() {});
                }

                if (widget.data.id?.isNotEmpty == true) {
                  widget.data.registry.setValue(
                    widget.data.id,
                    value,
                  );
                }
              },
        onSaved: widget.builder.onSaved,
        onTap: widget.builder.onTap,
        selectedItemBuilder: _selectedItemBuilder,
        validator: widget.builder.validator == null
            ? null
            : (value) {
                var error = widget.builder.validator.validate(
                  context: context,
                  label: _decoration?.labelText ?? '',
                  value: value?.toString(),
                );

                if (widget.data.id?.isNotEmpty == true) {
                  widget.data.registry
                      .setValue('${widget.data.id}.error', error ?? '');
                }

                return error;
              },
        style: widget.builder.style,
        value: _value,
      );
}
