// ignore_for_file: file_names
class TourPackage {
  List? image;
  String? place;
  String? country;
  String? about;
  double? rating;
  List? packageOffered;
  List? activities;
  String? price;

  TourPackage(this.image, this.place, this.country, this.about, this.rating,
      this.packageOffered, this.activities, this.price);

  static List<TourPackage> tourPackage = [
    TourPackage(
      [
        'assets/krabi-1.jpg',
        'assets/krabi-2.jpg',
        'assets/krabi-3.jpg',
        'assets/krabi-4.jpg',
        'assets/krabi-5.jpg',
        'assets/krabi-6.jpg',
        'assets/krabi-7.jpg',
        'assets/krabi-8.jpg',
      ],
      'Raylay Beach',
      'Thailand',
      'Railay Beach, located in Thailand, is renowned for its stunning limestone cliffs, pristine sands, and clear waters, attracting climbers and beach enthusiasts alike.',
      4.7,
      ['5 Days', '3 Star Hotel'],
      ['Kayaking', 'Snorkeling', 'Rock Climbing', 'Beach Relaxation'],
      '1000.00',
    ),
    TourPackage(
      [
        'assets/new-york-1.jpg',
        'assets/new-york-2.jpeg',
        'assets/new-york-3.jpeg',
        'assets/new-york-4.jpeg',
      ],
      'Manhattan',
      'New York',
      'Explore iconic landmarks like Times Square, Central Park, and the Empire State Building. Shop on Fifth Avenue, stroll the High Line, and enjoy Broadway shows on this Manhattan Sightseeing Tour.',
      5.0,
      ['7 Days', '5 Star Hotel'],
      ['Visit Times Square', 'Explore Central Park', 'Walk along Fifth Avenue', 'Visit Museums and Cultural Institutions', 'Take a Ferry to Statue of Liberty', 'Visit the Empire State Building'],
      '2000.00',
    ),
    TourPackage(
      [
        'assets/paris-1.jpeg',
        'assets/paris-2.jpeg',
        'assets/paris-3.jpg',
        'assets/paris-4.jpeg',
        'assets/paris-5.jpeg',
      ],
      'Eiffel Tower',
      'Paris',
      'Ascend iconic Eiffel Tower for stunning views of Paris. Enjoy restaurants, souvenir shopping, and museum visits. Capture memories and experience the city\'s beauty from above.',
      4.5,
      ['3 Days', '4 Star Hotel'],
      ['Ascend the Tower', 'Enjoy the View', 'Visit the Museum', 'Dine at the Restaurants', 'Shop for Souvenirs', 'Attend Special Events'],
      '3000.00',
    ),
    TourPackage(
      [
        'assets/seoul-1.jpeg',
        'assets/seoul-2.jpeg',
        'assets/seoul-3.jpeg',
        'assets/seoul-4.jpeg',
        'assets/seoul-5.jpg',
      ],
      'Palace Tour',
      'South Korea',
      'Explore historic Korean palaces like Gyeongbokgung and Changdeokgung. Learn about royal life, see changing of the guard ceremonies, and stroll through beautiful gardens on a Palace Tour in Seoul.',
      4.0,
      ['5 Days', '4 Star Hotel'],
      ['Explore Palace Grounds', 'Attend Cultural Performance', 'Witness Changing of the Guard Ceremony', 'Visit Throne Halls and Royal Quarters'],
      '4000.00',
    ),
    TourPackage(
      [
        'assets/swiss-1.jpeg',
        'assets/swiss-2.jpeg',
        'assets/swiss-3.jpeg',
        'assets/swiss-4.jpeg',
        'assets/swiss-5.jpeg',
      ],
      'Swiss City Tour',
      'Switzerland',
      'Explore Swiss cities like Zurich, Geneva, Basel, and Bern. Discover landmarks, museums, and vibrant neighborhoods. Enjoy shopping, dining, and cultural experiences in the heart of Switzerland.',
      5.0,
      ['3 Days', '5 Star Hotel'],
      ['Sightseeing', 'Museum Visits', 'Shopping', 'Cultural Events'],
      '5000.00',
    ),
  ];

  static map(Null Function(dynamic tour) param0) {}
}

class Review {
  final String userName;
  final double rating;
  final String reviewText;
  final String package;

  Review({required this.userName, required this.rating, required this.reviewText, required this.package});

  static List reviews = [
    Review(userName: 'amirul', rating: 4.5, reviewText: 'Railay Beach is a paradise on Earth! Crystal-clear waters, majestic limestone cliffs, and serene atmosphere. The only drawback was overcrowding during peak hours. Overall, a must-visit destination for beach lovers!', package: 'Railay Beach - Thailand'),
    Review(userName: 'Haziq', rating: 5.0, reviewText: 'The Eiffel Tower tour was breathtaking! Spectacular views, informative guide, and worth the wait despite the long lines. Highly recommended for anyone visiting Paris. Unforgettable experience!', package: 'Eiffel Tower - New York'),
  ];
}

