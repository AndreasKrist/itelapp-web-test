class Course {
  final String id;
  final String title;
  final String category;
  final String? certType;
  final double rating;
  final String duration;
  final String price;
  final String? funding;
  final bool isFavorite;
  final List<String>? deliveryMethods;
  final String? startDate;
  final String? outline;
  final String? consultant;
  final String? progress;
  final String? completionDate;

  Course({
    required this.id,
    required this.title,
    required this.category,
    this.certType,
    required this.rating,
    required this.duration,
    required this.price,
    this.funding,
    this.isFavorite = false,
    this.deliveryMethods,
    this.startDate,
    this.outline,
    this.consultant,
    this.progress,
    this.completionDate,
  });

  Course copyWith({
    String? id,
    String? title,
    String? category,
    String? certType,
    double? rating,
    String? duration,
    String? price,
    String? funding,
    bool? isFavorite,
    List<String>? deliveryMethods,
    String? startDate,
    String? outline,
    String? consultant,
    String? progress,
    String? completionDate,
  }) {
    return Course(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      certType: certType ?? this.certType,
      rating: rating ?? this.rating,
      duration: duration ?? this.duration,
      price: price ?? this.price,
      funding: funding ?? this.funding,
      isFavorite: isFavorite ?? this.isFavorite,
      deliveryMethods: deliveryMethods ?? this.deliveryMethods,
      startDate: startDate ?? this.startDate,
      outline: outline ?? this.outline,
      consultant: consultant ?? this.consultant,
      progress: progress ?? this.progress,
      completionDate: completionDate ?? this.completionDate,
    );
  }

  static List<Course> sampleCourses = [
    Course(
      id: '1',
      title: 'Network Security Fundamentals',
      category: 'Cybersecurity',
      certType: 'CEH',
      rating: 4.8,
      duration: '8 weeks',
      price: '\$1,299',
      funding: 'Eligible for funding',
      deliveryMethods: ['Online', 'In-person'],
      startDate: 'March 15, 2025',
      outline: 'Introduction to network security, Threat assessment, Security protocols, Penetration testing, Vulnerability scanning, Security best practices',
      consultant: 'Dr. Sarah Chen',
    ),
    Course(
      id: '2',
      title: 'Cloud Infrastructure Management',
      category: 'Cloud Computing',
      certType: 'CCNA',
      rating: 4.6,
      duration: '10 weeks',
      price: '\$1,499',
      funding: 'Not eligible for funding',
      deliveryMethods: ['Online', 'Hybrid'],
      startDate: 'April 5, 2025',
      outline: 'Cloud computing fundamentals, AWS/Azure/GCP services, Infrastructure as code, Cloud security, Scaling and performance optimization',
      consultant: 'Mark Johnson',
    ),
    Course(
      id: '3',
      title: 'Advanced Network Management',
      category: 'Networking',
      certType: 'CCNP',
      rating: 4.9,
      duration: '12 weeks',
      price: '\$1,899',
      funding: 'Eligible for funding',
      deliveryMethods: ['In-person'],
      startDate: 'May 10, 2025',
      outline: 'Advanced routing protocols, Network design, Troubleshooting methodologies, Performance optimization, Enterprise network management',
      consultant: 'Alex Wong',
    ),
    Course(
      id: '4',
      title: 'Data Security and Privacy',
      category: 'Cybersecurity',
      certType: 'SCTP',
      rating: 4.7,
      duration: '6 weeks',
      price: '\$999',
      funding: 'Eligible for funding',
      deliveryMethods: ['Online'],
      startDate: 'March 22, 2025',
      outline: 'Data protection regulations, Encryption technologies, Privacy by design, Data breach response, Security governance',
      consultant: 'Lisa Murphy',
    ),
  ];

  static List<Course> userCourseHistory = [
    Course(
      id: '1',
      title: 'Network Security Fundamentals',
      category: 'Cybersecurity',
      certType: 'CEH',
      rating: 4.8,
      duration: '8 weeks',
      price: '\$1,299',
      completionDate: 'Jan 15, 2025',
      consultant: 'Dr. Sarah Chen',
    ),
    Course(
      id: '2',
      title: 'Cloud Infrastructure Management',
      category: 'Cloud Computing',
      certType: 'CCNA',
      rating: 4.6,
      duration: '10 weeks',
      price: '\$1,499',
      progress: '40% complete',
      consultant: 'Mark Johnson',
    ),
  ];
}