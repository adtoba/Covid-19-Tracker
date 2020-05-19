import 'package:flutter/material.dart';

class FAQS {
  FAQS({
    @required this.question,
    @required this.answer
  });

  factory FAQS.fromJson(Map<String, dynamic> json) {
    return FAQS(
      answer: json['answer'],
      question: json['question']
    );
  }
  final String question;
  final String answer;
  
}