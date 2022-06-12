//
//  SideMenu.swift
//  HilSports
//
//  Created by Dennis Hasselbusch on 27.08.21.
//

import SwiftUI

struct SideMenu: View {
    @Binding var showingMenu : Bool
    @EnvironmentObject var user : UserModel
    
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack{
                //show SideMenuHeaderView
                SideMenuHeaderView(showingMenu: $showingMenu)
                    .frame(height:240)
                
                //Cell items
                ForEach(SideMenuViewModel.allCases, id:\.self){option in
                    NavigationLink(destination: self.destinationView(title: option.title),
                                   label: {
                        SideMenuOptionView(viewModel: option)
                    })
                }
                
                Spacer()
                
            }
        }.navigationBarHidden(true)
    }
    //Destination when clicking any MenuItem
    func destinationView(title: String) -> AnyView{
           
           switch title {
               case "Profile" :
                   return AnyView(ProfileView())
               /* MARK: future list implementation if necessary
                case "Lists" :
                   return AnyView(ListsView())*/
               case "Bookmarks":
                   return AnyView(BookmarksView())
               case "Messages":
                   return AnyView(MessagesView())
               case "Notifications":
                   return AnyView(NotificationsView())
               case "Logout":
                   return AnyView(LogoutView())
               default:
                   return AnyView(Error())
               }
       }
}
