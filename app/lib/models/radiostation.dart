class RadioStation {
  final String radioName, image, id, shoutcastUrl, format;

  RadioStation(
      this.radioName, this.image, this.id, this.shoutcastUrl, this.format);

  RadioStation.fromJson(dynamic data)
      : radioName = data['radio_name'],
        image = data['image'],
        id = data['id'],
        shoutcastUrl = data['shoutcast_url'],
        format = data['format'];
}
