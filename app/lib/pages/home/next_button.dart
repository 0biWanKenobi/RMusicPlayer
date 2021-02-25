import 'package:app/providers/remote_device_ip_provider.dart';
import 'package:flutter/foundation.dart' show Key;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NextButton extends HookWidget {
  const NextButton({Key key}) : super(key: key);

  void _onPress() {}

  @override
  Widget build(BuildContext context) {
    final connected = useProvider(remoteIpProvider.state) != null;
    final enabledColor = Theme.of(context).colorScheme.primary;
    final disabledColor = Colors.grey;

    return FlatButton(
      height: 40,
      onPressed: connected ? _onPress : null,
      child: Icon(Icons.skip_next,
          size: 38, color: connected ? enabledColor : disabledColor),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
          side: BorderSide(color: connected ? enabledColor : disabledColor)),
    );
  }
}
