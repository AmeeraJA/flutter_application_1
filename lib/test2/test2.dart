import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_application_1/models/food_category.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class FoodItemPage extends StatefulWidget {
  final FoodCategory foodCat;
  const FoodItemPage({
    super.key,
    required this.foodCat,
  });

  @override
  State<FoodItemPage> createState() => _FoodItemPageState();
}

class _FoodItemPageState extends State<FoodItemPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  String _expiryDate = "Expiry date";
  bool _weightSelected = false;
  bool _quantitySelected = false;

  Future<void> _scanBarcode() async {
    try {
      final barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666",
        "Cancel",
        true,
        ScanMode.BARCODE,
      );
      if (!mounted) return;
      setState(() {
        _nameController.text = "Scanned Item Name";
      });
    } catch (e) {
      // Handle error
    }
  }

  Future<void> _pickExpiryDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Initial date set to today
      firstDate: DateTime(2018, 01, 01), // Earliest possible date
      lastDate: DateTime(2030, 12, 31), // Latest possible date
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        // Update _expiryDate with the format you prefer
        // Here, it's formatted as YYYY-MM-DD
        _expiryDate =
            "${picked.year.toString()}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  Future<void> _scanExpiryDate() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image == null) return;

    final inputImage = InputImage.fromFilePath(image.path);
    final textRecognizer = GoogleMlKit.vision.textRecognizer();

    try {
      final RecognizedText recognizedText =
          await textRecognizer.processImage(inputImage);
      String expiryDateText = ""; // Placeholder for extracted expiry date text

      // Example logic to find a date in the recognized text
      // You'll need to adjust this based on the format of your dates
      for (TextBlock block in recognizedText.blocks) {
        final String text = block.text;
        // Simple check for a date pattern (e.g., YYYY-MM-DD)
        // This is a very basic check, consider using more robust date parsing
        if (RegExp(r'\d{4}-\d{2}-\d{2}').hasMatch(text)) {
          expiryDateText = text;
          break; // Stop looking once a date is found
        }
      }

      // Update the UI with the found date
      if (expiryDateText.isNotEmpty) {
        setState(() {
          _expiryDate = expiryDateText;
        });
      }
    } finally {
      textRecognizer.close(); // Don't forget to close the recognizer when done
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Transform.translate(
          offset: const Offset(0, 8),
          child: const Text(
            'Add Food item',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.deepPurple,
                fontSize: 22.0), //Black (thickest text)
          ),
        ),
        actions: [
          IconButton(
            icon: Transform.translate(
              offset: const Offset(0, 7),
              child: Image.asset('assets/cart.png', width: 44, height: 44),
            ),
            onPressed: () {
              // Placeholder for future navigation action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment
              .start, // Aligns children along the main axis (top to bottom in a column)
          crossAxisAlignment:
              CrossAxisAlignment.center, // Centers children horizontally.
          children: <Widget>[
            Text(
              widget.foodCat.categoryName,
              style: const TextStyle(
                fontSize: 33.0, // Adjust the text size as needed
                fontWeight: FontWeight
                    .w900, // Adjust the text weight/thickness as needed
                color: Colors.black, // This sets the color of the text
              ),
            ),

            SizedBox(
              width: 250, // Adjust the width as needed
              height: 250, // Adjust the height as needed
              child: Center(
                // Center the image within the SizedBox
                child: Image.asset(
                  widget.foodCat
                      .categoryImage, // Make sure the asset is added to your pubspec.yaml
                  fit: BoxFit
                      .contain, // This will maintain the aspect ratio of the image
                ),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              icon: Icon(
                MdiIcons.barcodeScan,
                color: Colors.white,
              ),
              label: const Text(
                'Scan Barcode',
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
              onPressed: _scanBarcode,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.deepPurple, // Use backgroundColor instead of primary
                foregroundColor:
                    Colors.white, // Use foregroundColor instead of onPrimary
                fixedSize: const Size(280, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: const TextStyle(
                  fontSize: 18.0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  borderSide: const BorderSide(color: Colors.deepPurple),
                ),
              ),
            ),

            Row(
              children: <Widget>[
                Expanded(
                  child: CheckboxListTile(
                    title: const Text(
                      "Weight",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    value: _weightSelected,
                    onChanged: (bool? newValue) {
                      setState(() {
                        _weightSelected = newValue ?? false;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
                Expanded(
                  child: CheckboxListTile(
                    title: const Text(
                      "Quantity",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    value: _quantitySelected,
                    onChanged: (bool? newValue) {
                      setState(() {
                        _quantitySelected = newValue ?? false;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
              ],
            ),
            if (_weightSelected || _quantitySelected)
              Row(
                children: [
                  if (_weightSelected)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: TextField(
                          controller: _weightController,
                          decoration: InputDecoration(
                            labelText: 'specify g/Kg',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                        ),
                      ),
                    ),
                  if (_quantitySelected)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: TextField(
                          controller: _quantityController,
                          decoration: InputDecoration(
                            labelText: 'specify units',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                ],
              ),

            const SizedBox(height: 20),

            // Text Field for displaying and selecting the expiry date
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap:
                        _pickExpiryDate, // Open the date picker when the field is tapped
                    child: IgnorePointer(
                      // Prevents the keyboard from showing
                      child: TextField(
                        controller: TextEditingController(
                            text:
                                _expiryDate), // Display the selected expiry date
                        decoration: InputDecoration(
                          labelText: 'Expiry Date',
                          hintText:
                              'Tap to select date', // Provides a hint to the user
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.calendar_today),
                            onPressed: _pickExpiryDate,
                          ),
                        ),
                        readOnly: true,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.camera_alt),
                  onPressed: _scanExpiryDate,
                  color: Colors.deepPurple,
                ),
              ],
            ),

            const SizedBox(height: 20),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Implement what happens when the item is added
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 166, 129, 230),
                  foregroundColor: Colors.white,
                  fixedSize: const Size(200, 25),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Text(
                  'Confirm Item',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
