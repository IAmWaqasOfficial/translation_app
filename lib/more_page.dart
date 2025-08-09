import 'package:flutter/material.dart';
import 'package:translation_app/AiTranslator.dart';
import 'package:translation_app/AiDictionary.dart';

class MorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CustomCard(
              imageUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSmh0g3p5zxD-9oAMKeLvma2INQ6lXEkmZXAg&s',
              title: 'Conversation',
              subtitle: 'Efficient communication in different languages',
              circleColor: Colors.red,
              destination: DeepSeekChatScreen(), // Example destination
            ),
            CustomCard(
              imageUrl:
              'https://thumbs.dreamstime.com/b/logo-online-dictionary-concept-laptop-as-book-99816714.jpg',
              title: 'AI Dictionary',
              subtitle: 'Discover new difficult words and meanings',
              circleColor: Colors.blue,
              destination:DictionaryScreen() ,
              // No destination here → won't be clickable
            ),
          ],
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final Color circleColor;
  final Widget? destination; // Optional navigation target

  const CustomCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.circleColor,
    this.destination,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: destination != null
          ? () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination!),
        );
      }
          : null,
      child: Container(
        height: 120,
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
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
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
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
              radius: 18,
              backgroundColor: circleColor,
              child: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


