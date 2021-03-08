import 'package:app/providers/connection_status_provider.dart';
import 'package:app/providers/radio_control_provider.dart';
import 'package:flutter/foundation.dart' show Key;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PlayButton extends HookWidget {
  const PlayButton({Key key}) : super(key: key);

  Future<void> _onPress(BuildContext context) async {
    final radioController = context.read(radioControlProvider);
    if (radioController.playing)
      await radioController.pause();
    else
      await radioController.play();
  }

  @override
  Widget build(BuildContext context) {
    final connected = useProvider(connectionStatusProvider.state);
    final playing = useProvider(radioControlProvider.state);
    return ElevatedButton(
      onPressed: connected ? () async => await _onPress(context) : null,
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).primaryColor,
        shape: CircleBorder(),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Icon(
          playing ? Icons.pause : Icons.play_arrow,
          size: 50,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
}
