class Video {
  final String? id;
  final String? title;
  final String? thumb;
  final String? channel;
  final String? publishedAt;

  Video({required this.id, required this.title, required this.thumb, required this.channel, required this.publishedAt});

  factory Video.fromJson(Map<String, dynamic> json) {
    if (json.keys.contains("id")) {
      return Video(
        id: json["id"]["videoId"],
        title: json["snippet"]["title"],
        thumb: json["snippet"]["thumbnails"]["high"]["url"],
        channel: json["snippet"]["channelTitle"],
        publishedAt: json["snippet"]["publishedAt"],
      );
    }

    return Video(
      id: json["videoId"],
      title: json["title"],
      thumb: json["thumb"],
      channel: json["channel"],
      publishedAt: json["publishedAt"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "videoId": id,
      "title": title,
      "thumb": thumb,
      "channel": channel,
      "publishedAt": publishedAt,
    };
  }
}
