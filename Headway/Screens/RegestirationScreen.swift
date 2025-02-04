//
//  RegestirationScreen.swift
//  Headway
//
//  Created by omar abozeid on 20/01/2025.
//

import SwiftUI

struct RegestirationScreen: View {
    @State private var name = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    @State private var nameError = ""
    @State private var emailError = ""
    @State private var phoneError = ""
    @State private var passwordError = ""
    @State private var confirmPasswordError = ""
    
    @State private var isFormValid = false
    @State private var showSuccessNotification = false
    @State private var showLoginScreen = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if showSuccessNotification {
                    Text("Registration Completed Successfully!")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green.opacity(0.9))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .transition(.slide)
                        .animation(.easeInOut, value: showSuccessNotification)
                        .padding(.top, 10)
                }
                
                Text("Register")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                // Name Input
                VStack(alignment: .leading, spacing: 5) {
                    TextField("Name (Max 50 chars)", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onChange(of: name) { _ in validateForm() }
                    if !nameError.isEmpty {
                        Text(nameError)
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }
                
                // Email Input
                VStack(alignment: .leading, spacing: 5) {
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.emailAddress)
                        .onChange(of: email) { _ in validateForm() }
                    if !emailError.isEmpty {
                        Text(emailError)
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }
                
                // Phone Input
                VStack(alignment: .leading, spacing: 5) {
                    TextField("Phone", text: $phone)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.phonePad)
                        .onChange(of: phone) { _ in validateForm() }
                    if !phoneError.isEmpty {
                        Text(phoneError)
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }
                
                // Password Input
                VStack(alignment: .leading, spacing: 5) {
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onChange(of: password) { _ in validateForm() }
                    if !passwordError.isEmpty {
                        Text(passwordError)
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }
                
                // Confirm Password Input
                VStack(alignment: .leading, spacing: 5) {
                    SecureField("Confirm Password", text: $confirmPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onChange(of: confirmPassword) { _ in validateForm() }
                    if !confirmPasswordError.isEmpty {
                        Text(confirmPasswordError)
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }
                
                Button(action: handleRegister) {
                    Text("Register")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isFormValid ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .disabled(!isFormValid)
                
                // Navigation to Login Screen
                NavigationLink("", destination: LoginScreen()
                    .navigationBarBackButtonHidden(true), isActive: $showLoginScreen)
            }
            .padding()
            .navigationTitle("Registration")
        }
    }
    
    func validateForm() {
        // Name Validation
        if name.isEmpty {
            nameError = "Name is required."
        } else if name.count > 50 {
            nameError = "Name must not exceed 50 characters."
        } else {
            nameError = ""
        }
        
        // Email Validation
        if email.isEmpty {
            emailError = "Email is required."
        } else if !isValidEmail(email) {
            emailError = "Invalid email format."
        } else {
            emailError = ""
        }
        
        // Phone Validation
        if phone.isEmpty {
            phoneError = "Phone number is required."
        } else if !isValidEgyptianPhone(phone) {
            phoneError = "Invalid Egyptian phone number. Must start with 010, 011, 012, or 015 and have 11 digits."
        } else {
            phoneError = ""
        }
        // Password Validation
        if password.isEmpty {
            passwordError = "Password is required."
        } else if !isValidPassword(password) {
            passwordError = "Password must contain 1 uppercase, 1 lowercase, 1 digit, and 1 special character."
        } else {
            passwordError = ""
        }
        
        
        
        // Confirm Password Validation
        if confirmPassword != password {
            confirmPasswordError = "Passwords do not match."
        } else {
            confirmPasswordError = ""
        }
        
        // Overall Form Validation
        isFormValid = nameError.isEmpty && emailError.isEmpty && phoneError.isEmpty && passwordError.isEmpty && confirmPasswordError.isEmpty
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        let regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: password)
    }
    
    func isValidEgyptianPhone(_ phone: String) -> Bool {
        let regex = "^(010|011|012|015)[0-9]{8}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: phone)
    }
    
    func handleRegister() {
        // Save user data to UserDefaults
        UserDefaults.standard.set(email, forKey: "email")
        UserDefaults.standard.set(password, forKey: "password")
        UserDefaults.standard.set(name, forKey: "name")
        UserDefaults.standard.set(phone, forKey: "phone")
        
        // Show success notification
        showSuccessNotification = true
        showLoginScreen = true
        
        // Automatically hide notification after 2 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                showSuccessNotification = false
            }
        }
    }
}


#Preview {
    RegestirationScreen()
}
