import 'package:flutter/material.dart';
import 'package:translation_app/AiTranslator.dart';

class AiToolsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(25, 20, 25, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FeatureCard(
              title: 'AI Translator',
              description: 'Translate with AI into any language quickly and accurately.',
              imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSI_A5Wpa9ff7Ote5arkGDkrPs6PYo2HQigTQ&s',
              arrowColor: Colors.red,
              destination: DeepSeekChatScreen(),
              circleColor: Colors.green,
            ),
            FeatureCard(
              title: 'AI Chatbot',
              description: 'Chat with AI for instant answers and ideas.',
              imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8wMTvise9JtT1Jz16NReYYRM0PGVlRjXsxA&s',
              arrowColor: Colors.green,
              circleColor: Colors.red,

            ),
            FeatureCard(
              title: 'Text Summarizer',
              description: 'Summarize articles, documents, and more in seconds.',
              imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWKQXoPMU9pNbH83XD2T9IIFX2r66mrX_RDw&s',
              arrowColor: Colors.orange,
              circleColor: Colors.blue,

            ),





          ],
        ),
      ),



    );

  }
}


class FeatureCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final Color arrowColor;
  final Widget? destination;
  final Color circleColor;

  const FeatureCard({
    Key? key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.arrowColor,
     this.destination,
    required this.circleColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: destination != null
          ? () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination!),
        );
      }
          : null,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(vertical: 8), // space between cards
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 16,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                imageUrl,
                height: 60,
                width: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black87,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            CircleAvatar(
              radius: 18, // size of the circle
              backgroundColor: circleColor,
              child: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.white, // icon color inside
                size: 22,
              ),
            )

          ],
        ),
      ),
    );
  }
}

