import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DeveloperScreen extends StatelessWidget {
  const DeveloperScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Developers Information'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildDeveloperCard(
              'Suyog Khanal',
              '8848suyog@gmail.com',
              'https://www.linkedin.com/in/suyog-khanal-354331173/',
              '',
            ),
            const SizedBox(width: 8,),
            _buildDeveloperCard(
              'Nazneen Alam',
              'alamnazneen99@gmail.com',
              'https://www.linkedin.com/in/nazneen-alam-500457213/',
              '',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeveloperCard(
      String name,
      String email,
      String linkedInUrl,
      String modelInfo,
      ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage('assets/$name.jfif'),
            ),
            const SizedBox(height: 28),
            Text(
              name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 28),
            Text(
              email,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              modelInfo,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.brown,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () async {
                if (!await canLaunch(linkedInUrl)) {
                  await launch(linkedInUrl);
                } else {
                  throw 'Could not launch $linkedInUrl';
                }
              },
              child: Text(
                'Visit my LinkedIn profile',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
