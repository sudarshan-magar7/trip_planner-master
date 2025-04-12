import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
// Add the http and http_parser imports:
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart'; // For MediaType
// ignore: unused_import
import 'dart:convert'; // For json decoding/encoding

class UploadVideoPage extends StatefulWidget {
  const UploadVideoPage({super.key});

  @override
  _UploadVideoPageState createState() => _UploadVideoPageState();
}

class _UploadVideoPageState extends State<UploadVideoPage> {
  XFile? _videoFile;
  final ImagePicker _picker = ImagePicker();
  String _tourType = 'India';
  // ignore: unused_field
  final int _budgetRange = 0;
  final TextEditingController _preparePlaceController = TextEditingController();
  final TextEditingController _daysController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();
  final TextEditingController _movieNameController = TextEditingController();
  final TextEditingController _adultsController = TextEditingController();
  final TextEditingController _childrenController = TextEditingController();

  Future<void> _pickVideo() async {
    try {
      final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
      setState(() {
        _videoFile = video;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to pick video: $e")),
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    setState(() {
      _dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate!);
    });
  }

  // Updated method to fix the "Unsupported operation: MultipartFile..." error
  Future<void> _submitForm() async {
    if (_mobileController.text.isEmpty ||
        _daysController.text.isEmpty ||
        _videoFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text("Please fill all required fields and select a video")),
      );
      return;
    }

    try {
      // Update this to your actual backend endpoint
      final uri = Uri.parse("http://localhost:3000/api/upload-video");
      final request = http.MultipartRequest("POST", uri);

      // 1. Read bytes from the selected XFile
      final fileBytes = await _videoFile!.readAsBytes();

      // 2. Create a MultipartFile from those bytes
      final multipartFile = http.MultipartFile.fromBytes(
        'video',
        fileBytes,
        filename: _videoFile!.name, // preserve original name if needed
        contentType: MediaType('video', 'mp4'),
      );
      request.files.add(multipartFile);

      // 3. Add form fields
      request.fields['userId'] = "4"; // Replace with real userId if needed
      request.fields['preparePlace'] = _preparePlaceController.text;
      // or pass user input
      request.fields['date'] = _dateController.text;
      request.fields['numberOfDays'] = _daysController.text;
      request.fields['mobileNumber'] = _mobileController.text;
      request.fields['budget'] = _budgetController.text;
      request.fields['tourType'] = _tourType;
      request.fields['movieName'] = _movieNameController.text;
      request.fields['adults'] = _adultsController.text;
      request.fields['children'] = _childrenController.text;

      // 4. Send the request
      final response = await request.send();

      // 5. Handle response
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Video uploaded successfully!")),
        );
      } else {
        final responseBody = await response.stream.bytesToString();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $responseBody")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to submit: $e")),
      );
    }
  }

  @override
  void dispose() {
    _daysController.dispose();
    _dateController.dispose();
    _mobileController.dispose();
    _budgetController.dispose();
    _movieNameController.dispose();
    _adultsController.dispose();
    _childrenController.dispose();
    _preparePlaceController.dispose(); // Add this
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Upload Video Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF6878E7),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildVideoCard(),
              const SizedBox(height: 16),
              _buildFormCard(context),
              const SizedBox(height: 20),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVideoCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: GestureDetector(
        onTap: _pickVideo,
        child: Container(
          height: 200,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFD1DEFE), Color(0xFF6878E7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: _videoFile == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.video_library, size: 50, color: Colors.white),
                    SizedBox(height: 8),
                    Text(
                      'Tap to select a video',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.check_circle,
                        size: 50, color: Colors.green),
                    const SizedBox(height: 8),
                    Text(
                      'Video selected: ${_videoFile!.name}',
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildFormCard(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextFieldWithIcon(Icons.location_on, 'Prepare Place', false,
                controller: _preparePlaceController),
            const SizedBox(height: 16),
            _buildDateField(context),
            const SizedBox(height: 16),
            _buildTextFieldWithIcon(Icons.access_time, 'Number of Days', true,
                controller: _daysController),
            const SizedBox(height: 16),
            _buildTextFieldWithIcon(Icons.phone, 'Mobile Number', true,
                controller: _mobileController),
            const SizedBox(height: 16),
            _buildTextFieldWithIcon(Icons.monetization_on, 'Budget', true,
                controller: _budgetController),
            const SizedBox(height: 16),
            _buildDropdown(
              'Tour Type',
              _tourType,
              ['India', 'Foreign'],
              (String? value) => setState(() => _tourType = value!),
            ),
            const SizedBox(height: 16),
            _buildTextFieldWithIcon(Icons.movie, 'Movie Name', false,
                controller: _movieNameController),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildTextFieldWithIcon(
                      Icons.people, 'No. of Adults', true,
                      controller: _adultsController),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildTextFieldWithIcon(
                      Icons.child_care, 'No. of Children', true,
                      controller: _childrenController),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateField(BuildContext context) {
    return TextFormField(
      controller: _dateController,
      readOnly: true,
      onTap: () => _selectDate(context),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.calendar_today, color: Colors.blueGrey),
        labelText: 'Date',
        labelStyle: const TextStyle(color: Colors.black),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Center(
      child: ElevatedButton(
        onPressed: _submitForm,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6878E7),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: const Text(
          'Submit',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildTextFieldWithIcon(
    IconData icon,
    String label,
    bool isNumber, {
    TextEditingController? controller,
    VoidCallback? onTap,
  }) {
    return TextField(
      controller: controller,
      readOnly: onTap != null,
      onTap: onTap,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.blueGrey),
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
    );
  }

  Widget _buildDropdown<T>(
    String label,
    T currentValue,
    List<T> items,
    void Function(T?) onChanged,
  ) {
    return DropdownButtonFormField<T>(
      value: currentValue,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      items: items
          .map((item) =>
              DropdownMenuItem(value: item, child: Text(item.toString())))
          .toList(),
      onChanged: onChanged,
    );
  }
}
