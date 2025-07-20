import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

import 'heart_disease_info.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Heart Disease Prediction',
      debugShowCheckedModeBanner: false, // Remove debug banner
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1565C0), // Updated blue color
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.white.withOpacity(0.95),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1565C0),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
          ),
        ),
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: const EdgeInsets.symmetric(vertical: 8),
        ),
      ),
      home: const LoginPage(),
    );
  }
}

// Login Page
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final String _validUsername = "admin";
  final String _validPassword = "admin";

  void _login() {
    if (_formKey.currentState!.validate()) {
      if (_usernameController.text == _validUsername &&
          _passwordController.text == _validPassword) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainAppPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid credentials')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade800,
              Colors.blue.shade600,
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.medical_services,
                          size: 80, color: Colors.blue),
                      const SizedBox(height: 24),
                      Text(
                        'HDSP Login',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 32),
                      TextFormField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          prefixIcon: Icon(Icons.person),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter username';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _login,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('LOGIN'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Main App Page with Navigation
class MainAppPage extends StatefulWidget {
  const MainAppPage({super.key});

  @override
  State<MainAppPage> createState() => _MainAppPageState();
}

class _MainAppPageState extends State<MainAppPage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const PredictionPage(),
    const InfoPage(),
    const HeartDiseaseInfoPage(),
    const AboutPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services),
            label: 'Prediction',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'How It Works',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Heart Disease',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'About',
          ),
        ],
        selectedItemColor: const Color(0xFF1565C0),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
    );
  }
}

// Info Page (How It Works)
class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('How It Works'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Heart Disease Prediction System',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'This application uses a machine learning model to predict the likelihood of heart disease based on 13 medical parameters.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Input Parameters Guide:',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Card(
                child: DataTable(
                  columnSpacing: 20,
                  columns: const [
                    DataColumn(label: SizedBox(width: 100, child: Text('Parameter'))),
                    DataColumn(label: SizedBox(width: 150, child: Text('Description'))),
                    DataColumn(label: SizedBox(width: 200, child: Text('Valid Values'))),
                  ],
                  rows: const [
                    DataRow(cells: [
                      DataCell(Text('Age')),
                      DataCell(Text('Patient age in years')),
                      DataCell(Text('Number (30-100)')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Sex')),
                      DataCell(Text('Biological sex')),
                      DataCell(Text('1 = Male, 0 = Female')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('CP')),
                      DataCell(Text('Chest pain type')),
                      DataCell(Text('0: Typical angina\n1: Atypical angina\n2: Non-anginal pain\n3: Asymptomatic')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('TRESTBPS')),
                      DataCell(Text('Resting blood pressure (mmHg)')),
                      DataCell(Text('Number (90-200)')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('CHOL')),
                      DataCell(Text('Serum cholesterol (mg/dL)')),
                      DataCell(Text('Number (120-600)')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('FBS')),
                      DataCell(Text('Fasting blood sugar >120 mg/dL')),
                      DataCell(Text('1 = True, 0 = False')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('RESTECG')),
                      DataCell(Text('Resting ECG results')),
                      DataCell(Text('0: Normal\n1: ST-T wave abnormality\n2: Left ventricular hypertrophy')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('THALACH')),
                      DataCell(Text('Max heart rate achieved')),
                      DataCell(Text('Number (70-210)')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('EXANG')),
                      DataCell(Text('Exercise induced angina')),
                      DataCell(Text('1 = Yes, 0 = No')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('OLDPEAK')),
                      DataCell(Text('ST depression induced by exercise')),
                      DataCell(Text('Number (0-6.2)')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('SLOPE')),
                      DataCell(Text('Slope of peak exercise ST segment')),
                      DataCell(Text('0: Upsloping\n1: Flat\n2: Downsloping')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('CA')),
                      DataCell(Text('Number of major vessels')),
                      DataCell(Text('0-3')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('THAL')),
                      DataCell(Text('Thalassemia')),
                      DataCell(Text('1: Normal\n2: Fixed defect\n3: Reversible defect')),
                    ]),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),
            Text(
              'Output Interpretation:',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '• Probability: Value between 0-1 showing prediction confidence',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '• Prediction:',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '  "Heart Disease Detected" (if ≥0.5)',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '  "No Heart Disease" (if <0.5)',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// Prediction Page
class PredictionPage extends StatefulWidget {
  const PredictionPage({super.key});

  @override
  State<PredictionPage> createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {
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

  String result = "Results will be shown here";
  late Interpreter interpreter;

  // Dropdown options
  final Map<String, double> sexOptions = {
    'Female': 0,
    'Male': 1,
  };

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

  final Map<String, double> exangOptions = {
    'No': 0,
    'Yes': 1,
  };

  final Map<String, double> slopeOptions = {
    'Upsloping': 0,
    'Flat': 1,
    'Downsloping': 2,
  };

  final Map<String, double> caOptions = {
    '0': 0,
    '1': 1,
    '2': 2,
    '3': 3,
  };

  final Map<String, double> thalOptions = {
    'Normal': 1,
    'Fixed defect': 2,
    'Reversible defect': 3,
  };

  @override
  void initState() {
    super.initState();
    loadModel();
    // Set default values
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

  performAction() {
    try {
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
        result = "Probability: ${probability.toStringAsFixed(3)}\n"
            "Prediction: ${probability >= 0.5 ? "Heart Disease Detected" : "No Heart Disease"}";
      });
    } catch (e) {
      setState(() {
        result = "Error: Please enter valid numbers for all fields";
      });
    }
  }

  Widget _buildDropdown(String label, String? value, Map<String, double> options, Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Heart Disease Prediction'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade50,
              Colors.white,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'Patient Data',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildInputField(ageController, "Age (years)"),
                      _buildDropdown("Sex", selectedSex, sexOptions, (value) {
                        setState(() {
                          selectedSex = value;
                        });
                      }),
                      _buildDropdown("Chest Pain Type", selectedCp, cpOptions, (value) {
                        setState(() {
                          selectedCp = value;
                        });
                      }),
                      _buildInputField(trestbpsController, "Resting Blood Pressure (mmHg)"),
                      _buildInputField(cholController, "Serum Cholesterol (mg/dl)"),
                      _buildDropdown("Fasting Blood Sugar >120mg/dl", selectedFbs, fbsOptions, (value) {
                        setState(() {
                          selectedFbs = value;
                        });
                      }),
                      _buildDropdown("Resting ECG Results", selectedRestecg, restecgOptions, (value) {
                        setState(() {
                          selectedRestecg = value;
                        });
                      }),
                      _buildInputField(thalachController, "Maximum Heart Rate Achieved"),
                      _buildDropdown("Exercise Induced Angina", selectedExang, exangOptions, (value) {
                        setState(() {
                          selectedExang = value;
                        });
                      }),
                      _buildInputField(oldpeakController, "ST Depression Induced by Exercise"),
                      _buildDropdown("Slope of Peak Exercise ST Segment", selectedSlope, slopeOptions, (value) {
                        setState(() {
                          selectedSlope = value;
                        });
                      }),
                      _buildDropdown("Number of Major Vessels", selectedCa, caOptions, (value) {
                        setState(() {
                          selectedCa = value;
                        });
                      }),
                      _buildDropdown("Thalassemia", selectedThal, thalOptions, (value) {
                        setState(() {
                          selectedThal = value;
                        });
                      }),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: performAction,
                  icon: const Icon(Icons.analytics),
                  label: const Text('PREDICT HEART DISEASE'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Card(
                elevation: 4,
                color: Colors.blue.shade50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    result,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: result.contains("Detected")
                          ? Colors.red
                          : result.contains("No Heart Disease")
                          ? Colors.green
                          : Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

// About Page
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About This App'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Card(
                elevation: 4,
                shape: const CircleBorder(),
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.blue.shade50,
                  child: const Icon(Icons.medical_services, size: 60, color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                'Heart Disease Prediction App',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Developer Information:',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('• Name: Sami Hotak'),
                    Text('• Organization: 7th semester Students'),
                    Text('• Contact: 0777724870'),
                    Text('• Version: 1.0.0'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Technical Details:',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Machine Learning Model: AI Powered Prediction System',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('• This app is build to help Doctors with better predictions. '),
                    Text('• Built with Python using TensorFlow/Keras'),
                    Text('• Pandas and Numpy used for Data Manupilation'),
                    Text('• Matplotlib and Seaborn used for Data Visualization'),
                    Text('• Scikit-learn used for Spliting data into Training-Test-Valid sets'),
                    Text('• Trained on the UCI Heart Disease dataset'),
                    Text('• Converted to TensorFlow Lite for mobile deployment'),
                    SizedBox(height: 16),
                    Text(
                      'Mobile App:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('• Developed with Flutter framework'),
                    Text('• Uses tflite_flutter package for model integration'),
                    Text('• Material Design 4 UI components'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Disclaimer:',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 10),
            Card(
              color: Colors.red.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'This app helps doctors predict heart disease with 87% accuracy, meaning a 13% chance of error.\n'
                      'Predictions are advisory—not definitive—and should not replace professional medical decisions.\n'
                      'Always consult a healthcare provider for diagnosis and treatment.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red.shade800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}