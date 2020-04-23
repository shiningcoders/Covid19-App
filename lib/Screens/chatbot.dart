import 'package:flutter/material.dart';
import 'package:watson_assistant_v2/watson_assistant_v2.dart';
 
class Chatbot extends StatefulWidget {
   Chatbot({Key key, this.title}) : super(key: key);
 
   final String title;
 
   @override
   _ChatbotState createState() => _ChatbotState();
 }
 
class _ChatbotState extends State<Chatbot> {
   String _text;
   WatsonAssistantV2Credential credential = WatsonAssistantV2Credential(
     version: '2019-02-28',
     username: 'apikey',
     apikey: 'J2A7w8j-x7cUbNSxtzxVJYTvTFYMDHLrtfseYMVQxGs4',
     assistantID: 'ac0aca86-4994-4e7d-9aaf-e38ed79a25a2',
     url: 'https://api.eu-gb.assistant.watson.cloud.ibm.com/instances/b78e1738-29ca-4c1b-b06d-9535c82730e6/v2',
   );
 
   WatsonAssistantApiV2 watsonAssistant;
   WatsonAssistantResponse watsonAssistantResponse;
   WatsonAssistantContext watsonAssistantContext =
       WatsonAssistantContext(context: {});
 
   final myController = TextEditingController();
 
   void _callWatsonAssistant() async {
     watsonAssistantResponse = await watsonAssistant.sendMessage(
         myController.text, watsonAssistantContext);
     setState(() {
       _text = watsonAssistantResponse.resultText;
     });
     watsonAssistantContext = watsonAssistantResponse.context;
     myController.clear();
   }
 
   @override
   void initState() {
     super.initState();
     watsonAssistant =
         WatsonAssistantApiV2(watsonAssistantCredential: credential);
     _callWatsonAssistant();
   }
 
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text('Watson_Assistant_V2'),
         centerTitle: true,
         actions: <Widget>[
           IconButton(
             icon: Icon(
               Icons.restore,
             ),
             onPressed: () {
               watsonAssistantContext.resetContext();
               setState(() {
                 _text = null;
               });
             },
           )
         ],
       ),
       body: Scaffold(
         backgroundColor: Colors.white,
         body: Padding(
           padding: EdgeInsets.symmetric(horizontal: 24.0),
           child: SingleChildScrollView(
                        child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.stretch,
               children: <Widget>[
                 TextField(
                   controller: myController,
                   decoration: InputDecoration(
                     hintText: 'Your Input to the chatbot',
                     contentPadding:
                         EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                     border: OutlineInputBorder(
                       borderRadius: BorderRadius.all(Radius.circular(32.0)),
                     ),
                     enabledBorder: OutlineInputBorder(
                       borderSide:
                           BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                       borderRadius: BorderRadius.all(Radius.circular(32.0)),
                     ),
                     focusedBorder: OutlineInputBorder(
                       borderSide:
                           BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                       borderRadius: BorderRadius.all(Radius.circular(32.0)),
                     ),
                   ),
                 ),
                 SizedBox(
                   height: 8.0,
                 ),
                 Text(
                   _text != null ? '$_text' : 'Watson Response Here',
                   style: TextStyle(fontSize: 16),
                 ),
                 SizedBox(
                   height: 24.0,
                 ),
               ],
             ),
           ),
         ),
       ),
       floatingActionButton: FloatingActionButton(
         onPressed: _callWatsonAssistant,
         child: Icon(Icons.send),
       ),
     );
   }
 
   @override
   void dispose() {
     myController.dispose();
     super.dispose();
   }
 }