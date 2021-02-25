import 'package:app/providers/remote_device_ip_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ConnectionStatusWidget extends HookWidget {
  const ConnectionStatusWidget({Key key}) : super(key: key);

  _tryToConnect(BuildContext context) async {
    context.refresh(remoteConnectionProvider);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final textStyle =
        textTheme.bodyText1.copyWith(color: colorScheme.onPrimary);
    return Consumer(
      builder: (_, watch, child) {
        final remoteConnectionAsyncStatus = watch(remoteConnectionProvider);
        final ip = watch(remoteIpProvider.state);
        return remoteConnectionAsyncStatus.map(
            data: (connected) => connected.value
                ? Text('connected to $ip', style: textStyle)
                : RaisedButton(
                    child: Text('Try again', style: textStyle),
                    onPressed: () async => await _tryToConnect(context),
                  ),
            loading: (_) => child,
            error: (_) => Text(_.error.toString(), style: textStyle));
      },
      child: CircularProgressIndicator(
        backgroundColor: colorScheme.onPrimary,
      ),
    );
  }
}
