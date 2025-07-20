# Heart Disease Prediction Mobile App



A deep learning-powered mobile application for predicting heart disease risk with over 85% accuracy. Built with TensorFlow Lite and Flutter using the UCI Heart Disease Dataset.

## Features
- 🎯 **>85% Accurate Predictions** - Deep learning model trained on clinical data
- 📱 **User-Friendly UI** - Intuitive input forms and clear results display
- ⚡ **Real-Time Analysis** - Instant risk assessment on mobile devices
- 📊 **Visual Explanations** - Charts showing contributing risk factors
- 🌐 **Cross-Platform** - Works on both Android and iOS

## Technical Stack
### Data Processing & Modeling
- ![Pandas](https://img.shields.io/badge/pandas-%23150458.svg?style=flat&logo=pandas&logoColor=white) Data cleaning and feature engineering
- ![NumPy](https://img.shields.io/badge/numpy-%23013243.svg?style=flat&logo=numpy&logoColor=white) Numerical operations
- ![Matplotlib](https://img.shields.io/badge/Matplotlib-%23ffffff.svg?style=flat&logo=Matplotlib&logoColor=black) ![Seaborn](https://img.shields.io/badge/seaborn-0.11.2-blue) Data visualization
- ![TensorFlow](https://img.shields.io/badge/TensorFlow-%23FF6F00.svg?style=flat&logo=TensorFlow&logoColor=white) Model development
- ![TFLite](https://img.shields.io/badge/TFLite-%23FF6F00.svg?style=flat&logo=TensorFlow&logoColor=white) Mobile optimization

### Mobile Application
- ![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=flat&logo=Flutter&logoColor=white) Cross-platform UI

## Model Performance
| Metric          | Value   |
|-----------------|---------|
| **Accuracy**    | 86.7%   |
| Precision       | 85.2%   |
| Recall          | 87.9%   |
| AUC-ROC         | 0.92    |


## Input Parameters
The app collects 13 clinical features including:
- Age
- Resting blood pressure
- Serum cholesterol
- Maximum heart rate
- Exercise-induced angina
- ST depression
- Major vessel count
- ...

📱 App Pages
The mobile app includes several screens to guide users and improve the user experience:

🔍 How It Works
This page explains how the heart disease prediction system functions:

The user provides clinical inputs such as age, cholesterol, blood pressure, heart rate, etc.

These inputs are passed to a trained deep learning model.

The model then analyzes the data and predicts the likelihood of heart disease.

It also gives clear instructions on what kind of information the user needs to enter for accurate results.

🧪 Predictions
In this section, users input their personal health data into the form fields.

Once submitted, the app runs the data through the TensorFlow Lite model.

The result is displayed instantly, indicating either a low risk or high risk of heart disease.

Visual indicators or messages are used to make the output easy to understand.

❤️ About Heart Disease
This educational section covers:

What heart disease is

Common symptoms and causes

Preventive tips

The importance of regular check-ups

It aims to raise awareness and encourage healthy lifestyle choices.

ℹ️ About This App
This screen provides details about:

The purpose of the application

The dataset used (UCI Heart Disease Dataset)

Technologies involved (TensorFlow Lite, Flutter, Python, etc.)

Developer credits and contact (if applicable)

## Getting Started
### Prerequisites
- Flutter SDK ≥ 3.0
- Python 3.8+
- TensorFlow 2.10+

### Installation
1. Clone repository:
```bash
git clone https://github.com/yourusername/heart-disease-prediction-app.git


