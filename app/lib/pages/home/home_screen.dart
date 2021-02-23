import 'package:app/providers/radio_control_provider.dart';
import 'package:app/providers/remote_device_ip_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _tryToConnect(BuildContext context) async {
    context.refresh(remoteConnectionProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(flex: 2, child: const Header()),
            Expanded(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const PreviousButton(),
                  const PlayButton(),
                  const NextButton(),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Consumer(
                  builder: (_, watch, child) {
                    final remoteConnectionAsyncStatus =
                        watch(remoteConnectionProvider);
                    final ip = watch(remoteIpProvider.state);
                    return remoteConnectionAsyncStatus.map(
                        data: (connected) => connected.value
                            ? Text('connected to $ip')
                            : RaisedButton(
                                child: Text('Try again'),
                                onPressed: () async =>
                                    await _tryToConnect(context),
                              ),
                        loading: (_) => child,
                        error: (_) => Text(_.error.toString()));
                  },
                  child: CircularProgressIndicator(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Header extends HookWidget {
  const Header({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          flex: 1,
          child: Image.network(
              'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/Rai_Radio_1_-_Logo_2017.svg/1200px-Rai_Radio_1_-_Logo_2017.svg.png',
              fit: BoxFit.contain),
        ),
        Text('Current station', style: Theme.of(context).textTheme.headline3),
      ],
    );
  }
}

class PreviousButton extends HookWidget {
  const PreviousButton({Key key}) : super(key: key);

  void _onPress() {}

  @override
  Widget build(BuildContext context) {
    final connected = useProvider(remoteIpProvider.state) != null;
    final enabledColor = Theme.of(context).colorScheme.primary;
    final disabledColor = Colors.grey;
    return FlatButton(
      height: 40,
      onPressed: connected ? _onPress : null,
      child: Icon(Icons.skip_previous,
          size: 38, color: connected ? enabledColor : disabledColor),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
          side: BorderSide(color: connected ? enabledColor : disabledColor)),
    );
  }
}

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
    final connected = useProvider(remoteIpProvider.state) != null;
    final playing = useProvider(radioControlProvider.state);
    return RaisedButton(
      onPressed: connected ? () async => await _onPress(context) : null,
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Icon(
          playing ? Icons.pause : Icons.play_arrow,
          size: 50,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      shape: CircleBorder(),
    );
  }
}

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
