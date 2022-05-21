//
//  RegistrationView.swift
//  HilSports
//
//  Created by Dennis Hasselbusch on 30.08.21.
//

import SwiftUI
import Firebase

//all Alerts
enum ActiveAlert{
    case usernameAlert,
         emailAlert,
         pwEmptyAlert,
         pwNotSameAlert,
         userDoesExist,
         registrationSuccess
}

struct RegistrationView: View {

    //Object for RegistrationViewModel
    @StateObject var viewModel = FirebaseAccess()
    
    //User variable
    @State private var email : String = ""
    @State private var username : String = ""
    @State private var password : String = ""
    @State private var passwordAgain : String = ""
    
    //Alert Identifier
    @State private var showAlert = false
    @State private var activeAlert: ActiveAlert = .usernameAlert
    
    typealias CompletionHandler = (_ success: Bool) -> Void
    typealias CompletionHaendler = (_ sucessMessage: Bool) -> Void
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
                    guard !username.isEmpty else {
                        self.activeAlert = .usernameAlert
                        self.showAlert = true
                        return
                    }
                    guard !email.isEmpty else {
                        self.activeAlert = .emailAlert
                        self.showAlert = true
                        return
                    }
                    guard !password.isEmpty else {
                        self.activeAlert = .pwEmptyAlert
                        self.showAlert = true
                        return
                    }
                    guard password == passwordAgain else {
                        self.activeAlert = .pwNotSameAlert
                        self.showAlert = true
                        return
                    }

                    if !showAlert{
                    viewModel.doesEmailExist(email: email,completionHandler: { (success) -> Void in
                        if success{
                            print("Email exists")
                            self.activeAlert = .emailAlert
                            self.showAlert = true
                            
                        } else {
                            print("Email does not exist")
                            viewModel.doesUserExist(username: username, completionHandler: {(success) -> Void in
                                if success{
                                    print("User does exist")
                                    self.activeAlert = .userDoesExist
                                    self.showAlert = true
                                } else {
                                    let registrationUser : UserModel = UserModel(username: username, password: password, email: email)
                                    viewModel.signUp(registrationUser: registrationUser, completionHaendler: {(successMessage) -> Void in
                                        if successMessage{
                                            print("sucessmsg is: \(successMessage)")
                                            self.activeAlert = .registrationSuccess
                                            self.showAlert = true
                                            
                                        } else {
                                            print("sucessmsg is: \(successMessage)")
                                        }
                                    })
                                }
                            })
                        }
                        
                        
                    })}
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
                    .alert(isPresented: $showAlert){
                        switch activeAlert {
                            case .usernameAlert:
                                return Alert(title: Text("Username needs to be filled"))
                            case .emailAlert:
                                return Alert(title: Text("Email needs to be filled"))
                            case .pwEmptyAlert:
                                return Alert(title: Text("Password field is Empty!"))
                            case .pwNotSameAlert:
                                return Alert(title: Text("Passwords are not the same"))
                            case .userDoesExist:
                                return Alert(title: Text("User does exist in db"))
                            case .registrationSuccess:
                                return Alert(title: Text("Registration successfull.\nYou can login now."))
                        }
                    }
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
