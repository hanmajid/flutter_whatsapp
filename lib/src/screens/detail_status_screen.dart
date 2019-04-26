import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/src/models/chat.dart';
import 'package:flutter_whatsapp/src/services/chat_service.dart';
import 'package:flutter_whatsapp/src/values/colors.dart';
import 'package:flutter_whatsapp/src/widgets/message_item.dart';


class DetailStatusScreen extends StatefulWidget {
  final int id;

  DetailStatusScreen({
    this.id,
  });

  _DetailStatusScreenState createState() => _DetailStatusScreenState();
}

class _DetailStatusScreenState extends State<DetailStatusScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(
        child: Text(
          'Status ${widget.id}'
        ),
      )
    );
  }
}
