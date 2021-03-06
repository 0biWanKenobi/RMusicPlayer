import 'package:app/extensions/EitherX.dart';
import 'package:app/models/radiostation_x.dart';
import 'package:app/pages/home/playlist_widget.dart';
import 'package:app/providers/radio_control_provider.dart';
import 'package:app/services/radio_control_service.dart';
import 'package:flutter/foundation.dart' show Key;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _prevRadioProvider = Provider<RadioStationX>((ref) {
  final radioList =
      ref.watch(radioListProvider).data.value.asRight.value.radioStations;

  final currentRadioIndex = ref.watch(lastPlayedRadioProvider)?.listIndex ?? 0;
  final nextRadioIndex = (currentRadioIndex - 1) % radioList.length;
  final nextRadio = radioList[nextRadioIndex];
  return RadioStationX(nextRadio, nextRadioIndex);
});

class PreviousButton extends HookWidget {
  const PreviousButton({Key key}) : super(key: key);

  Future<void> _onPress(
      BuildContext ctx, RadioControlService radioService) async {
    final nextRadio = ctx.read(_prevRadioProvider);
    ctx.read(userSelectedRadioProvider).state = nextRadio;
    await radioService.playChannel(nextRadio);
  }

  @override
  Widget build(BuildContext context) {
    final buttonEnabled = useProvider(canChangeStationProvider);
    final radioService = useProvider(radioControlProvider);
    final enabledColor = Theme.of(context).colorScheme.primary;
    final disabledColor = Colors.grey;
    return TextButton(
      onPressed: buttonEnabled
          ? () async => await _onPress(context, radioService)
          : null,
      child: Icon(Icons.skip_previous,
          size: 38, color: buttonEnabled ? enabledColor : disabledColor),
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 24),
        side: BorderSide(color: buttonEnabled ? enabledColor : disabledColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
      ),
    );
  }
}
