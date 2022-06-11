//
//  LoginView.swift
//  HilSports
//
//  Created by Dennis Hasselbusch on 29.08.21.
//

import SwiftUI

enum ActiveAlerts
{
    case bothEmptyAlert, usernameDoesNotExist, wrongPasswordAlert
}
/**
 LoginView for user login.
 binding variable for ContentView :
 loggedUser = displays if the user is already logged correctly
 showLoginViev = displays if the LoginView needs to been shown
 */
struct LoginView: View {
    //User Login Var
    @State private var username = ""
    @State private var password = ""
    @State private var email = ""
    
    //Alert Identifier
    @State private var showAlert : Bool = false
    @State private var activeAlert: ActiveAlerts = .bothEmptyAlert
    
    //Model identifier
    @State var updateUserData = UpdateUserData()
    @State var firebaseModel = FirebaseAccess()
    @Binding var showLoginView : Bool
    @Binding var loggedUser : Bool
    
    @EnvironmentObject var user : UserModel
    
    typealias CompletionHandler = (_ success: Bool) -> Void
    
    var body: some View {
        if #available(iOS 15.0, *) {
            VStack{
                VStack{
                    TextField("Enter username", text: $username)
                        .modifier(GlassView())
                    
                    SecureField("Enter password", text: $password)
                        .modifier(GlassView())
                }
                .padding()
                
                Button {
                    guard !username.isEmpty, !password.isEmpty else {
                        self.activeAlert = .bothEmptyAlert
                        self.showAlert = true
                        return
                    }
                    
                    firebaseModel.doesUserExist(username: username, completionHandler: {(success) -> Void in
                        if success {
                            user.username = username
                            firebaseModel.checkPassword(username: username, password: password, completionHandler: {(success) -> Void in
                                if success
                                {
                                    let updateUserData = UpdateUserData()
                                    updateUserData.setUserData(user: user)
                                    //TODO: set activeAlert userDataError!!! when no network etc...
                                    loggedUser = true
                                } else {
                                    print("password is not correct")
                                    self.activeAlert = .wrongPasswordAlert
                                    self.showAlert = true
                                    return
                                }
                            })
                        } else {
                            print("Username does not exist")
                            self.activeAlert = .usernameDoesNotExist
                            self.showAlert = true
                            return
                        }
                            
                    })
                    
                } label: {
                    ZStack {
                        Text("SIGN IN")
                            .bold()
                            .frame(maxWidth: 220, maxHeight: 50)
                            .background(.white)
                            .cornerRadius(14)
                            .padding(.bottom, 8)
                            .shadow(color: .white.opacity(0.65), radius: 14, x: -1, y: -2)
                            .shadow(color: .black.opacity(0.65), radius: 14, x: 2, y: 2)
                    }
                }
                .alert(isPresented: $showAlert){
                    switch activeAlert {
                    case .bothEmptyAlert:
                        return Alert(title: Text("Email and password needs to be filled"))
                    case .usernameDoesNotExist:
                        return Alert(title: Text("Username does not exist"))
                    case .wrongPasswordAlert:
                        return Alert(title: Text("Wrong password"))
                    }
                }
                Button {
                    showLoginView = false
                } label: {
                    Text("Back")
                        .bold()
                        .frame(maxWidth: 220, maxHeight: 50)
                        .background(.white)
                        .cornerRadius(14)
                        .padding(.bottom, 8)
                        .shadow(color: .white.opacity(0.65), radius: 14, x: -1, y: -2)
                        .shadow(color: .black.opacity(0.65), radius: 14, x: 2, y: 2)
                }
                
                Button {
                    //TODO:
                } label: {
                    Text("Forgot my login")
                }
            }
            .padding(20)
            .background(.ultraThinMaterial)
            .foregroundColor(Color.black)
            .foregroundStyle(.ultraThinMaterial)
            .cornerRadius(35)
            .environmentObject(user)
        } else {
            // Fallback on earlier versions
        }
    }
}
struct GlassView : ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 15.0, *){
            content
                .padding()
                .frame(height: 50)
                .background(.ultraThinMaterial)
                .cornerRadius(14)
                .shadow(color: .white.opacity(0.65), radius: 1, x: -1, y: -2)
                .shadow(color: .black.opacity(0.65), radius: 2, x: 2, y: 2)
        } else {
            // Fallback on earlier versions
            content
                .padding()
                .frame(height: 50)
                .cornerRadius(14)
                .shadow(color: .white, radius: 3, x: -3, y: -3)
                .shadow(color: .black, radius: 3, x: 3, y: 3)
            
        }
    }
}



