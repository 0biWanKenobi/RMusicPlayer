class RadioStation {
  final String radioName, image, wideImage, id, shoutcastUrl, format;

  RadioStation(this.radioName, this.image, this.wideImage, this.id,
      this.shoutcastUrl, this.format);

  RadioStation.fromJson(dynamic data)
      : radioName = data['radio_name'],
        image = data['image'],
        wideImage = data['image_flag'],
        id = data['id'],
        shoutcastUrl = data['shoutcast_url'],
        format = data['format'];

  Object toJson() {
    return {
      'radio_name': radioName,
      'image': image,
      'image_flag': wideImage,
      'id': id,
      'shoutcast_url': shoutcastUrl,
      'format': format
    };
  }
}
