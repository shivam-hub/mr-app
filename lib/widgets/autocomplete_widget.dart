import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../themes/app_colors.dart';
import '/services/api_services.dart';
import '/services/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

const Duration debounceDuration = Duration(milliseconds: 500);

class AutoCompleteWidget<T> extends StatefulWidget {
  final String placeholder;
  final String prefixText;
  final bool readOnly;
  final void Function(T)? onSelected;
  final void Function(String)? onEditingComplete;
  final String? Function(String?)? validator;
  final String? initialValue;

  const AutoCompleteWidget(
      {super.key,
      required this.prefixText,
      required this.placeholder,
      this.onSelected,
      this.onEditingComplete,
      this.readOnly = false,
      this.initialValue,
      this.validator});

  @override
  State<AutoCompleteWidget<T>> createState() => _AutoCompleteWidgetState<T>();
}

class _AutoCompleteWidgetState<T> extends State<AutoCompleteWidget<T>> {
  String? _currentQuery;

  late Iterable<String> _lastOptions = <String>[];

  late final _Debounceable<Iterable<String>?, String> _debouncedSearch;

  void handleEnteredText(String enteredText) {
    debugPrint('Entered Text: $enteredText');

    if (widget.onSelected != null) {
      widget.onEditingComplete!(enteredText);
    }
  }

  Future<Iterable<String>?> _search(String query) async {
    _currentQuery = query;

    late final Iterable<String> options;
    try {
      options = await GetOptionsAsync().search(_currentQuery!);
    } catch (error) {
      rethrow;
    }

    if (_currentQuery != query) {
      return null;
    }
    _currentQuery = null;

    return options;
  }

  @override
  void initState() {
    super.initState();
    _debouncedSearch = _debounce<Iterable<String>?, String>(_search);
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete(
      initialValue: TextEditingValue(text: widget.initialValue ?? ''),
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextFormField(
            style: GoogleFonts.montserrat(),
            readOnly: widget.readOnly,
            enabled: !widget.readOnly,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              labelStyle: GoogleFonts.montserrat(),
              filled: true,
              fillColor: Colors.transparent,
              labelText: widget.placeholder,
              prefixText: widget.prefixText,
              floatingLabelStyle: GoogleFonts.montserrat(
                color: AppColors.appThemeDarkShade1,
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.appThemeDarkShade1,
                  style: BorderStyle.solid,
                ),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.appThemeDarkShade1,
                  style: BorderStyle.solid,
                ),
              ),
            ),
            controller: controller,
            focusNode: focusNode,
            onFieldSubmitted: (String value) {
              onFieldSubmitted();
            },
            validator: widget.validator,
            onChanged: (value) {
              if (widget.onEditingComplete != null) {
                widget.onEditingComplete!(value);
              }
            });
      },
      optionsBuilder: (TextEditingValue textEditingValue) async {
        final Iterable<String>? options =
            await _debouncedSearch(textEditingValue.text);
        if (options == null) {
          return _lastOptions;
        }
        _lastOptions = options;
        return options;
      },
      onSelected: (String selection) async {
        final optionNode =
            await GetOptionsAsync().getSelectedOptionNode(selection);
        widget.onSelected!(optionNode as T);
      },
    );
  }
}

class GetOptionsAsync {
  Iterable<String> _options = [];
  Future<Iterable<String>> search(String query) async {
    final pref = await SharedPreferences.getInstance();
    final apiService = locator<ApiService>();
    if (query == '') {
      return const Iterable<String>.empty();
    }
    final response = await apiService.getOptions(query: query);
    await pref.setString('autoCompleteOptions', json.encode(response));
    _options = response
        .map((jsonObject) => jsonObject['name'].toString())
        .where((name) => name.toLowerCase().contains(query.toLowerCase()));
    return _options;
  }

  Future<Map<String, dynamic>> getSelectedOptionNode(
      String selectedOption) async {
    try {
      final pref = await SharedPreferences.getInstance();

      final options = pref.getString('autoCompleteOptions') ?? '';
      final optionJson = json.decode(options);

      return optionJson.firstWhere(
          (element) =>
              element['name'].toString().toLowerCase() ==
              selectedOption.toLowerCase(),
          orElse: () => null);
    } catch (e) {
      rethrow;
    }
  }
}

typedef _Debounceable<S, T> = Future<S?> Function(T parameter);

_Debounceable<S, T> _debounce<S, T>(_Debounceable<S?, T> function) {
  _DebounceTimer? debounceTimer;

  return (T parameter) async {
    if (debounceTimer != null && !debounceTimer!.isCompleted) {
      debounceTimer!.cancel();
    }
    debounceTimer = _DebounceTimer();
    try {
      await debounceTimer!.future;
    } catch (error) {
      if (error is _CancelException) {
        return null;
      }
      rethrow;
    }
    return function(parameter);
  };
}

class _DebounceTimer {
  _DebounceTimer() {
    _timer = Timer(debounceDuration, _onComplete);
  }

  late final Timer _timer;
  final Completer<void> _completer = Completer<void>();

  void _onComplete() {
    _completer.complete();
  }

  Future<void> get future => _completer.future;

  bool get isCompleted => _completer.isCompleted;

  void cancel() {
    _timer.cancel();
    _completer.completeError(const _CancelException());
  }
}

class _CancelException implements Exception {
  const _CancelException();
}
