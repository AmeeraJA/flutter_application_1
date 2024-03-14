// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

void main() => runApp(const MaterialApp(home: FoodItemPage()));

class FoodItemPage extends StatefulWidget {
  const FoodItemPage({super.key});

  @override
  _FoodItemPageState createState() => _FoodItemPageState();
}

class _FoodItemPageState extends State<FoodItemPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  String _expiryDate = "Select expiry date";
  bool _weightSelected = false;
  bool _quantitySelected = false;

  Future<void> _scanBarcode() async {
    try {
      // ignore: unused_local_variable
      final barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      if (!mounted) return;
      setState(() {
        // Handle the scanned barcode result
        // For demonstration, using it directly might not be ideal
        _nameController.text = "Scanned Item Name"; // Placeholder for actual result handling
      });
    } catch (e) {
      // Handle error
    }
  }

  // ignore: unused_element
  void _scanExpiryDate() async {
    try {
      // ignore: unused_local_variable
      final barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      if (!mounted) return;
      setState(() {
        // Handle the scanned expiry date result
        _expiryDate = "Scanned Date"; // Placeholder for actual result handling
      });
    } catch (e) {
      // Handle error
    }
  }

  void _pickExpiryDate() {
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime.now(),
        maxTime: DateTime(2030, 12, 31), onChanged: (date) {
      // This is called when the user selects a new date
    }, onConfirm: (date) {
      setState(() {
        _expiryDate = "${date.year}-${date.month}-${date.day}";
      });
    }, currentTime: DateTime.now(), locale: LocaleType.en);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Food Item'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigate to the shopping cart page
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset('assets/bread.png'), // Make sure the asset is added to your pubspec.yaml
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.camera_alt),
              label: const Text('Scan'),
              onPressed: _scanBarcode,
            ),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            CheckboxListTile(
              title: const Text("Weight"),
              value: _weightSelected,
              onChanged: (newValue) {
                setState(() {
                  _weightSelected = newValue!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            if (_weightSelected)
              TextField(
                controller: _weightController,
                decoration: const InputDecoration(labelText: 'Weight'),
              ),
            CheckboxListTile(
              title: const Text("Quantity"),
              value: _quantitySelected,
              onChanged: (newValue) {
                setState(() {
                  _quantitySelected = newValue!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            if (_quantitySelected)
              TextField(
                controller: _quantityController,
                decoration: const InputDecoration(labelText: 'Quantity'),
              ),
            ListTile(
              title: Text(_expiryDate),
              trailing: const Icon(Icons.calendar_today),
              onTap: _pickExpiryDate,
            ),
            ElevatedButton(
              onPressed: () {
                // Implement what happens when the item is added
              },
              child: const Text('Add Item'),
            ),
          ],
        ),
      ),
    );
  }
}

