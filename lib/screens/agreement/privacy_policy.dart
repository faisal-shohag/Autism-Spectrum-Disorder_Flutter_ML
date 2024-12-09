import 'package:asd/components/button.dart';
import 'package:flutter/material.dart';

class Privacy extends StatelessWidget {
  const Privacy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 225, 225),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Center(
              child: Icon(
                Icons.privacy_tip,
                size: 80,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                'Privacy Policy',
                style: TextStyle(
                  fontSize: 28,
                  fontFamily: 'geb',
                  // fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Introduction'),
            _buildSectionContent(
                'Welcome to AI Autism Detection! This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our application.'),
            const SizedBox(height: 20),
            _buildSectionTitle('Information Collection'),
            _buildSectionContent(
                'We collect information from you when you use our app. This includes:'),
            _buildBulletPoint('Personal Data'),
            _buildBulletPoint(
                'Demographic information such as age, gender, etc.'),
            _buildBulletPoint(
                'Photographs uploaded by you for autism detection.'),
            _buildBulletPoint('Responses to the questionnaire test.'),
            const SizedBox(height: 20),
            _buildSectionTitle('Use of Information'),
            _buildSectionContent(
                'The information we collect is used for the following purposes:'),
            _buildBulletPoint('To provide accurate autism detection results.'),
            _buildBulletPoint('To improve our machine learning models.'),
            _buildBulletPoint('To notify you of updates and new features.'),
            const SizedBox(height: 20),
            _buildSectionTitle('Information Sharing'),
            _buildSectionContent(
                'We may share your information in the following situations:'),
            _buildBulletPoint(
                'With service providers who assist us in our operations.'),
            _buildBulletPoint('If required by law or to protect our rights.'),
            const SizedBox(height: 20),
            _buildSectionTitle('Data Security'),
            _buildSectionContent(
                'We implement appropriate security measures to protect your data. However, no method of transmission over the internet is completely secure.'),
            const SizedBox(height: 20),
            _buildSectionTitle('Your Consent'),
            _buildSectionContent(
                'By using our app, you consent to our Privacy Policy.'),
            const SizedBox(height: 20),
            _buildSectionTitle('Changes to This Policy'),
            _buildSectionContent(
                'We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new policy on this page.'),
            const SizedBox(height: 20),
            _buildSectionTitle('Contact Us'),
            _buildSectionContent(
                'If you have any questions or suggestions about our Privacy Policy, do not hesitate to contact us at:'),
            _buildBulletPoint('Email: cse.zasim@gmail.com'),
            const SizedBox(height: 50),
            Center(
                child: GestureDetector(
              onTap: () => {Navigator.pop(context)},
              child: FullButton(
                buttonColor: Colors.black,
                buttonText: 'Back',
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 22,
        fontFamily: 'geb',
        // fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        content,
        style: const TextStyle(
          fontSize: 16,
          fontFamily: 'gsb',
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 18)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontFamily: 'geb',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
