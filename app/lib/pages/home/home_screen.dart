import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                  const PreviouButton(),
                  const PlayButton(),
                  const NextButton(),
                ],
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

class PreviouButton extends HookWidget {
  const PreviouButton({Key key}) : super(key: key);

  void _onPress() {}

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      height: 40,
      onPressed: _onPress,
      child: Icon(Icons.skip_previous,
          size: 38, color: Theme.of(context).primaryColor),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
          side: BorderSide(color: Theme.of(context).colorScheme.primary)),
    );
  }
}

class PlayButton extends HookWidget {
  const PlayButton({Key key}) : super(key: key);

  void _onPress() {}

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: _onPress,
      color: Theme.of(context).primaryColor,
      child: Icon(
        Icons.play_arrow,
        size: 50,
        color: Theme.of(context).colorScheme.onPrimary,
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
    return FlatButton(
      height: 40,
      onPressed: _onPress,
      child: Icon(Icons.skip_next,
          size: 38, color: Theme.of(context).primaryColor),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
          side: BorderSide(color: Theme.of(context).colorScheme.primary)),
    );
  }
}
