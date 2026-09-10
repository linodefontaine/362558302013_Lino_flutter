import 'package:flutter/material.dart';
import 'models/course.dart';
import 'widgets/course_card.dart';
import 'widgets/header_banner.dart';

class AcademicDashboardScreen extends StatefulWidget {
  const AcademicDashboardScreen({super.key});

  @override
  State<AcademicDashboardScreen> createState() => _AcademicDashboardScreenState();
}

class _AcademicDashboardScreenState extends State<AcademicDashboardScreen> {
  final List<Course> _courses = Course.getSampleCourses();
  bool _isDarkMode = false;

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Academic Dashboard'),
        actions: [
          IconButton(
            icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: _toggleDarkMode,
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet = constraints.maxWidth >= 600;

          if (isTablet) {
            // TAMPILAN TABLET: 1 GridView
            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.85, // Ubah ke 0.85 agar card cukup tinggi & tidak overflow
              ),
              itemCount: _courses.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const HeaderBanner();
                }
                return CourseCard(course: _courses[index - 1]);
              },
            );
          } else {
            // TAMPILAN MOBILE: 1 ListView (Tanpa GridView)
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const HeaderBanner(),
                const SizedBox(height: 16),
                ..._courses.map((course) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: CourseCard(course: course),
                    )),
              ],
            );
          }
        },
      ),
    );
  }
}