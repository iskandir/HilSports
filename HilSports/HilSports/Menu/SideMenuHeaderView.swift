//
//  SideMenuHeaderView.swift
//  HilSports
//
//  Created by Dennis Hasselbusch on 27.08.21.
//

import SwiftUI

struct SideMenuHeaderView: View {
    @Binding var showingMenu : Bool
    
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
            Image(systemName: "lasso.sparkles")
                .resizable()
                .scaledToFit()
                .clipped()
                .frame(width: 64, height: 64)
                .clipShape(Circle())
                .padding(.bottom, 16)
            
            Text("My Name")
                .font(.system(size:24, weight: .semibold))
            
            Text("@myNick")
                .font(.system(size:14))
                .padding(.bottom,24)
            
            HStack(spacing: 12){
                HStack(spacing: 4){
                    Text("1234")
                        .bold()
                    Text("Member")
                }
                HStack(spacing: 4){
                    Text("123")
                        .bold()
                    Text("User")
                }
                Spacer()
            }
            Spacer()
        }
        .foregroundColor(Color.white)
        .padding()
        }
        
    }
}
