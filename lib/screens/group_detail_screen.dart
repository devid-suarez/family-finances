import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;
import 'package:intl/intl.dart';
import 'package:family_finances/models/transaction.dart';
import 'package:family_finances/screens/add_transaction_screen.dart';

class GroupDetailScreen extends StatelessWidget {
  final String familyGroupId;
  final String groupName;

  const GroupDetailScreen({
    super.key,
    required this.familyGroupId,
    required this.groupName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(groupName),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('family_groups')
            .doc(familyGroupId)
            .collection('transactions')
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'No transactions yet. Add one to get started!',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          final transactions = snapshot.data!.docs
              .map((doc) => Transaction.fromFirestore(doc))
              .toList();

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final trans = transactions[index];
              final isIncome = trans.type == TransactionType.income;
              final currencyFormat = NumberFormat.currency(locale: 'en_US', symbol: '\$');

              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                child: ListTile(
                  leading: Icon(
                    isIncome ? Icons.arrow_downward : Icons.arrow_upward,
                    color: isIncome ? Colors.green : Colors.red,
                    size: 30,
                  ),
                  title: Text(
                    trans.description,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(DateFormat.yMMMd().format(trans.date.toDate())),
                  trailing: Text(
                    currencyFormat.format(trans.amount),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isIncome ? Colors.green : Colors.red,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  AddTransactionScreen(familyGroupId: familyGroupId),
            ),
          );
        },
        tooltip: 'Add Transaction',
        child: const Icon(Icons.add),
      ),
    );
  }
}
