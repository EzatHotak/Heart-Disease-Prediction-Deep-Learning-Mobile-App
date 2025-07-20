import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PredictionChart extends StatefulWidget {
  const PredictionChart({super.key});

  @override
  State<PredictionChart> createState() => _PredictionChartState();
}

class _PredictionChartState extends State<PredictionChart> {
  final TextEditingController ageController = TextEditingController();
  final TextEditingController trestbpsController = TextEditingController();
  final TextEditingController cholController = TextEditingController();
  final TextEditingController thalachController = TextEditingController();
  final TextEditingController oldpeakController = TextEditingController();

  // Dropdown values
  String? selectedSex;
  String? selectedCp;
  String? selectedFbs;
  String? selectedRestecg;
  String? selectedExang;
  String? selectedSlope;
  String? selectedCa;
  String? selectedThal;

  // Visualization variables
  double _probability = 0.0;
  bool _showResults = false;
  bool _isLoading = false;
  late Interpreter interpreter;

  // Dropdown options
  final Map<String, double> sexOptions = {'Female': 0, 'Male': 1};
  final Map<String, double> cpOptions = {
    'Typical angina': 0,
    'Atypical angina': 1,
    'Non-anginal pain': 2,
    'Asymptomatic': 3,
  };
  final Map<String, double> fbsOptions = {
    'False (<120 mg/dL)': 0,
    'True (>120 mg/dL)': 1,
  };
  final Map<String, double> restecgOptions = {
    'Normal': 0,
    'ST-T wave abnormality': 1,
    'Left ventricular hypertrophy': 2,
  };
  final Map<String, double> exangOptions = {'No': 0, 'Yes': 1};
  final Map<String, double> slopeOptions = {
    'Upsloping': 0,
    'Flat': 1,
    'Downsloping': 2,
  };
  final Map<String, double> caOptions = {'0': 0, '1': 1, '2': 2, '3': 3};
  final Map<String, double> thalOptions = {
    'Normal': 1,
    'Fixed defect': 2,
    'Reversible defect': 3,
  };

  @override
  void initState() {
    super.initState();
    loadModel();
    selectedSex = sexOptions.keys.first;
    selectedCp = cpOptions.keys.first;
    selectedFbs = fbsOptions.keys.first;
    selectedRestecg = restecgOptions.keys.first;
    selectedExang = exangOptions.keys.first;
    selectedSlope = slopeOptions.keys.first;
    selectedCa = caOptions.keys.first;
    selectedThal = thalOptions.keys.first;
  }

  loadModel() async {
    interpreter = await Interpreter.fromAsset('assets/heart_disease_pred.tflite');
  }

  performAction() async {
    try {
      setState(() {
        _isLoading = true;
        _showResults = false;
      });

      await Future.delayed(const Duration(milliseconds: 500));

      var input = [
        double.parse(ageController.text),
        sexOptions[selectedSex]!,
        cpOptions[selectedCp]!,
        double.parse(trestbpsController.text),
        double.parse(cholController.text),
        fbsOptions[selectedFbs]!,
        restecgOptions[selectedRestecg]!,
        double.parse(thalachController.text),
        exangOptions[selectedExang]!,
        double.parse(oldpeakController.text),
        slopeOptions[selectedSlope]!,
        caOptions[selectedCa]!,
        thalOptions[selectedThal]!,
      ];

      var output = List.filled(1 * 1, 0.0).reshape([1, 1]);
      interpreter.run([input], output);
      double probability = output[0][0];

      setState(() {
        _probability = probability;
        _showResults = true;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter valid numbers for all fields')),
        );
      });
    }
  }

  Widget _buildDropdown(String label, String? value, Map<String, double> options, Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, color: Colors.black54)),
          const SizedBox(height: 4),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade400),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              underline: const SizedBox(),
              items: options.keys.map((String key) {
                return DropdownMenuItem<String>(
                  value: key,
                  child: Text(key),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Colors.white,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue.shade50, Colors.white],
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text('Patient Data',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(height: 16),
                    _buildInputField(ageController, "Age (years)"),
                    _buildDropdown("Sex", selectedSex, sexOptions, (value) {
                      setState(() => selectedSex = value);
                    }),
                    // Add all other input fields and dropdowns similarly
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Prediction button and results visualization
            // ... (same as previous implementation)
          ],
        ),
      ),
    );
  }
}

class ChartData {
  final String x;
  final double y;
  final Color color;

  ChartData(this.x, this.y, this.color);
}