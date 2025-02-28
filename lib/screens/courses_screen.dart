import 'package:flutter/material.dart';
import '../models/course.dart';
import '../models/user.dart';
import '../widgets/course_card.dart';
import '../widgets/filter_modal.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  List<Course> courses = Course.sampleCourses;
  String activeFilter = 'all';
  bool showFilters = false;

  void _toggleFavorite(Course course) {
    setState(() {
      List<String> updatedFavorites = List.from(User.currentUser.favoriteCoursesIds);
      if (updatedFavorites.contains(course.id)) {
        updatedFavorites.remove(course.id);
      } else {
        updatedFavorites.add(course.id);
      }
      User.currentUser = User.currentUser.copyWith(
        favoriteCoursesIds: updatedFavorites,
      );
    });
  }

  List<Course> get filteredCourses {
    if (activeFilter == 'all') {
      return courses;
    } else if (activeFilter == 'funding') {
      return courses.where((course) => course.funding?.contains('Eligible') ?? false).toList();
    } else if (activeFilter == 'noFunding') {
      return courses.where((course) => !(course.funding?.contains('Eligible') ?? true)).toList();
    } else if (activeFilter == 'short') {
      return courses.where((course) {
        final weeks = int.tryParse(course.duration.split(' ')[0]) ?? 0;
        return weeks < 8;
      }).toList();
    } else if (activeFilter == 'long') {
      return courses.where((course) {
        final weeks = int.tryParse(course.duration.split(' ')[0]) ?? 0;
        return weeks >= 8;
      }).toList();
    } else if (activeFilter == 'ccna') {
      return courses.where((course) => course.certType == 'CCNA').toList();
    } else if (activeFilter == 'ceh') {
      return courses.where((course) => course.certType == 'CEH').toList();
    } else if (activeFilter == 'ccnp') {
      return courses.where((course) => course.certType == 'CCNP').toList();
    } else if (activeFilter == 'sctp') {
      return courses.where((course) => course.certType == 'SCTP').toList();
    } else if (activeFilter == 'priceLow') {
      return List.from(courses)..sort((a, b) {
        final aPrice = double.tryParse(a.price.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0;
        final bPrice = double.tryParse(b.price.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0;
        return aPrice.compareTo(bPrice);
      });
    } else if (activeFilter == 'priceHigh') {
      return List.from(courses)..sort((a, b) {
        final aPrice = double.tryParse(a.price.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0;
        final bPrice = double.tryParse(b.price.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0;
        return bPrice.compareTo(aPrice);
      });
    } else if (activeFilter == 'duration') {
      return List.from(courses)..sort((a, b) {
        final aWeeks = int.tryParse(a.duration.split(' ')[0]) ?? 0;
        final bWeeks = int.tryParse(b.duration.split(' ')[0]) ?? 0;
        return aWeeks.compareTo(bWeeks);
      });
    }
    return courses;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Courses',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showFilters = true;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.filter_list,
                            size: 18,
                            color: Colors.blue[700],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Filter',
                            style: TextStyle(
                              color: Colors.blue[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              
              if (filteredCourses.isEmpty)
                Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.search_off,
                        size: 48,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No courses found',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Try adjusting your filters or search criteria',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredCourses.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) => CourseCard(
                    course: filteredCourses[index],
                    onFavoriteToggle: _toggleFavorite,
                  ),
                ),
            ],
          ),
        ),
        
        // Filter modal
        if (showFilters)
          GestureDetector(
            onTap: () {
              setState(() {
                showFilters = false;
              });
            },
            child: Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  child: FilterModal(
                    activeFilter: activeFilter,
                    onFilterSelected: (filter) {
                      setState(() {
                        activeFilter = filter;
                      });
                    },
                    onApply: () {
                      setState(() {
                        showFilters = false;
                      });
                    },
                    onCancel: () {
                      setState(() {
                        activeFilter = 'all';
                        showFilters = false;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}