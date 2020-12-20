import 'package:flutter/material.dart';

class FloatingButtonModel {
  List<FloatingButton> floatingButton;

  FloatingButtonModel({this.floatingButton});

  FloatingButtonModel.fromJson(Map<String, dynamic> json) {
    if (json['floatingButton'] != null) {
      floatingButton = new List<FloatingButton>();
      json['floatingButton'].forEach((v) {
        floatingButton.add(new FloatingButton.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.floatingButton != null) {
      data['floatingButton'] =
          this.floatingButton.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FloatingButton {
  String label;
  IconData icon;

  FloatingButton({this.label, this.icon});

  FloatingButton.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['icon'] = this.icon;
    return data;
  }
}
