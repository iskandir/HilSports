//
//  SideMenuOptionView.swift
//  HilSports
//
//  Created by Dennis Hasselbusch on 27.08.21.
//

import SwiftUI

struct SideMenuOptionView: View {
    let viewModel : SideMenuViewModel
    @State private var messagesCount : Int = 0
    
    var body: some View {
        HStack(spacing: 16){
            if viewModel.title == "Messages" && messagesCount > 0
            {
                ZStack{
                    Image(systemName: viewModel.imageName)
                    .frame(width: 24, height: 24)
                    Text("\(messagesCount)")
                        .padding(6).background(Color.red).clipShape(Circle()).foregroundColor(.white).offset(x:17, y:-10)
                }
            } else {
                Image(systemName: viewModel.imageName)
                    .frame(width:24, height:24)
            }
            Text(viewModel.title)
                .font(.system(size:15, weight: .semibold))
            Spacer()
        }
        .foregroundColor(.white)
        .padding()
    }
}
