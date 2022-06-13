//
//  SideMenuHeaderView.swift
//  HilSports
//
//  Created by Dennis Hasselbusch on 27.08.21.
//

import SwiftUI

struct SideMenuHeaderView: View {
    @Binding var showingMenu : Bool
    @EnvironmentObject var user : UserModel
    
    var body: some View {
        ZStack(alignment: .topTrailing){
            Button(action:{
                withAnimation(.spring()){
                    showingMenu.toggle()
                }
                
            }, label: {
                Image(systemName: "xmark")
                    .frame(width: 32, height: 32)
                    .foregroundColor(.white)
                    .padding()
            })
            
        VStack(alignment: .leading){
            //Enter user Image
            Image(systemName: "lasso.sparkles")
                .resizable()
                .scaledToFit()
                .clipped()
                .frame(width: 64, height: 64)
                .clipShape(Circle())
                .padding(.bottom, 16)
            
            //Fullname - or name
            Text("No Name entered")
                .font(.system(size:24, weight: .semibold))
            //Username
            Text("@\(user.username)")
                .font(.system(size:14))
                .padding(.bottom,24)
            
            HStack(){
                HStack(spacing: 4){
                    VStack
                    {
                        Text("123")
                            .bold()
                        Text("People met")
                    }
                    
                }
                HStack(spacing: 4){
                    VStack
                    {
                        Text("1234")
                            .bold()
                        Text("visited activities")
                    }
                }
                
            }
            Spacer()
        }
        .foregroundColor(Color.white)
        .padding()
        }
    }
}

