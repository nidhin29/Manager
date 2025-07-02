# 💰 Manager - Personal Finance Management App

**Manager** is a comprehensive personal finance management app built with Flutter that helps users track income and expenses across multiple bank accounts. The app features automatic SMS transaction parsing, visual insights through charts, Google Sign-In authentication, and cloud synchronization powered by Firebase.

---

## ✨ Key Features

### 🔑 Authentication
- **Google Sign-In** integration for secure user authentication
- Firebase Authentication handles all user account management
- Seamless login/logout experience

### 🏦 Account Management
- Add and manage **multiple bank accounts**
- View **balance summaries** for each account
- Set up **budgets** for better financial planning
- Track account-specific transactions

### 💸 Smart Transaction Tracking
- **Automatic SMS parsing** to detect bank transactions
- Manual transaction entry for **Income** and **Expense**
- **Category-based** transaction classification
- Real-time balance updates

### 📊 Visual Insights & Analytics
- **Interactive charts** using FL Chart library
- **Income vs Expense** analysis
- **Monthly spending trends**
- **Category-wise breakdown** of expenses
- **Predictive analytics** for future expenses

### 🏷️ Category Management
- Create **custom categories** for transactions
- **Update** or **delete** existing categories
- Color-coded category system for better visualization
- Category-wise spending analysis

### 📱 SMS Integration
- **Automatic SMS monitoring** for bank transaction alerts
- **Real-time transaction parsing** from SMS messages
- Support for multiple bank SMS formats
- Background SMS listening capabilities

---

## 🏗️ Architecture & Tech Stack

### � Flutter Framework
- **Cross-platform** mobile app development
- **Material Design** UI components
- **State management** using BLoC pattern
- **Responsive design** with ScreenUtil

### 🧠 Clean Architecture Implementation

```plaintext
lib/
├── Application/          # Business Logic Layer (BLoCs & Cubits)
│   ├── Accounts/         # Account management logic
│   │   ├── Create/       # Account creation cubit
│   │   ├── Budget/       # Budget management cubit
│   │   └── Transaction/  # Transaction management
│   ├── Category/         # Category CRUD operations
│   │   └── Create/       # Category creation logic
│   └── SignIn/           # Authentication logic
│
├── Core/
│   └── Injectable/       # Dependency injection setup with GetIt
│
├── Domain/               # Business Models & Interfaces
│   ├── Accounts/         # Account models and repositories
│   │   ├── Budget/       # Budget-related models
│   │   └── Transaction/  # Transaction models
│   ├── SignIn/           # Authentication models
│   ├── User/             # User profile models
│   ├── Token Manager/    # Token management utilities
│   └── Failure/          # Error handling models
│
├── Infrastructure/       # Data Layer (Repository Implementations)
│   ├── Accounts/         # Firebase account data operations
│   ├── Category/         # Category data management
│   └── SignIn/           # Authentication with Firebase
│
├── Presentation/         # UI Layer
│   ├── Home/             # Dashboard with charts and insights
│   ├── Transaction/      # Transaction management screens
│   ├── Category/         # Category management UI
│   ├── Intro/            # Onboarding screens
│   ├── Splash/           # App initialization screen
│   └── constants/        # UI constants and themes
│
├── firebase_options.dart # Firebase configuration
└── main.dart            # App entry point
```

### 🔧 Key Technologies

**State Management:**
- **BLoC/Cubit** pattern for predictable state management
- **Flutter BLoC** library for reactive programming

**Backend & Cloud:**
- **Firebase Authentication** for secure user management
- **Cloud Firestore** for real-time data synchronization
- **Firebase Security Rules** for data protection

**Charts & Visualization:**
- **FL Chart** library for interactive and animated charts
- Custom chart implementations for financial data

**SMS Integration:**
- **Telephony** package for SMS permissions and monitoring
- Custom SMS parsing algorithms for transaction detection

**Dependency Injection:**
- **GetIt** for service locator pattern
- **Injectable** for code generation

**UI & Responsive Design:**
- **Flutter ScreenUtil** for responsive layouts
- **Google Fonts** integration
- **Material Design 3** components

---

## � Getting Started

### Prerequisites
- **Flutter SDK** (>= 3.5.3)
- **Dart SDK** (>= 3.5.3)
- **Android Studio** or **VS Code** with Flutter extensions
- **Firebase account** for backend services

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/nidhin29/MangerApp.git
   cd manager
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Setup**
   - Create a new Firebase project
   - Enable Authentication and Firestore
   - Download and configure `google-services.json` for Android
   - Update Firebase configuration in `firebase_options.dart`

4. **Permissions Setup (Android)**
   - SMS permissions are automatically requested
   - Ensure proper permissions in `AndroidManifest.xml`

5. **Run the app**
   ```bash
   flutter run
   ```

### 🔧 Configuration

**Required Permissions:**
- Internet access
- SMS read permissions
- Phone state permissions

---

## 📱 App Highlights

### Smart Features
- **Predictive Analytics**: expense prediction
- **Automatic Transaction Detection**: SMS-based transaction parsing
- **Budget Alerts**: Real-time budget limit notifications
- **Multi-Account Support**: Manage multiple bank accounts seamlessly

### User Experience
- **Intuitive Interface**: Clean, modern Material Design
- **Responsive Design**: Optimized for different screen sizes

---

## 🔐 Security & Privacy

- **End-to-End Encryption**: All data encrypted in transit
- **Firebase Security Rules**: Server-side data validation
- **Google Authentication**: Secure OAuth 2.0 implementation

---

## 📊 Data Models

**Core Entities:**
- **User**: Profile and authentication data
- **Account**: Bank account information and balances
- **Transaction**: Income/expense records with categories
- **Category**: Custom transaction classification
- **Budget**: Spending limits and financial goals

---

## � Download & Try

**Ready to test the app?**
👉 [Download APK from Google Drive](https://drive.google.com/drive/folders/1uTdAV-cj89CNWT-xPabvBfS2WHZ5uA1E?usp=drive_link)

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit issues, feature requests, or pull requests.

### Development Setup
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

---

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

## 👨‍💻 Developer

Developed with ❤️ by [Nidhin](https://github.com/nidhin29)

For questions or support, please open an issue on GitHub.

---

## 🔮 Future Roadmap

- **Export/Import**: CSV and PDF export functionality
- **Investment Tracking**: Portfolio management features
- **Bill Reminders**: Automated payment reminders
- **Advanced Analytics**: Machine learning insights
- **Multi-Currency Support**: International currency handling
- **Web Dashboard**: Browser-based financial overview
