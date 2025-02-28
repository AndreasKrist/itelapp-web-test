enum TrendingItemType {
  event,
  article,
  news,
}

class TrendingItem {
  final String id;
  final String title;
  final String category;
  final TrendingItemType type;
  final String? date;
  final String? readTime;
  
  TrendingItem({
    required this.id,
    required this.title,
    required this.category,
    required this.type,
    this.date,
    this.readTime,
  });
  
  static List<TrendingItem> sampleItems = [
    TrendingItem(
      id: '1',
      title: '2025 Cybersecurity Summit',
      category: 'Event',
      type: TrendingItemType.event,
      date: 'March 20, 2025',
    ),
    TrendingItem(
      id: '2',
      title: 'New SCTP Certification Path',
      category: 'Certification News',
      type: TrendingItemType.news,
      date: 'Just announced',
    ),
    TrendingItem(
      id: '3',
      title: 'Top Tech Skills for 2025',
      category: 'Career Development',
      type: TrendingItemType.article,
      readTime: '5 min read',
    ),
    TrendingItem(
      id: '4',
      title: 'Future of Online Learning',
      category: 'Education',
      type: TrendingItemType.article,
      readTime: '8 min read',
    ),
    TrendingItem(
      id: '5',
      title: 'Cloud Security Best Practices',
      category: 'Cybersecurity',
      type: TrendingItemType.article,
      readTime: '10 min read',
    ),
    TrendingItem(
      id: '6',
      title: 'Intro to AI & ML Workshop',
      category: 'Event',
      type: TrendingItemType.event,
      date: 'April 15, 2025',
    ),
  ];
}