import 'package:flutter/material.dart';

class Task {
  final String id = UniqueKey().toString();
  final String name;
  final DateTime createdTime;
  DateTime completedTime;
  bool isDone;

  Task({
    required this.name,
    required this.createdTime,
    required this.completedTime,
    this.isDone = false,
  });

  void toggleDone() {
    completedTime = DateTime.now();
    isDone = !isDone;
  }

  Task fromJSON(Map<String, Object> json) {
    return Task(
      name: json['name'] as String,
      createdTime: json['createdTime'] as DateTime,
      completedTime: json['completedTime'] as DateTime,
      isDone: json['isDone'] as bool,
    );
  }

  Map<String, Object> toJSON() {
    return {
      'id': id,
      'name': name,
      'createdTime': createdTime,
      'completedTime': completedTime,
      'isDone': isDone,
    };
  }
}
