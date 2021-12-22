//
//  RegistrationView.swift
//  HilSports
//
//  Created by Dennis Hasselbusch on 30.08.21.
//

import SwiftUI

/**
 View for user registration.
 Variables are email, username, password and password again
 */

struct RegistrationView: View {
    @State private var email : String = ""
    @State private var username : String = ""
    @State private var password : String = ""
    @State private var passwordAgain : String = ""
    @State private var showAlert : Bool = false
    @StateObject var viewModel = RegistrationViewModel()
    
    /**
     Double check which OS is the latest / which is most used os
     */
    var body: some View {
        if #available(iOS 15.0, *) {
            VStack(alignment: .leading){
                Text("Registration")
                    .font(.largeTitle)
                    .bold()
                    .frame(maxWidth : .infinity, alignment: .leading)
                    .padding(.top)
                    .foregroundColor(Color.primary.opacity(0.4))
                
                Text("Create a new account")
                    .font(.callout)
                    .frame(maxWidth : .infinity, alignment: .leading)
                Divider().padding()
                Spacer()
                VStack (spacing: 12) {
                    
                    TextField("Enter username", text: $username)
                        .modifier(FlatGlassView())
                    
                    TextField("Enter email", text: $email)
                        .modifier(FlatGlassView())
                    
                    
                    SecureField("Enter password", text: $password)
                        .modifier(FlatGlassView())
                    
                    
                    SecureField("Re-enter password", text: $passwordAgain)
                        .modifier(FlatGlassView())
                }
                .padding()
                
                Divider().padding()
                
                Text("By signing up you accept the **Terms of Service** and **Privacy Policy**")
                    .font(.footnote)
                
                Button {
                    guard !passwordAgain.isEmpty, !password.isEmpty else {
                        showAlert = true
                        print("Password one and password two are not the same")
                        return
                    }
                
                    let newUser = RegistrationModel(username: self.username, password: self.password, email: self.email)
                    viewModel.signUp(registrationUser: newUser)
                    
                    print("Registration")
                
                    
                } label: {
                    ZStack {
                        Text("SIGN UP")
                            .bold()
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .background(.thickMaterial)
                            .cornerRadius(14)
                            .padding(.bottom, 8)
                    }
                }.alert(isPresented: self.$showAlert){
                    Alert(title: Text("Passwords are not the same"))
                }
                
            }
            .padding()
            .background(.ultraThinMaterial)
            .foregroundColor(Color.primary.opacity(0.35))
            .foregroundStyle(.ultraThinMaterial)
            .cornerRadius(35)
            .padding()
            
        } else {
            // Fallback on earlier versions
            VStack {
                
            }
        }
    }
}
/**
 FlatGlassView is a ViewModifier for the registrationView.
 
 */
struct FlatGlassView : ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 15.0, *) {
            content
                .padding()
                .frame(height: 50)
                .background(.ultraThinMaterial)
                .cornerRadius(14)
        } else {
            // Fallback on earlier versions
            content
                .padding()
                .frame(height: 50)
                .cornerRadius(14)
        }
    }
}
