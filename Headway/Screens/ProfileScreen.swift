//
//  ProfileScreen.swift
//  Headway
//
//  Created by omar abozeid on 22/01/2025.

import SwiftUI

struct ProfileScreen: View {
    private func getOppositeLanguage() -> String {
        return languageManager.isRTL ? "English" : "العربية"
    }
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var languageManager: LanguageManager
    
    @State private var isEditingName = false
    @State private var newName: String = ""
    
    @AppStorage("name") private var username: String = "User Name"
    @AppStorage("email") private var userEmail: String = "user.name@example.com"
    @AppStorage("phone") private var userPhoneNumber: String = "123-456-7890"
    
    @State private var navigateToLogin = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                // Profile Header Section
                VStack(spacing: 8) {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.blue)
                        .background(
                            Circle()
                                .fill(Color.blue.opacity(0.1))
                                .frame(width: 90, height: 90)
                        )
                        .padding(.top, 8)
                    
                    // Language Toggle Button
                    Menu {
                        Button(action: { languageManager.toggleLanguage() }) {
                            HStack {
                                Text(getOppositeLanguage())
                                Image(systemName: "checkmark")
                            }
                        }
                    } label: {
                        HStack(spacing: 6) {
                            Image(systemName: "globe")
                                .foregroundColor(.blue)
                            Text(languageManager.localizedText("language"))
                                .foregroundColor(.primary)
                            Image(systemName: "chevron.up.chevron.down")
                                .font(.caption)
                                .foregroundColor(.blue)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.blue.opacity(0.1))
                        )
                    }
                }
                
                // Profile Info Section
                VStack(spacing: 16) {
                    // Editable Name Field
                    VStack(alignment: .leading, spacing: 6) {
                        Text(languageManager.localizedText("name"))
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        if isEditingName {
                            HStack {
                                TextField(languageManager.localizedText("enterNewName"), text: $newName)
                                    .textFieldStyle(                     RoundedBorderTextFieldStyle())
                                    .overlay(RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.white.opacity(0.5))
                                        .allowsHitTesting(false))
                                
                                Button(action: saveName) {
                                    Text(languageManager.localizedText("save"))
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 8)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                            }
                        } else {
                            HStack {
                                Text(username)
                                Spacer()
                                Image(systemName: "pencil")
                                    .foregroundColor(.blue)
                            }
                            .padding(12)
                            .background(Color.white)
                            .cornerRadius(8)
                            .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
                            .onTapGesture {
                                isEditingName = true
                                newName = username
                            }
                        }
                    }
                    
                    // Email and Phone
                    ProfileRow(
                        icon: "envelope.fill",
                        label: languageManager.localizedText("email"),
                        value: userEmail,
                        isDisabled: true
                    )
                    
                    ProfileRow(
                        icon: "phone.fill",
                        label: languageManager.localizedText("phone"),
                        value: userPhoneNumber,
                        isDisabled: true
                    )
                }
                .padding(16)
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                
                Spacer()
                
                // Action Buttons
                VStack(spacing: 12) {
                    Button(action: { navigateToLogin = true }) {
                        HStack {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                            Text(languageManager.localizedText("logout"))
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    
                    Button(action: deleteAccount) {
                        HStack {
                            Image(systemName: "trash")
                            Text(languageManager.localizedText("deleteAccount"))
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color.red.opacity(0.1))
                        .foregroundColor(.red)
                        .cornerRadius(10)
                    }
                }
                
                NavigationLink(destination: LoginScreen(), isActive: $navigateToLogin) {
                    EmptyView()
                }
                .hidden()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Color(UIColor.systemGroupedBackground))
            .navigationTitle(languageManager.localizedText("profile"))
        }
        .environment(\.layoutDirection, languageManager.isRTL ? .rightToLeft : .leftToRight)
    }
    
    private func saveName() {
        UserDefaults.standard.set(newName, forKey: "name")
        username = newName
        isEditingName = false
    }
    
    private func deleteAccount() {
        UserDefaults.standard.removeObject(forKey: "name")
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "phone")
        UserDefaults.standard.removeObject(forKey: "password")
        navigateToLogin = true
    }
}

struct ProfileRow: View {
    let icon: String
    let label: String
    let value: String
    var isDisabled: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.blue)
                    .frame(width: 20)
                Text(value)
                    .foregroundColor(isDisabled ? .gray : .black)
            }
            .padding(12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.gray.opacity(0.05))
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.1), lineWidth: 1)
            )
        }
    }
}
