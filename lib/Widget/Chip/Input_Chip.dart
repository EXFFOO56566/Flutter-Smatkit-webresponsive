import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Input_Chip extends StatefulWidget {
  @override
  Input_ChipState createState() => Input_ChipState();
}

class Input_ChipState extends State<Input_Chip> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Chip',style: TextStyle(color: Colors.black)),backgroundColor: Colors.white,leading: BackButton(
          color: Colors.black
      ),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: ChipsInput<AppProfile>(
                decoration: InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Profile search'),
                findSuggestions: _findSuggestions,
                onChanged: _onChanged,
                chipBuilder: (BuildContext context, ChipsInputState<AppProfile> state, AppProfile profile) {
                  return InputChip(
                    key: ObjectKey(profile),
                    label: Text(profile.name),
                    avatar: CircleAvatar(
                      backgroundImage: NetworkImage(profile.imageUrl),
                    ),
                    onDeleted: () => state.deleteChip(profile),
                    onSelected: (_) => _onChipTapped(profile),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  );
                },
                suggestionBuilder: (BuildContext context, ChipsInputState<AppProfile> state, AppProfile profile) {
                  return ListTile(
                    key: ObjectKey(profile),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(profile.imageUrl),
                    ),
                    title: Text(profile.name),
                    subtitle: Text(profile.email),
                    onTap: () => state.selectSuggestion(profile),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onChipTapped(AppProfile profile) {
    print('$profile');
  }

  void _onChanged(List<AppProfile> data) {
    print('onChanged $data');
  }

  Future<List<AppProfile>> _findSuggestions(String query) async {
    if (query.length != 0) {
      return mockResults.where((profile) {
        return profile.name.contains(query) || profile.email.contains(query);
      }).toList(growable: false);
    } else {
      return const <AppProfile>[];
    }
  }
}

// -------------------------------------------------

const mockResults = <AppProfile>[
  AppProfile('Stock Man', 'stock@man.com', 'https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX4057996.jpg'),
  AppProfile('Paul', 'paul@google.com', 'https://mbtskoudsalg.com/images/person-stock-image-png.png'),
  AppProfile('Fred', 'fred@google.com', 'https://media.istockphoto.com/photos/feeling-great-about-my-corporate-choices-picture-id507296326'),
  AppProfile('Bera', 'bera@flutter.io', 'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
  AppProfile('John', 'john@flutter.io', 'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
  AppProfile('Thomas', 'thomas@flutter.io', 'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
  AppProfile('Norbert', 'norbert@flutter.io', 'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
  AppProfile('Marina', 'marina@flutter.io', 'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
];

class AppProfile {
  final String name;
  final String email;
  final String imageUrl;

  const AppProfile(this.name, this.email, this.imageUrl);

  @override
  bool operator ==(Object other) => identical(this, other) || other is AppProfile && runtimeType == other.runtimeType && name == other.name;

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() {
    return 'Profile{$name}';
  }
}

// -------------------------------------------------

typedef ChipsInputSuggestions<T> = Future<List<T>> Function(String query);
typedef ChipSelected<T> = void Function(T data, bool selected);
typedef ChipsBuilder<T> = Widget Function(BuildContext context, ChipsInputState<T> state, T data);

class ChipsInput<T> extends StatefulWidget {
  const ChipsInput({
    Key key,
    this.decoration = const InputDecoration(),
    @required this.chipBuilder,
    @required this.suggestionBuilder,
    @required this.findSuggestions,
    @required this.onChanged,
    this.onChipTapped,
  }) : super(key: key);

  final InputDecoration decoration;
  final ChipsInputSuggestions findSuggestions;
  final ValueChanged<List<T>> onChanged;
  final ValueChanged<T> onChipTapped;
  final ChipsBuilder<T> chipBuilder;
  final ChipsBuilder<T> suggestionBuilder;

  @override
  ChipsInputState<T> createState() => ChipsInputState<T>();
}

class ChipsInputState<T> extends State<ChipsInput<T>> implements TextInputClient {
  static const kObjectReplacementChar = 0xFFFC;

  Set<T> _chips = Set<T>();
  List<T> _suggestions;
  int _searchId = 0;

  FocusNode _focusNode;
  TextEditingValue _value = TextEditingValue();
  TextInputConnection _connection;

  String get text => String.fromCharCodes(
        _value.text.codeUnits.where((ch) => ch != kObjectReplacementChar),
      );

  bool get _hasInputConnection => _connection != null && _connection.attached;

  void requestKeyboard() {
    if (_focusNode.hasFocus) {
      _openInputConnection();
    } else {
      FocusScope.of(context).requestFocus(_focusNode);
    }
  }

  void selectSuggestion(T data) {
    setState(() {
      _chips.add(data);
      _updateTextInputState();
      _suggestions = null;
    });
    widget.onChanged(_chips.toList(growable: false));
  }

  void deleteChip(T data) {
    setState(() {
      _chips.remove(data);
      _updateTextInputState();
    });
    widget.onChanged(_chips.toList(growable: false));
  }

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChanged);
  }

  void _onFocusChanged() {
    if (_focusNode.hasFocus) {
      _openInputConnection();
    } else {
      _closeInputConnectionIfNeeded();
    }
    setState(() {
      // rebuild so that _TextCursor is hidden.
    });
  }

  @override
  void dispose() {
    _focusNode?.dispose();
    _closeInputConnectionIfNeeded();
    super.dispose();
  }

  void _openInputConnection() {
    if (!_hasInputConnection) {
      _connection = TextInput.attach(this, TextInputConfiguration());
      _connection.setEditingState(_value);
    }
    _connection.show();
  }

  void _closeInputConnectionIfNeeded() {
    if (_hasInputConnection) {
      _connection.close();
      _connection = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var chipsChildren = _chips
        .map<Widget>(
          (data) => widget.chipBuilder(context, this, data),
        )
        .toList();

    final theme = Theme.of(context);

    chipsChildren.add(
      Container(
        height: 32.0,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              text,
              style: theme.textTheme.subtitle1.copyWith(
                height: 1.5,
              ),
            ),
            _TextCaret(
              resumed: _focusNode.hasFocus,
            ),
          ],
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      //mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: requestKeyboard,
          child: InputDecorator(
            decoration: widget.decoration,
            isFocused: _focusNode.hasFocus,
            isEmpty: _value.text.length == 0,
            child: Wrap(
              children: chipsChildren,
              spacing: 4.0,
              runSpacing: 4.0,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _suggestions?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              return widget.suggestionBuilder(context, this, _suggestions[index]);
            },
          ),
        ),
      ],
    );
  }

  @override
  void updateEditingValue(TextEditingValue value) {
    final oldCount = _countReplacements(_value);
    final newCount = _countReplacements(value);
    setState(() {
      if (newCount < oldCount) {
        _chips = Set.from(_chips.take(newCount));
      }
      _value = value;
    });
    _onSearchChanged(text);
  }

  int _countReplacements(TextEditingValue value) {
    return value.text.codeUnits.where((ch) => ch == kObjectReplacementChar).length;
  }

  @override
  void performAction(TextInputAction action) {
    _focusNode.unfocus();
  }

  void _updateTextInputState() {
    final text = String.fromCharCodes(_chips.map((_) => kObjectReplacementChar));
    _value = TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
      composing: TextRange(start: 0, end: text.length),
    );
    _connection.setEditingState(_value);
  }

  void _onSearchChanged(String value) async {
    final localId = ++_searchId;
    final results = await widget.findSuggestions(value);
    if (_searchId == localId && mounted) {
      setState(() => _suggestions = results.where((profile) => !_chips.contains(profile)).toList(growable: false));
    }
  }

  @override
  void updateFloatingCursor(RawFloatingCursorPoint point) {}

  @override
  void connectionClosed() {}

  @override
  TextEditingValue get currentTextEditingValue => throw UnimplementedError();

  @override
  AutofillScope get currentAutofillScope => throw UnimplementedError();

  @override
  void performPrivateCommand(String action, Map<String, dynamic> data) {}

  @override
  void showAutocorrectionPromptRect(int start, int end) {}
}

class _TextCaret extends StatefulWidget {
  const _TextCaret({
    Key key,
    this.duration = const Duration(milliseconds: 500),
    this.resumed = false,
  }) : super(key: key);

  final Duration duration;
  final bool resumed;

  @override
  _TextCursorState createState() => _TextCursorState();
}

class _TextCursorState extends State<_TextCaret> with SingleTickerProviderStateMixin {
  bool _displayed = false;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(widget.duration, _onTimer);
  }

  void _onTimer(Timer timer) {
    setState(() => _displayed = !_displayed);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FractionallySizedBox(
      heightFactor: 0.7,
      child: Opacity(
        opacity: _displayed && widget.resumed ? 1.0 : 0.0,
        child: Container(
          width: 2.0,
          color: theme.primaryColor,
        ),
      ),
    );
  }
}
