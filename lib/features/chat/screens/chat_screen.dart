import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<types.Message> _messages = [];
  final types.User _user = const types.User(id: 'user_id', firstName: 'User');
  final types.User _bot = const types.User(id: 'bot_id', firstName: 'Bot');
  final String _openAiApiKey = 'sk-proj-uDAI5YoX7PwQH2w2rrUHT3BlbkFJWotunco7kMFUX5AhmQbn'; // Use secure storage for sensitive data
  final CollectionReference _messagesCollection = FirebaseFirestore.instance.collection('messages');
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _loadMessages() async {
    final snapshot = await _messagesCollection.orderBy('createdAt', descending: true).get();
    final messages = snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      final author = data['author'] == 'user' ? _user : _bot;
      return types.TextMessage(
        author: author,
        createdAt: data['createdAt'],
        id: doc.id,
        text: data['text'],
      );
    }).toList();

    setState(() {
      _messages.addAll(messages.reversed); // Reversing to maintain chronological order
    });
  }

  void _onSendPressed(types.PartialText message) async {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: message.text,
    );

    setState(() {
      _messages.insert(0, textMessage); // Insert at the beginning for immediate display
      _isLoading = true;
    });

    await _messagesCollection.add({
      'author': 'user',
      'createdAt': textMessage.createdAt,
      'text': textMessage.text,
    });

    _getBotResponse(message.text);
  }

  Future<void> _getBotResponse(String userMessage) async {
    try {
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_openAiApiKey',
        },
        body: json.encode({
          'model': 'text-davinci-003',
          'prompt': 'You are an AI assistant knowledgeable about disaster management. Respond to this user query: $userMessage',
          'max_tokens': 150,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final botMessageText = data['choices'][0]['text'].trim();

        final botMessage = types.TextMessage(
          author: _bot,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: botMessageText,
        );

        setState(() {
          _messages.insert(0, botMessage); // Insert at the beginning for immediate display
          _isLoading = false;
        });

        await _messagesCollection.add({
          'author': 'bot',
          'createdAt': botMessage.createdAt,
          'text': botMessage.text,
        });
      } else {
        _handleError();
      }
    } catch (e) {
      _handleError();
    }
  }

  void _handleError() {
    final botMessage = types.TextMessage(
      author: _bot,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: 'Sorry, I could not get a response. Please try again later.',
    );

    setState(() {
      _messages.insert(0, botMessage); // Insert at the beginning for immediate display
      _isLoading = false;
    });

    _messagesCollection.add({
      'author': 'bot',
      'createdAt': botMessage.createdAt,
      'text': botMessage.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Disaster Managent Chatbot'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Stack(
        children: [
          Chat(
            messages: _messages,
            onSendPressed: _onSendPressed,
            user: _user,
            theme: DefaultChatTheme(
              primaryColor: Colors.blueAccent,
              secondaryColor: Colors.grey,
              inputBackgroundColor: Colors.blueGrey.shade100,
              inputTextColor: Colors.black,
              inputTextStyle: const TextStyle(color: Colors.black),
            ),
          ),
          if (_isLoading)
            const Positioned(
              bottom: 16,
              right: 16,
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
