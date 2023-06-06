//
//  SavePasswordView.swift
//  CyberProject
//
//  Created by Amir Zhunussov on 05.06.2023.
//

import SwiftUI
import SwiftUIX
import KeychainSwift

struct SavePasswordView: View {
    
    @Binding var password: String
    @Binding var sheetIsPresented: Bool
    @ObservedObject var editedPassword = TextBindingManager(limit: 30)
    @State private var username = ""
    @State private var title = ""
    @State private var isEditingPassword = false
    @State private var showKeyboard = false
    @State private var passwordLenght = ""
    @State private var showMissingTitleAlert = false
    @State private var showMissingPasswordAlert = false
    @State private var showMissingPasswordAndTitleAlert = false
    @State private var showMissingUsernameFooter = false
    @State private var showMissingTitleFooter = false
    @State var generatedPasswordIsPresented: Bool
    @ObservedObject var viewModel: PasswordListViewModel
    @ObservedObject var settings:SettingsViewModel
    let keyboard = Keyboard()
    let keychain = KeychainSwift()
    
    var body: some View {
        NavigationView {
            
            VStack {
                
                Form {
                    Section(header: Text("Password").foregroundColor(.gray),
                            footer: passwordLenght.isEmpty ? Text("Required Field")
                                .foregroundColor(.red) : Text("")) {
                        HStack {
                            Spacer()
                            
                            if !isEditingPassword {
                                Text(editedPassword.text)
                                    .foregroundColor(.gray).font(editedPassword.characterLimit > 25 ? .system(size: 15) : .body)
                                
                            } else {
                                
                                TextField(password, text: $editedPassword.text)
                                    .keyboardType(.asciiCapable)
                                    .disableAutocorrection(true)
                                
                            }
                            Spacer()
                            
                            if !isEditingPassword {
                                
                                Button(action: {
                                    withAnimation {
                                        isEditingPassword.toggle()
                                        showKeyboard = keyboard.isShowing
                                    }
                                    
                                }, label: {
                                    Text("Modifier")
                                })
                                .buttonStyle(PlainButtonStyle())
                                .foregroundColor(settings.colors[settings.accentColorIndex])
                                
                            }
                            else {
                                Button(action: {
                                    withAnimation(.default) {
                                        isEditingPassword.toggle()
                                        showKeyboard = keyboard.isShowing
                                        viewModel.addedPasswordHaptic()
                                    }
                                    
                                }, label: {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(!editedPassword.text.isEmpty ? .green : .blue)
                                })
                                .animation(.easeIn)
                                .disabled(editedPassword.text.isEmpty)
                                .buttonStyle(PlainButtonStyle())
                                .foregroundColor(settings.colors[settings.accentColorIndex])
                            }
                        }
                        .alert(isPresented: $showMissingPasswordAlert, content: {
                            Alert(title: Text("Invalid password"), message: Text("The password field cannot be empty."), dismissButton: .cancel(Text("OK!")))
                            
                        })
                    }
                    
                    Section(header: Text("Account Name").foregroundColor(.gray)) {
                        TextField("ex: example@icloud.com", text: $username)
                        
                    }
                    
                    Section(header: Text("Title").foregroundColor(.gray), footer: title.isEmpty ? Text("Required Field").foregroundColor(.red) : Text("") ) {
                        TextField("ex: Twitter", text: $title)
                        
                    }
                    .alert(isPresented: $showMissingTitleAlert, content: {
                        Alert(title: Text("Missing field"), message: Text("You must at least give an account name to your password."), dismissButton: .cancel(Text("OK!")))
                        
                    })
                    
                }
                .alert(isPresented: $showMissingPasswordAndTitleAlert, content: {
                    Alert(title: Text("Missing fields"), message: Text("Missing field(s)."), dismissButton: .cancel(Text("OK!")))
                })
                .navigationBarTitle("New Password")
                .navigationBarItems(leading: Button(action: {
                    
                    sheetIsPresented.toggle()
                    
                }, label: {
                    Text("Cancel")
                })
                                    
                                    , trailing: Button(action: {
                    
                    withAnimation {
                        
                        if !isEditingPassword {
                            
                            if title.isEmpty || editedPassword.text.isEmpty {
                                showMissingPasswordAndTitleAlert.toggle()
                                print("Missing fields")
                            }
                            
                            else if !title.isEmpty && !editedPassword.text.isEmpty {
                                sheetIsPresented.toggle()
                                viewModel.saveToKeychain(password: editedPassword.text, username: username, title: title)
                                viewModel.getAllKeys()
                            }
                        }
                    }
                    
                }, label: {
                    Text("Register")
                })
                .disabled(isEditingPassword ? true : false))
            }
            .onChange(of: editedPassword.text.count, perform: { _ in
                passwordLenght = editedPassword.text
            })
        }
        .overlay(settings.isHiddenInAppSwitcher ? EmptyView() : nil)
        .onAppear(perform: {
            if !generatedPasswordIsPresented {
                isEditingPassword = true
                
            }
            editedPassword.text = password
            passwordLenght = password
        })
    }
}
