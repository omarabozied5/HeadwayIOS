import SwiftUI

struct ProfileScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var languageManager = LanguageManager.shared
    
    @State private var isEditingName = false
    @State private var newName: String = ""
    
    @AppStorage("name") private var username: String = "John Doe"
    @AppStorage("email") private var userEmail: String = "john.doe@example.com"
    @AppStorage("phone") private var userPhoneNumber: String = "123-456-7890"
    
    @State private var navigateToLogin = false
    
    var body: some View {
        VStack(spacing: 20) {
            // Profile Icon
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
                .padding(.top, 20)
            
            // Language Toggle Button
            Button(action: {
                withAnimation {
                    languageManager.isArabic.toggle()
                }
            }) {
                HStack {
                    Image(systemName: "globe")
                    Text(languageManager.isArabic ? "English" : "العربية")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding(.horizontal)
            
            // Editable Name Field
            VStack(alignment: languageManager.isArabic ? .trailing : .leading) {
                Text("Name".localized)
                    .font(.headline)
                    .foregroundColor(.gray)
                
                if isEditingName {
                    TextField("Enter new name".localized, text: $newName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(8)
                        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1))
                        .multilineTextAlignment(languageManager.textAlignment)
                } else {
                    Text(username)
                        .font(.title3)
                        .padding(8)
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.2)))
                        .onTapGesture {
                            isEditingName = true
                            newName = username
                        }
                }
            }
            .padding(.horizontal)
            
            // Save Button
            if isEditingName {
                Button(action: saveName) {
                    Text("Save".localized)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
            }
            
            // Email and Phone
            ProfileRow(label: "Email".localized, value: userEmail, isDisabled: true)
                .environment(\.layoutDirection, languageManager.layoutDirection)
            
            ProfileRow(label: "Phone Number".localized, value: userPhoneNumber, isDisabled: true)
                .environment(\.layoutDirection, languageManager.layoutDirection)
            
            Spacer()
            
            // Logout Button
            Button(action: { navigateToLogin = true }) {
                Text("Logout".localized)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
            // Delete Account Button
            Button(action: deleteAccount) {
                Text("Delete Account".localized)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
            
            NavigationLink(destination: LoginScreen(), isActive: $navigateToLogin) {
                EmptyView()
            }
            .hidden()
        }
        .padding()
        .background(Color(UIColor.systemGroupedBackground))
        .navigationTitle("Profile".localized)
        .environment(\.layoutDirection, languageManager.layoutDirection)
    }
    
    // Existing functions remain the same
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


// ✅ Custom ProfileRow View (for Email & Phone)
struct ProfileRow: View {
    let label: String
    let value: String
    var isDisabled: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.headline)
                .foregroundColor(.gray)
            
            Text(value)
                .font(.title3)
                .padding(8)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                .foregroundColor(isDisabled ? .gray : .black)
                .opacity(isDisabled ? 0.6 : 1.0)
        }
        .padding(.horizontal)
    }
}
