import 'package:flutter/material.dart';
import 'package:translation_app/settingsScreen.dart';
import 'package:translation_app/TextTranslator.dart';
import 'package:translation_app/CameraTranslator.dart';
import 'package:translation_app/DocumentTranslator.dart';
import 'package:translation_app/AiTranslator.dart';
import 'package:translation_app/AiTranslator.dart';


 class HomePage extends StatefulWidget {
   const HomePage({super.key});

   @override
   State<HomePage> createState() => _HomePageState();
 }

 class _HomePageState extends State<HomePage> {
   @override
   Widget build(BuildContext context) {
     return Scaffold(
      

       body: Padding(
         padding: const EdgeInsets.all(20.0),
         child: Center(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Container(
                 padding: const EdgeInsets.all(16),
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(12),
                   boxShadow: [
                     BoxShadow(
                       color: Colors.black12,
                       blurRadius: 4,
                       offset: Offset(0, 2),
                     ),
                   ],
                 ),


                 child: Row(
                   children: [

                     Expanded(
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           const Text(
                             "Text Translator",
                             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                           ),
                           const SizedBox(height: 8),
                           const Text(
                             "Convert text between languages in seconds.",
                             style: TextStyle(color: Colors.black),
                           ),
                           const SizedBox(height: 12),
                           ElevatedButton(
                             style: ElevatedButton.styleFrom(
                               backgroundColor: Colors.indigo,
                             ),
                             onPressed: () {
                               Navigator.push(context, MaterialPageRoute(builder: (context)=>TextTranslator()
                               )
                               );
                             },
                             child: const Text("Translate ",
                             style: TextStyle(
                               color: Colors.white,
                               fontWeight: FontWeight.bold,
                             ),),
                           ),
                         ],
                       ),
                     ),

                     const SizedBox(width: 12),

                     // Right side: Image
                     ClipRRect(
                       borderRadius: BorderRadius.circular(8),
                       child: Image.network(
                         'https://i.pinimg.com/736x/78/6d/40/786d4067435d2c99785b2828bfe8f10d.jpg',
                         height: 80,
                         width: 80,
                         fit: BoxFit.cover,
                       ),
                     ),
                   ],
                 ),
               ),
               const SizedBox(height: 30),


               const SizedBox(height: 30),


               Row(
                 children: [
                   // Camera Translator
                   Expanded(
                     child: Container(
                       height: 150,
                       margin: const EdgeInsets.only(right: 10),
                       padding: const EdgeInsets.all(12),
                       decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.circular(12),
                         boxShadow: [
                           BoxShadow(
                             color: Colors.black12,
                             blurRadius: 4,
                             offset: Offset(0, 2),
                           ),
                         ],
                       ),
                       child: Row(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           // Left Column
                           Expanded(
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 ClipRRect(
                                   borderRadius: BorderRadius.circular(8),
                                   child: Image.network(
                                     'https://play-lh.googleusercontent.com/nFck8YdQLvii1wMMpdA6qrPguklATJtojwQ-sU4PCZCOFHo_YAu19hBRnkg6XehuDw=w240-h480-rw',
                                     height: 80,
                                     width: 80,
                                     fit: BoxFit.cover,
                                   ),
                                 ),
                                 const SizedBox(height: 10),
                                 const Text(
                                   'Camera\nTranslator',
                                   style: TextStyle(
                                     fontSize: 12,
                                     fontWeight: FontWeight.bold,
                                   ),
                                 ),
                               ],
                             ),
                           ),
                           // Right Column: Arrow
                           Expanded(
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.end,
                               children: [
                                 const Spacer(),
                                 IconButton(


                                   icon: const Icon(Icons.arrow_forward_ios,),
                                   onPressed: () {
                                     Navigator.push(context, MaterialPageRoute(builder: (context)=>CameraTranslator()));

                                   },
                                 ),
                               ],
                             ),
                           ),
                         ],
                       ),
                     ),
                   ),

                   // Document Translator
                   Expanded(
                     child: Container(
                       height: 150,
                       margin: const EdgeInsets.only(left: 10),
                       padding: const EdgeInsets.all(12),
                       decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.circular(12),
                         boxShadow: [
                           BoxShadow(
                             color: Colors.black12,
                             blurRadius: 4,
                             offset: Offset(0, 2),
                           ),
                         ],
                       ),
                       child: Row(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           // Left Column
                           Expanded(
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 ClipRRect(
                                   borderRadius: BorderRadius.circular(8),
                                   child: Image.network(
                                     'https://play-lh.googleusercontent.com/WQgTpK52CwzXuCNIzV_ClbtJVQlah61WbCwzrZNTlJSBp2wEqRahkx1p-S63OmNkGpc=w240-h480-rw',
                                     height: 80,
                                     width: 80,
                                     fit: BoxFit.cover,
                                   ),
                                 ),
                                 const SizedBox(height: 10),
                                 const Text(
                                   'Document\nTranslator',
                                   style: TextStyle(
                                     fontSize: 12,
                                     fontWeight: FontWeight.bold,
                                   ),
                                 ),
                               ],
                             ),
                           ),
                           // Right Column: Arrow
                           Expanded(
                             child: Column(

                               children: [
                                 const Spacer(),


                                 IconButton(
                                   icon: const Icon(Icons.arrow_forward_ios),
                                   onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>Documenttranslator()));},
                                 ),
                               ],
                             ),
                           ),
                         ],
                       ),
                     ),
                   ),
                 ],
               ),

               const SizedBox(height: 20),

               Text('AI Chat',
               style: TextStyle(
                 fontSize: 16,
                 fontWeight: FontWeight.bold,
               ),),


               const SizedBox(height: 10),

         InkWell(
           borderRadius: BorderRadius.circular(20),
           onTap: () {
             Navigator.push(
               context,
               MaterialPageRoute(builder: (context) => DeepSeekChatScreen()),
             );
           },
           child: Container(
             decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.circular(20),
               boxShadow: [
                 BoxShadow(
                   color: Colors.black12,
                   blurRadius: 4,
                   offset: Offset(0, 2),
                 ),
               ],
             ),
             child: Row(
               children: [
                 ClipRRect(
                   borderRadius: const BorderRadius.only(
                     topLeft: Radius.circular(20),
                     bottomLeft: Radius.circular(20),
                   ),
                   child: Image.network(
                     "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSI_A5Wpa9ff7Ote5arkGDkrPs6PYo2HQigTQ&s",
                     height: 60,
                     width: 60,
                     fit: BoxFit.cover,
                   ),
                 ),
                 const SizedBox(width: 10),
                 const Text(
                   'Ask me anything',
                   style: TextStyle(
                     fontWeight: FontWeight.bold,
                     fontSize: 12,
                     color: Colors.black,
                   ),
                 ),
               ],
             ),
           ),
         ),















         ],
               ),






           ),
         ),
       );

   }
 }
