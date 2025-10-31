
import 'package:family_finances/models/family_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FamilyList extends StatelessWidget {
  const FamilyList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('families').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No hay familias para mostrar.'));
        }

        final families = snapshot.data!.docs.map((doc) => Family.fromFirestore(doc)).toList();

        return Expanded(
          child: ListView.builder(
            itemCount: families.length,
            itemBuilder: (context, index) {
              final family = families[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(family.imageUrl),
                    radius: 30,
                  ),
                  title: Text(family.name, style: Theme.of(context).textTheme.titleLarge),
                  onTap: () {
                    // Navegar a la pantalla de detalles de la familia
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
