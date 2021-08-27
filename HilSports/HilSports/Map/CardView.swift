//
//  CardView.swift
//  HilSports
//
//  Created by Dennis Hasselbusch on 27.08.21.
//


import SwiftUI

struct CardView: View {
    @State var filter: FilterItem
    
    var body: some View {
        HStack{
            Text(filter.title)
                .fontWeight(.semibold)
                .foregroundColor(Color.black.opacity(0.7))
            Spacer()
            
            ZStack{
                Circle()
                    .stroke(filter.checked ? Color("green") : Color.gray, lineWidth: 1)
                    .frame(width: 25, height: 25)
            }
            
            if filter.checked{
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size:25))
                    
            }
        }
        .padding(.horizontal)
        .contentShape(Rectangle())
        .onTapGesture(perform: {
            filter.checked.toggle()
        })
    }
}
