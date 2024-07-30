import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class HelpSupport extends StatefulWidget {
  const HelpSupport({super.key});

  @override
  _HelpSupportState createState() => _HelpSupportState();
}

class _HelpSupportState extends State<HelpSupport> {
  final List<types.Message> _messages = [];
  final types.User _user = const types.User(id: 'user_id', firstName: 'User');
  final types.User _bot = const types.User(id: 'bot_id', firstName: 'Bot');

  void _onSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: message.text,
    );

    setState(() {
      _messages.add(textMessage);
    });

    // Simulate bot response
    Future.delayed(const Duration(seconds: 1), () {
      final botMessage = types.TextMessage(
        author: _bot,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: 'This is a response from the support bot.',
      );

      setState(() {
        _messages.add(botMessage);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Help & Support')),
      body: Chat(
        messages: _messages,
        onSendPressed: _onSendPressed,
        user: _user,
      ),
    );
  }
}
