import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool autoSpeak = false;
  bool autoCopy = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12, top: 12),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.orange),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: const [
                Icon(Icons.emoji_events, color: Colors.orange, size: 18),
                SizedBox(width: 4),
                Text('0 Badge', style: TextStyle(color: Colors.orange)),
              ],
            ),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.blue[700],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Icon(Icons.workspace_premium, color: Colors.yellow, size: 32),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Upgrade to Premium',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Unlock all features',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
              ],
            ),
          ),

          const SizedBox(height: 20),


          _buildListTile('Language', 'English', onTap: () {}),


          _buildListTile('Word Game', null, onTap: () {}, ),


          _buildListTile('Add Widget', null, onTap: () {}),

          const SizedBox(height: 30),


          const Text(
            'Auto Translation',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),


          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Auto Speak'),
            value: autoSpeak,
            onChanged: (val) {
              setState(() {
                autoSpeak = val;
              });
            },
          ),


          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Auto Copy'),
            value: autoCopy,
            onChanged: (val) {
              setState(() {
                autoCopy = val;
              });
            },
          ),

          const SizedBox(height: 30),


        ],
      ),
    );
  }

  Widget _buildListTile(String title, String? subtitle,
      {Widget? trailing, required VoidCallback onTap}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }


}
