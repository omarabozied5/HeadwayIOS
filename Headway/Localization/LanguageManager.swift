//
//  LanguageManager.swift
//  Headway
//
//  Created by omar abozeid on 01/02/2025.
//

import SwiftUI

class LanguageManager: ObservableObject {
    static let shared = LanguageManager()
    
    @AppStorage("currentLanguage") private var currentLanguage: String = "en"
    @Published var isRTL: Bool = false
    
    private init() {
        isRTL = currentLanguage == "ar"
    }
    
    var translations: [String: [String: String]] = [
        "en": [
            "profile": "Profile",
            "name": "Name",
            "email": "Email",
            "phone": "Phone Number",
            "logout": "Logout",
            "deleteAccount": "Delete Account",
            "save": "Save",
            "enterNewName": "Enter new name",
            "language": "Arabic"
        ],
        "ar": [
            "profile": "الملف الشخصي",
            "name": "الاسم",
            "email": "البريد الإلكتروني",
            "phone": "رقم الهاتف",
            "logout": "تسجيل خروج",
            "deleteAccount": "حذف الحساب",
            "save": "حفظ",
            "enterNewName": "أدخل الاسم الجديد",
            "language": "English"
        ]
    ]
    
    func localizedText(_ key: String) -> String {
        return translations[currentLanguage]?[key] ?? key
    }
    
    func toggleLanguage() {
        withAnimation {
            currentLanguage = currentLanguage == "en" ? "ar" : "en"
            isRTL = currentLanguage == "ar"
            
            // Force update the semantic content attribute
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                windowScene.windows.forEach { window in
                    window.semanticContentAttribute = isRTL ? .forceRightToLeft : .forceLeftToRight
                }
            }
        }
    }
    
    func getCurrentLanguage() -> String {
        return currentLanguage
    }
}
