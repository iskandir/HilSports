//
//  LoginView.swift
//  HilSports
//
//  Created by Dennis Hasselbusch on 29.08.21.
//

import SwiftUI
/**
 LoginView for user login.
 binding variable for ContentView :
 loggedUser = displays if the user is already logged correctly
 showLoginViev = displays if the LoginView needs to been shown
 */
struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State var showAlert = false
    
    @EnvironmentObject var loginModel : LoginModel
    @Binding var showLoginView : Bool
    @Binding var loggedUser : Bool
    @StateObject var firebaseModel = FirebaseAccess()
    
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
                    //TODO: Check if user is in database !!
                    guard !username.isEmpty, !password.isEmpty else {
                        showAlert = true
                        return
                    }
                    
                    firebaseModel.doesUserExist(username: username, completionHandler: {(success) -> Void in
                        if success {
                            print("user exist")
                        } else {
                            print("user does not exist")
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
                .alert(isPresented: self.$showAlert){
                    Alert(title: Text("Username and password needs to be filled"))
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



