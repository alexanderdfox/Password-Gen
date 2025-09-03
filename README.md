# SwiftyFox Password Generator & Encryption Tool

A professional, secure password generator and encryption tool built with SwiftUI for iOS, macOS, and watchOS.

## 🔐 Features

### Password Generator
- **Cryptographically Secure**: Uses `SecRandomCopyBytes()` for truly random password generation
- **Customizable Length**: Generate passwords from 1 to 100 characters
- **Multiple Character Types**:
  - Vowels (a, e, i, o, u, y)
  - Consonants (b, c, d, f, g, h, j, k, l, m, n, p, q, r, s, t, v, w, x, y, z)
  - Numbers (0-9)
  - Special Characters (!#$&*-_.)
  - Uppercase Letters
  - Lowercase Letters
  - Emojis (wide variety of emoji characters)
  - Custom Characters (user-defined)
- **One-Click Copy**: Automatically copies generated passwords to clipboard
- **Professional UI**: Modern, intuitive interface with clear visual feedback

### Encryption Tool
- **Military-Grade Security**: Uses ChaCha20-Poly1305 encryption
- **Emoji Encoding**: Optional emoji-based encoding for visual appeal
- **Secure Key Generation**: Automatically generates cryptographically secure keys
- **Easy Decryption**: Simple decryption with generated keys
- **Input Validation**: Comprehensive validation prevents errors

## 🛡️ Security Features

- **Cryptographically Secure Random Generation**: Replaced deprecated `arc4random()` with `SecRandomCopyBytes()`
- **Input Validation**: Comprehensive validation for all user inputs
- **Error Handling**: Graceful error handling with user-friendly messages
- **Network Security**: App Transport Security (ATS) enforcement
- **Memory Safety**: Eliminated force unwrapping and potential memory issues
- **Code Sanitization**: User input sanitization to prevent injection attacks

## 📱 Platform Support

- **iOS**: Full support with optimized touch interface
- **macOS**: Native desktop experience with professional window management
- **watchOS**: Compact interface for quick password generation

## 🎨 Professional Design

- **Modern UI**: Clean, professional interface following Apple's design guidelines
- **Responsive Layout**: Adapts to different screen sizes and orientations
- **Accessibility**: Supports VoiceOver and other accessibility features
- **Dark Mode**: Automatic dark mode support
- **Professional Icons**: SF Symbols integration for consistent iconography

## 🔧 Technical Details

### Security Implementation
- **Random Number Generation**: `SecRandomCopyBytes()` with CryptoKit fallback
- **Encryption**: ChaCha20-Poly1305 via CryptoKit
- **Input Validation**: Comprehensive bounds checking and sanitization
- **Error Handling**: Proper error handling without information disclosure

### Architecture
- **SwiftUI**: Modern declarative UI framework
- **CryptoKit**: Apple's cryptographic framework
- **Security Framework**: System-level security services
- **Cross-Platform**: Single codebase for all Apple platforms

## 📋 Requirements

- iOS 14.0+ / macOS 11.0+ / watchOS 7.0+
- Xcode 12.0+
- Swift 5.3+

## 🚀 Installation

1. Clone the repository
2. Open `SwiftyFoxPassword.xcodeproj` in Xcode
3. Select your target platform (iOS, macOS, or watchOS)
4. Build and run the project

## 🔒 Privacy & Security

- **No Data Collection**: The app does not collect or transmit any user data
- **Local Processing**: All encryption/decryption happens locally on device
- **No Network Access**: App operates entirely offline (except for optional external link)
- **Secure Storage**: No passwords or keys are stored persistently

## 📄 License

Copyright © 2021 Alexander Fox. All rights reserved.

## 🤝 Contributing

This is a personal project, but suggestions and feedback are welcome. Please ensure any contributions maintain the security standards and professional quality of the application.

## 📞 Support

For questions or support, please refer to the security documentation in `SECURITY_FIXES.md` for detailed information about the security implementation.

---

**Built with ❤️ and 🔐 for secure password generation and encryption**
