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
    
    //TODO: Change this view to a visitcard view!
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
            //TODO: Enter user image
            Image(systemName: "lasso.sparkles")
                .resizable()
                .scaledToFit()
                .clipped()
                .frame(width: 64, height: 64)
                .clipShape(Circle())
                .padding(.bottom, 16)
            
            //Fullname - or name
            Text("\(user.name)")
                .font(.system(size:24, weight: .semibold))
            //Username
            Text("@\(user.username)")
                .font(.system(size:14))
                .padding(.bottom,24)
            
            //TODO: If user met > 1k People or more then 1k activities change number to x.xK
            HStack(){
                HStack(spacing: 4){
                    VStack
                    {
                        Text("\(user.peopleMet)")
                            .bold()
                        Text("People met")
                    }
                    
                }
                HStack(spacing: 4){
                    VStack
                    {
                        Text("\(user.visitedActivities)")
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

