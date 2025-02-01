import SwiftUI


struct ProfileScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var languageManager: LanguageManager
    
    @State private var isEditingName = false
    @State private var newName: String = ""
    
    @AppStorage("name") private var username: String = "John Doe"
    @AppStorage("email") private var userEmail: String = "john.doe@example.com"
    @AppStorage("phone") private var userPhoneNumber: String = "123-456-7890"
    
    @State private var navigateToLogin = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Profile Icon
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                    .padding(.top, 20)
                
                // Language Toggle Button
                Button(action: {
                    languageManager.toggleLanguage()
                }) {
                    HStack {
                        Image(systemName: "globe")
                        Text(languageManager.localizedText("language"))
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding(.horizontal)
                
                // Editable Name Field
                VStack(alignment: languageManager.isRTL ? .trailing : .leading) {
                    Text(languageManager.localizedText("name"))
                        .font(.headline)
                        .foregroundColor(.gray)
                    
                    if isEditingName {
                        TextField(languageManager.localizedText("enterNewName"), text: $newName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .multilineTextAlignment(languageManager.isRTL ? .trailing : .leading)
                            .padding(8)
                            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1))
                    } else {
                        Text(username)
                            .font(.title3)
                            .padding(8)
                            .frame(maxWidth: .infinity, alignment: languageManager.isRTL ? .trailing : .leading)
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
                        Text(languageManager.localizedText("save"))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }
                
                // Email and Phone
                ProfileRow(
                    label: languageManager.localizedText("email"),
                    value: userEmail,
                    isDisabled: true,
                    isRTL: languageManager.isRTL
                )
                
                ProfileRow(
                    label: languageManager.localizedText("phone"),
                    value: userPhoneNumber,
                    isDisabled: true,
                    isRTL: languageManager.isRTL
                )
                
                Spacer()
                
                // Logout Button
                Button(action: { navigateToLogin = true }) {
                    Text(languageManager.localizedText("logout"))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                // Delete Account Button
                Button(action: deleteAccount) {
                    Text(languageManager.localizedText("deleteAccount"))
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
            .navigationTitle(languageManager.localizedText("profile"))
            
        }
       
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
    let label: String
    let value: String
    var isDisabled: Bool = false
    var isRTL: Bool = false
    
    var body: some View {
        VStack(alignment: isRTL ? .trailing : .leading, spacing: 8) {
            Text(label)
                .font(.headline)
                .foregroundColor(.gray)
            
            Text(value)
                .font(.title3)
                .padding(8)
                .frame(maxWidth: .infinity, alignment: isRTL ? .trailing : .leading)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                .foregroundColor(isDisabled ? .gray : .black)
                .opacity(isDisabled ? 0.6 : 1.0)
        }
        .padding(.horizontal)
    }
}
