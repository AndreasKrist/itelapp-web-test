import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About ITEL',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 24),
          
          // Logo or image
          Center(
            child: Container(
              width: 160,
              height: 160,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Image.asset(
                'assets/images/itel.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          // Vision section
          _buildVisionMissionSection(
            title: 'Vision',
            content: 'A World Class Life-Long Learning Center',
            bgColor: Colors.blue[50]!,
            textColor: Colors.blue[800]!,
          ),
          const SizedBox(height: 24),
          
          // Mission section with icons
          _buildSectionTitle('Mission'),
          const SizedBox(height: 16),
          _buildMissionGrid(),
          const SizedBox(height: 24),
          
          // Our Story
          _buildSectionTitle('Our Story'),
          const SizedBox(height: 12),
          Text(
            'ITEL was founded in 2001 by Franky Espehana in response to the increasing demand for IT training services. With its early origins as a New Horizons franchise, the company has moved forward to rebrand to the present day ITEL.\n\nHeadquartered in Singapore, ITEL is an authorized Accredited Training Organization (ATO) and Continuing Education Training (CET), service provider of industry training courses in the area of IT and Business. Training sessions are conducted on premise within its training centre, externally within client site and remotely.',
            style: TextStyle(
              color: Colors.grey[800],
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'In collaboration with Singapore Government affiliated organizations such as SkillsFuture Singapore (SSG), ITEL has been entrusted with funded and subsidized training courses. We also collaborate closely with internationally recognised industry vendors like EC-Council, CompTIA, Microsoft, and PeopleCert. This provides you and your team with the skills and knowledge necessary to excel in the rapidly evolving IT landscape.',
            style: TextStyle(
              color: Colors.grey[800],
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'ITEL also offers a customised and or curated approach towards its corporate and group courses. Curriculum and delivery can be crafted to suit each group\'s needs.\n\nAt ITEL, we build on past insights to continuously enhance our training products and services, ensuring they evolve to address current needs and anticipate future advancements.',
            style: TextStyle(
              color: Colors.grey[800],
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          
          // Key Statistics
          _buildSectionTitle('You Can Trust Us'),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatistic(
                  icon: Icons.people,
                  number: '214,842+',
                  label: 'Graduates',
                ),
                _buildStatistic(
                  icon: Icons.book,
                  number: '250+',
                  label: 'No. of Courses',
                ),
                _buildStatistic(
                  icon: Icons.calendar_today,
                  number: '23',
                  label: 'Years in Business',
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Partners section
          _buildSectionTitle('Partners'),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 60,
                          height: 30,
                          color: Colors.transparent,
                          child: Center(
                            child: Text('Microsoft',
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Microsoft Partner',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 60,
                          height: 30,
                          color: Colors.red,
                          child: const Center(
                            child: Text('CompTIA',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.purple[100],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('ITIL',
                                style: TextStyle(
                                  color: Colors.purple[800],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text('Accredited',
                                style: TextStyle(
                                  color: Colors.purple[800],
                                  fontSize: 8,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.orange, width: 2),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Text('EC-Council',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.orange[800],
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Contact Us
          _buildSectionTitle('Contact Us'),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildContactItem(
                  icon: Icons.email,
                  title: 'Email',
                  detail: 'enquiry@itel.com.sg',
                ),
                const Divider(),
                _buildContactItem(
                  icon: Icons.phone,
                  title: 'Phone',
                  detail: '6822 8282',
                ),
                const Divider(),
                _buildContactItem(
                  icon: Icons.location_on,
                  title: 'Address',
                  detail: '1 Maritime Square, HarbourFront Centre #10-24/25 (Lobby B) Singapore 099253',
                ),
                const Divider(),
                _buildContactItem(
                  icon: Icons.language,
                  title: 'Website',
                  detail: 'https://itel.com.sg/',
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Copyright
          Center(
            child: Text(
              '© 2025 ITEL. All rights reserved.',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildVisionMissionSection({
    required String title,
    required String content,
    required Color bgColor,
    required Color textColor,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMissionGrid() {
    return Row(
      children: [
        Expanded(
          child: _buildMissionItem(
            icon: Icons.workspace_premium,
            title: 'Provide World Recognized Certifications',
          ),
        ),
        Expanded(
          child: _buildMissionItem(
            icon: Icons.people,
            title: 'Develop Human Capital for In-Demand Skills',
          ),
        ),
        Expanded(
          child: _buildMissionItem(
            icon: Icons.public,
            title: 'Contribute to Society Through Quality Education',
          ),
        ),
      ],
    );
  }

  Widget _buildMissionItem({required IconData icon, required String title}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 40,
            color: Colors.blue[600],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.blue[800],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildStatistic({required IconData icon, required String number, required String label}) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.blue[500],
          size: 30,
        ),
        const SizedBox(height: 8),
        Text(
          number,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.blue[500],
          ),
        ),
      ],
    );
  }
  
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
  
  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: Colors.blue[700],
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildContactItem({
    required IconData icon,
    required String title,
    required String detail,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.blue[700],
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                Text(
                  detail,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}