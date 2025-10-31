import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddFamilyGroupScreen extends StatefulWidget {
  const AddFamilyGroupScreen({super.key});

  @override
  State<AddFamilyGroupScreen> createState() => _AddFamilyGroupScreenState();
}

class _AddFamilyGroupScreenState extends State<AddFamilyGroupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        await FirebaseFirestore.instance.collection('family_groups').add({
          'name': _nameController.text,
          'createdAt': Timestamp.now(),
        });

        if (mounted) {
          Navigator.of(context).pop();
        }
      } catch (error) {
        // Stop loading and show error message
        setState(() {
          _isLoading = false;
        });

        String errorMessage = 'An unexpected error occurred.';
        if (error.toString().contains('PERMISSION_DENIED')) {
            errorMessage = 'Error: Firestore API is not enabled. Please enable it.';
        } else {
            errorMessage = 'Failed to create group. Please try again.';
        }

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMessage)),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Family Group'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Group Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  if (value.length > 50) {
                    return 'Name cannot exceed 50 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              if (_isLoading)
                const CircularProgressIndicator()
              else
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Create Group'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
