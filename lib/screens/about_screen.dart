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
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.blue[700],
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text(
                  'ITEL',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          // Our Mission
          _buildSectionTitle('Our Mission'),
          const SizedBox(height: 12),
          Text(
            'ITEL was founded in 2001 by Franky Espehana in response to the increasing demand for IT training services. With its early origins as a New Horizons franchise, the company has moved forward to rebrand to the present day ITEL.\n\nHeadquartered in Singapore, ITEL is an authorized Accredited Training Organization (ATO) and Continuing Education Training (CET), service provider of industry training courses in the area of IT and Business. Training sessions are conducted on premise within its training centre, externally within client site and remotely.',
            style: TextStyle(
              color: Colors.grey[800],
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          
          // Why Choose Us
          _buildSectionTitle('Why Choose Us'),
          const SizedBox(height: 12),
          _buildFeatureItem(
            icon: Icons.verified_user,
            title: 'Certified Trainers',
            description: 'All our trainers are certified professionals with extensive industry experience.',
          ),
          _buildFeatureItem(
            icon: Icons.book,
            title: 'Comprehensive Curriculum',
            description: 'Our courses are designed to provide in-depth knowledge and practical skills.',
          ),
          _buildFeatureItem(
            icon: Icons.business_center,
            title: 'Industry Recognition',
            description: 'ITEL certifications are recognized by leading companies worldwide.',
          ),
          _buildFeatureItem(
            icon: Icons.support_agent,
            title: '24/7 Support',
            description: 'Our dedicated support team is always available to assist you.',
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
                  detail: 'itel.sg@gmail.com',
                ),
                const Divider(),
                _buildContactItem(
                  icon: Icons.phone,
                  title: 'Phone',
                  detail: '021-7777777',
                ),
                const Divider(),
                _buildContactItem(
                  icon: Icons.location_on,
                  title: 'Address',
                  detail: '123 Education St, Learning City, Singapore',
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Social Media
          _buildSectionTitle('Connect With Us'),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialButton(Icons.facebook, Colors.blue[800]!),
              _buildSocialButton(Icons.language, Colors.green[700]!),
              _buildSocialButton(Icons.chat, Colors.orange[700]!),
              _buildSocialButton(Icons.link, Colors.blue[400]!),
            ],
          ),
          
          const SizedBox(height: 32),
          
          // Newsletter subscription
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue[100]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Stay Updated',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Subscribe to our newsletter to get the latest news and updates about our courses and events.',
                  style: TextStyle(
                    color: Colors.blue[800],
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[700],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Subscribe'),
                  ),
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
          Column(
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
        ],
      ),
    );
  }
  
  Widget _buildSocialButton(IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}