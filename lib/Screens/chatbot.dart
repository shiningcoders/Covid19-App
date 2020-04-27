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
     apikey: 'MXyvj5SCu9nZHPqPMSEq2ba-rlbOaFny5sKx5zRuW-RJ',
     assistantID: '000acf11-c916-4b56-bb3c-0643a5d45878',
     url: 'https://api.us-south.assistant.watson.cloud.ibm.com/instances/8d3d9eb3-9b0e-4c53-babf-35c68f1a23a7/v2/',
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
     backgroundColor: Color(0xFFf2f2fa),
         appBar: AppBar(
           elevation: 0,
           backgroundColor: Color(0xFFf2f2fa),
           title: Text('COVID-19 Chatbot'),
           centerTitle: true,
           actions: <Widget>[
      IconButton(
        icon: Icon(
          Icons.refresh,
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
           backgroundColor: Color(0xFFf2f2fa),
           body: Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
                   child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: myController,
              decoration: InputDecoration(
                hintText: 'Ask a question',
                
                hintStyle: TextStyle(color: Colors.black45),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color(0xFF5679db), width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color(0xFF5679db), width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              _text != null ? '$_text' : 'Communicating to server...',
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
           backgroundColor: Color(0xFF5679db),
         ),
       );
   }
 
   @override
   void dispose() {
     myController.dispose();
     super.dispose();
   }
 }