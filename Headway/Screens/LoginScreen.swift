//
//  LoginScreen.swift
//  Headway
//
//  Created by omar abozeid on 20/01/2025.
//
import SwiftUI

struct LoginScreen: View {
    @State private var email = ""
    @State private var password = ""
    @State private var emailError = ""
    @State private var passwordError = ""
    @State private var isFormValid = false
    @State private var showHomeScreen = false // Navigation state

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Login")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
                
                // Email Input
                VStack(alignment: .leading, spacing: 5) {
                    Text("Email")
                        .font(.headline)
                        .foregroundColor(.gray)
                    
                    TextField("Enter your email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .onChange(of: email) { _ in validateForm() }

                    if !emailError.isEmpty {
                        Text(emailError)
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }
                .padding(.horizontal)

                // Password Input
                VStack(alignment: .leading, spacing: 5) {
                    Text("Password")
                        .font(.headline)
                        .foregroundColor(.gray)
                    
                    SecureField("Enter your password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onChange(of: password) { _ in validateForm() }

                    if !passwordError.isEmpty {
                        Text(passwordError)
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }
                .padding(.horizontal)

                // Login Button
                Button(action: handleLogin) {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isFormValid ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .font(.headline)
                }
                .disabled(!isFormValid)
                .padding(.horizontal)

                // Navigation to Home
                NavigationLink(destination: HomeView(), isActive: $showHomeScreen) {
                    EmptyView()
                }
                .hidden()
            }
            .padding()
            .navigationTitle("Login")
        }
    }

    func validateForm() {
        // Email Validation (Format Check)
        if email.isEmpty {
            emailError = "Email is required."
        } else if !isValidEmail(email) {
            emailError = "Invalid email format."
        } else {
            emailError = ""
        }
        
        // Password Validation (Minimum Length)
        if password.isEmpty {
            passwordError = "Password is required."
        } else if password.count < 6 {
            passwordError = "Password must be at least 6 characters."
        } else {
            passwordError = ""
        }
        
        // Overall Form Validation
        isFormValid = emailError.isEmpty && passwordError.isEmpty
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex =  "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }

    func handleLogin() {
        // Retrieve saved data
        let savedEmail = UserDefaults.standard.string(forKey: "email") ?? ""
        let savedPassword = UserDefaults.standard.string(forKey: "password") ?? ""
        let savedName = UserDefaults.standard.string(forKey: "name") ?? "" // Get the saved name
        
        if email == savedEmail && password == savedPassword {
            UserDefaults.standard.set(savedName, forKey: "name") // Set the actual user's name
            showHomeScreen = true
        } else {
            emailError = email != savedEmail ? "Email not found." : ""
            passwordError = password != savedPassword ? "Incorrect password." : ""
        }
    }
}

