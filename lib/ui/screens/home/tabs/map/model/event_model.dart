class Event {
  final String id;
  final String title;
  final String description;
  final String city;
  final String? imageUrl;
  final double latitude;
  final double longitude;

  const Event({
    required this.id,
    required this.title,
    required this.description,
    required this.city,
    this.imageUrl,
    required this.latitude,
    required this.longitude,
  });

  static final List<Event> egyptEvents = [
    Event(
      id: '1',
      title: 'Cairo International Book Fair',
      description:
      'One of the largest book fairs in the Middle East featuring local and international publishers, cultural seminars, and author signings.',
      city: 'Cairo',
      imageUrl: 'assets/maps_images/birthday.png',
      latitude: 30.0726,
      longitude: 31.3009,
    ),
    Event(
      id: '2',
      title: 'Cairo International Film Festival',
      description:
      'An annual film festival showcasing international and regional films with red carpet premieres and awards ceremonies.',
      city: 'Cairo',
      imageUrl: 'assets/maps_images/bookclub.png',
      latitude: 30.0444,
      longitude: 31.2357,
    ),
    Event(
      id: '3',
      title: 'Sound and Light Show - Pyramids',
      description:
      'A spectacular night show at the Pyramids of Giza featuring lights, music, and storytelling about ancient Egyptian history.',
      city: 'Giza',
      imageUrl: 'assets/maps_images/exhibitation.png',
      latitude: 29.9792,
      longitude: 31.1342,
    ),
    Event(
      id: '4',
      title: 'Abu Simbel Sun Festival',
      description:
      'A unique solar alignment phenomenon at Abu Simbel Temple celebrated with cultural performances and traditional music.',
      city: 'Aswan',
      imageUrl: 'assets/maps_images/gaming.png',
      latitude: 22.3372,
      longitude: 31.6258,
    ),
    Event(
      id: '5',
      title: 'El Gouna Film Festival',
      description:
      'A prestigious film festival held in the Red Sea resort town featuring international films, celebrities, and workshops.',
      city: 'El Gouna',
      imageUrl: 'assets/maps_images/holiday.png',
      latitude: 27.3942,
      longitude: 33.6783,
    ),
    Event(
      id: '6',
      title: 'Alexandria Summer Festival',
      description:
      'A cultural and music festival featuring concerts, theatrical performances, and artistic shows during the summer season.',
      city: 'Alexandria',
      imageUrl: 'assets/maps_images/meeting.png',
      latitude: 31.2001,
      longitude: 29.9187,
    ),
    Event(
      id: '7',
      title: 'Sharm El Sheikh International Theater Festival',
      description:
      'An international youth theater festival gathering performers from different countries for competitions and workshops.',
      city: 'Sharm El Sheikh',
      imageUrl: 'assets/maps_images/sport.png',
      latitude: 27.9158,
      longitude: 34.3300,
    ),
    Event(
      id: '8',
      title: 'Luxor African Film Festival',
      description:
      'A festival dedicated to African cinema promoting cultural exchange between African countries.',
      city: 'Luxor',
      imageUrl: 'assets/maps_images/workshop.png',
      latitude: 25.6872,
      longitude: 32.6396,
    ),
  ];
}
