
import 'package:cloud_firestore/cloud_firestore.dart';

class Family {
  final String name;
  final String imageUrl;

  Family({required this.name, required this.imageUrl});

  factory Family.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    String imageUrl = data['imageUrl'] ?? '';
    if (imageUrl.isEmpty) {
      imageUrl = 'https://via.placeholder.com/150';
    }
    return Family(
      name: data['name'] ?? '',
      imageUrl: imageUrl,
    );
  }
}
