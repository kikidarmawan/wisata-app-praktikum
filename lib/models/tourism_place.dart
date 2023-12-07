class TourismPlace {
  final String id;
  final String name;
  final String location;
  final String description;
  final String openDays;
  final String openTime;
  final int ticketPrice;
  final String imageAsset;
  final List<String> images;

  TourismPlace({
    required this.id,
    required this.name,
    required this.location,
    required this.description,
    required this.openDays,
    required this.openTime,
    required this.ticketPrice,
    required this.imageAsset,
    required this.images,
  });

  factory TourismPlace.fromJson(Map<String, dynamic> json) {
    // Parsing list of images
    var imagesList = json['images'] as List<dynamic>;
    List<String> images = imagesList.cast<String>().toList();

    return TourismPlace(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      description: json['description'],
      openDays: json['open_days'],
      openTime: json['open_time'],
      ticketPrice: json['ticket_price'],
      imageAsset: json['imageAsset'],
      images: images,
    );
  }
}
