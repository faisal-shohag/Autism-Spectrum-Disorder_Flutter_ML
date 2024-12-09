import 'package:asd/components/button.dart';
import 'package:flutter/material.dart';

class Terms extends StatelessWidget {
  const Terms({super.key});

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
                Icons.gavel,
                size: 80,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                'Terms of Use',
                style: TextStyle(
                  fontSize: 28,
                  fontFamily: 'geb',
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Introduction'),
            _buildSectionContent(
                'Welcome to AI Autism Detection! These Terms of Use govern your use of our application and services. By using our app, you agree to comply with these terms.'),
            const SizedBox(height: 20),
            _buildSectionTitle('User Responsibilities'),
            _buildSectionContent(
                'As a user, you are responsible for your actions while using our app. This includes:'),
            _buildBulletPoint(
                'Providing accurate information for the detection process.'),
            _buildBulletPoint('Using the app in a lawful manner.'),
            _buildBulletPoint('Respecting the privacy and rights of others.'),
            const SizedBox(height: 20),
            _buildSectionTitle('Prohibited Actions'),
            _buildSectionContent(
                'You agree not to engage in any of the following prohibited activities:'),
            _buildBulletPoint(
                'Uploading any content that is illegal, harmful, or violates the rights of others.'),
            _buildBulletPoint(
                'Attempting to interfere with the proper functioning of the app.'),
            _buildBulletPoint(
                'Using the app for any unauthorized commercial purposes.'),
            const SizedBox(height: 20),
            _buildSectionTitle('Intellectual Property'),
            _buildSectionContent(
                'All content and materials available on the app, including but not limited to text, graphics, and logos, are the intellectual property of AI Autism Detection and are protected by applicable copyright and trademark laws.'),
            const SizedBox(height: 20),
            _buildSectionTitle('Termination'),
            _buildSectionContent(
                'We reserve the right to terminate or suspend your access to the app at any time, without prior notice or liability, for any reason whatsoever, including without limitation if you breach the Terms.'),
            const SizedBox(height: 20),
            _buildSectionTitle('Limitation of Liability'),
            _buildSectionContent(
                'In no event shall AI Autism Detection, nor its directors, employees, partners, agents, suppliers, or affiliates, be liable for any indirect, incidental, special, consequential, or punitive damages, including without limitation, loss of profits, data, use, goodwill, or other intangible losses, resulting from your use of the app.'),
            const SizedBox(height: 20),
            _buildSectionTitle('Changes to Terms'),
            _buildSectionContent(
                'We reserve the right, at our sole discretion, to modify or replace these Terms at any time. If a revision is material, we will provide at least 30 days notice prior to any new terms taking effect.'),
            const SizedBox(height: 20),
            _buildSectionTitle('Contact Us'),
            _buildSectionContent(
                'If you have any questions or suggestions about our Terms of Use, do not hesitate to contact us at:'),
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
