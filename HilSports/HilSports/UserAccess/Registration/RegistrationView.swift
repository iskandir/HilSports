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
    
    //Alert Identifier
    @State private var usernameAlert : Bool = false
    @State private var pwEmptyAlert : Bool = false
    @State private var pwNotSameAlert : Bool = false
    @State private var showRegistrationAlert : Bool = false
    @State private var userDoesExist : Bool = true
    @StateObject var viewModel = RegistrationViewModel()
    
    @State var test: Bool = false
    
    typealias CompletionHandler = (_ success: Bool) -> Void
    /**
     Double check which OS is the latest / which is most used os
     */
    var body: some View { 
        if #available(iOS 15.0, *) {
            VStack(){
                Text("Registration")
                    .font(.largeTitle)
                    .bold()
                    .frame(maxWidth : .infinity, alignment: .leading)
                    .padding(.top)
                    .foregroundColor(Color.primary.opacity(0.7))
                
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
                
                Text("By signing up you accept the \n**Terms of Service** and **Privacy Policy**")
                    .font(.footnote)
                    .fixedSize(horizontal: false, vertical: true)
                
                Button {
                    guard !username.isEmpty else{
                        usernameAlert = true
                        return
                    }
                    guard !password.isEmpty else {
                        pwEmptyAlert = true
                        return
                    }
                    guard password == passwordAgain else {
                        pwNotSameAlert = true
                        return
                    }
                    
                    
                    
                    guard usernameAlert || pwEmptyAlert || pwNotSameAlert else {
                        test = viewModel.doesUserExist(email: email, completionHandler: {(success) -> Void in
                            if success {
                                print("User does Exist!\nReturn Error!")
                                userDoesExist = true
                                test = true
                                print("Test is\(test)")
                                return
                            } else {
                                print("Test is\(test)")
                                print("User is not in DB")
                                
                            }
                        })
                        return
                    }
                
                    if !test
                    {
                        let newUser = RegistrationModel(username: self.username, password: self.password, email: self.email)
                        showRegistrationAlert = viewModel.signUp(registrationUser: newUser)
                        print("Registration sucessful")
                   
                    } else {
                        showRegistrationAlert = true
                        print("User is already in db")
                        return
                   
                    }
                } label: {
                    ZStack {
                        Text("SIGN UP")
                            .bold()
                            .font(.subheadline)
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .foregroundColor(.black)
                            .background(.thickMaterial)
                            .cornerRadius(14)
                            .padding(.bottom, 8)
                    }
                }.alert(isPresented: self.$pwEmptyAlert){
                    Alert(title: Text("Password field is Empty!"))
                }
                .alert(isPresented: self.$showRegistrationAlert){
                    Alert(
                        title: Text("Title"),
                        message: Text("Message"),
                        dismissButton: .default(Text("Okay"), action: {
                        })
                    )
                }
                .alert(isPresented: self.$pwNotSameAlert){
                    Alert(
                        title: Text("Passwords are not the same"),
                        message: Text("Message"),
                        dismissButton: .default(Text("Okay"), action: {
                        })
                    )
                }
                .alert(isPresented: self.$usernameAlert){
                    Alert(
                        title: Text("Username needs to be filled"),
                        message: Text("Message"),
                        dismissButton: .default(Text("Okay"), action: {
                        })
                    )
                }
                .alert(isPresented: self.$userDoesExist){
                    Alert(
                        title: Text("User does exist in db"),
                        message: Text("Message"),
                        dismissButton: .default(Text("Okay"), action: {
                        })
                    )
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
                .shadow(color: .white.opacity(0.65), radius: 1, x: -1, y:-2)
                .shadow(color: .black.opacity(0.65), radius: 2, x: 2, y:2)
        } else {
            // Fallback on earlier versions
            content
                .padding()
                .frame(height: 50)
                .cornerRadius(14)
                .shadow(color: .white, radius: 3, x: -3, y:-3)
                .shadow(color: .black, radius: 3, x:3, y:3)
        }
    }
}
