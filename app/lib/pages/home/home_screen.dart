import 'package:app/pages/home/connection_status_widget.dart';
import 'package:app/pages/home/next_button.dart';
import 'package:app/pages/home/play_button.dart';
import 'package:app/pages/home/playlist_widget.dart';
import 'package:app/pages/home/previous_button.dart';
import 'package:app/providers/radio_control_provider.dart';
import 'package:app/services/radio_control_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends StatelessWidget {
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
            const Expanded(flex: 10, child: const Header()),
            const Divider(color: Colors.grey, thickness: 0.6),
            Expanded(
              flex: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const PreviousButton(),
                  const PlayButton(),
                  const NextButton(),
                ],
              ),
            ),
            const Divider(color: Colors.grey, thickness: 0.6),
            const Expanded(flex: 20, child: const PlaylistWidget()),
            Container(
              color: Theme.of(context).colorScheme.primary,
              height: 60,
              child: const Center(
                child: const ConnectionStatusWidget(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

final _headerImageProvider = Provider<String>((ref) {
  final radioList = ref.watch(radioListProvider).data?.value;
  final userSelectedImage = ref.watch(userSelectedStationImageProvider).state;
  if (radioList == null || radioList.isLeft)
    return userSelectedImage ?? Header.defaultImage;
  return userSelectedImage ??
      radioList.fold<String>((_) => Header.defaultImage,
          (playlist) => playlist.lastPlayed.wideImage);
});

final userSelectedStationImageProvider = StateProvider<String>((_) => null);

class Header extends HookWidget {
  static const defaultImage = 'assets/default_header_image.jpg';
  const Header({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final imagePath = useProvider(_headerImageProvider);

    final radioService = useProvider<RadioControlService>(radioControlProvider);

    return imagePath.compareTo('assets/default_header_image.jpg') == 0
        ? Image.asset(imagePath, fit: BoxFit.contain)
        : Image.network(radioService.generateRadioImage(imagePath),
            fit: BoxFit.contain);
  }
}
