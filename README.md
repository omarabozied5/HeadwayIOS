# Headway iOS App

A SwiftUI-based iOS application for displaying and managing GIFs using the Tenor API.

## Project Structure
```
Headway/
├── Screens/
│   ├── LoginScreen.swift
│   ├── HomeView.swift
│   ├── DetailScreen.swift
│   └── ProfileScreen.swift
│   └── RegistrationScreen.swift
│
├── NetworkLayer/
│   ├── Network/
│   │   ├── APIConstants.swift      # API keys and base URLs
│   │   ├── APIRouter.swift         # API endpoint definitions
│   │   ├── NetworkManager.swift    # Network request handling
│   │   └── NetworkRequest.swift    # Request protocols
│   │
│   └── Models/
│       ├── HomeViewModel.swift     # Home screen business logic
│       ├── GifResponseModels.swift # API response models
│       └── CacheGIFModel.swift    # Caching implementation
│
├── Localization/
│   └── LanguageManager.swift      # Multi-language support
│
└── Views/
    ├── Badges/
    └── Hikes/
```

## Features
- User authentication
- GIF browsing and search
- Offline caching
- Multi-language support (English/Arabic)
- Profile management

## Requirements
- iOS 18.0+
- Xcode 16.0+
- Swift 5.5+

## Installation
1. Clone the repository:
```bash
git clone https://github.com/yourusername/headway.git
```

2. Open `Headway.xcodeproj` in Xcode

3. Add your API keys in `APIConstants.swift`:
```swift
static let apiKey = "YOUR_API_KEY"
static let clientKey = "YOUR_CLIENT_KEY"
```

4. Build and run the project

## Configuration
The app uses the following APIs:
- Tenor API for GIF content
- Google Sign-In for authentication

## Dependencies
- SDWebImageSwiftUI for GIF loading
- [List any other dependencies]

## Architecture
- SwiftUI for UI
- MVVM architecture
- Async/await for networking
- UserDefaults for local storage

## Contributing
1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License
[Your chosen license]

## Contact
Omar AbuZaid 
Project Link: [(https://github.com/omarabozied5/HeadwayIOS.git)]
