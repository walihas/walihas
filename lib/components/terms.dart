import 'package:flutter/material.dart';

class Terms {
  
void showTermsAndConditions(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => DraggableScrollableSheet(
      expand: false,
      builder: (context, scrollController) => Container(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'WaliCare Terms and Conditions',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              
              _buildSectionTitle('1. Introduction'),
              _buildSectionContent(
                  'Welcome to WaliCare ("we," "us," or "our"). WaliCare is a free telehealth application that facilitates messaging between clinics and patients, helps organize appointments, and stores patient information such as name and date of birth. By accessing or using WaliCare ("the App"), you agree to be bound by these Terms and Conditions ("Terms"). If you do not agree to these Terms, please do not use the App.'),
              _buildSectionTitle('2. Acceptance of Terms'),
              _buildSectionContent(
                  'By downloading, accessing, or using the App, you acknowledge that you have read, understood, and agree to be bound by these Terms and any additional terms and conditions referenced herein.'),
              _buildSectionTitle('3. Description of Service'),
              _buildSectionContent(
                  'WaliCare provides a platform for clinics and patients to communicate via messaging, organize appointments, and store essential patient information like name and date of birth. All data is stored securely in Firebase, a cloud-hosted database service.'),
              _buildSectionTitle('4. User Eligibilit y'),
              _buildSectionContent(
                  'You must be at least 18 years old or have the consent of a parent or legal guardian to use the App. By using the App, you represent and warrant that you meet these eligibility requirements.'),
              _buildSectionTitle('5. User Responsibilities'),
              _buildBulletPoint(
                  '**Account Security:** You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account.'),
              _buildBulletPoint(
                  '**Accurate Information:** You agree to provide accurate and complete information, including your name and date of birth, when creating an account and using the App.'),
              _buildBulletPoint(
                  '**Prohibited Conduct:** You agree not to use the App for any unlawful or prohibited activities, including but not limited to transmitting harmful or illegal content.'),
              _buildSectionTitle('6. Privacy Policy'),
              _buildSectionContent(
                  'Your privacy is important to us. Please review our Privacy Policy to understand how we collect, use, and protect your personal information, including your name and date of birth.'),
              _buildSectionTitle('7. Data Storage and Security'),
              _buildBulletPoint(
                  '**Data Storage:** All messages, appointment information, and personal data such as name and date of birth are stored securely in Firebase.'),
              _buildBulletPoint(
                  '**Security Measures:** We implement reasonable security measures to protect your data but cannot guarantee absolute security.'),
              _buildSectionTitle('8. Intellectual Property'),
              _buildSectionContent(
                  'All content, features, and functionality of the App, including but not limited to text, graphics, logos, and software, are the exclusive property of WaliCare and are protected by international copyright, trademark, patent, trade secret, and other intellectual property laws.'),
              _buildSectionTitle('9. Disclaimers'),
              _buildBulletPoint(
                  '**No Medical Advice:** The App is not intended to provide medical advice or diagnosis. Always consult a qualified healthcare provider for medical concerns.'),
              _buildBulletPoint(
                  '**As-Is Basis:** The App is provided on an "as-is" and "as-available" basis without warranties of any kind.'),
              _buildSectionTitle('10. Limitation of Liability'),
              _buildSectionContent(
                  'In no event shall WaliCare, its developers, or affiliates be liable for any indirect, incidental, special, consequential, or punitive damages arising out of or related to your use of the App.'),
              _buildSectionTitle('11. Indemnification'),
              _buildSectionContent(
                  'You agree to indemnify, defend, and hold harmless WaliCare and its affiliates from any claims, liabilities, damages, losses, or expenses arising out of your use of the App or violation of these Terms.'),
              _buildSectionTitle('12. Changes to the Terms'),
              _buildSectionContent(
                  'We reserve the right to modify these Terms at any time. Any changes will be effective immediately upon posting the revised Terms in the App. Your continued use of the App following the posting of changes constitutes your acceptance of such changes.'),
              _buildSectionTitle('13. Termination'),
              _buildSectionContent(
                  'We may terminate or suspend your access to the App immediately, without prior notice, for any reason whatsoever, including but not limited to a breach of these Terms.'),
              _buildSectionTitle('14. Governing Law'),
              _buildSectionContent(
                  'These Terms shall be governed and construed in accordance with the laws of the United States, without regard to its conflict of law provisions.'),
              _buildSectionTitle('15. Contact Information'),
              _buildSectionContent(
                  'If you have any questions about these Terms, please contact us at:'),
              _buildBulletPoint('**Email:** walihasan844@gmail.com'),
              const SizedBox(height: 16.0),
            
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _buildSectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Text(
      title,
      style: const TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _buildSectionContent(String content) {
  return Text(
    content,
    style: const TextStyle(fontSize: 14.0),
  );
}

Widget _buildBulletPoint(String text) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('•  ', style: TextStyle(fontSize: 14.0)),
      Expanded(
        child: Text(
          text,
          style: const TextStyle(fontSize: 14.0),
        ),
      ),
    ],
  );
}
}
