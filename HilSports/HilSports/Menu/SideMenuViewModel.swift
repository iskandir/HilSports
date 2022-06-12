//
//  SideMenuViewModel.swift
//  HilSports
//
//  Created by Dennis Hasselbusch on 27.08.21.
//

import Foundation

enum SideMenuViewModel: Int, CaseIterable{
    case profile
    /* MARK: future list implementation if necessary
    case lists
    */
    case bookmarks
    case messages
    case notifications
    case logout
    
    var title: String {
        switch self {
            case .profile : return "Profile"
            /* MARK: future list implementation if necessary
             case .lists : return "Lists"
             */
            case .bookmarks : return "Bookmarks"
            case .messages : return "Messages"
            case .notifications : return "Notifications"
            case .logout : return "Logout"
        }
    }
    
    var imageName : String {
        switch self {
            case .profile : return "person"
            /* MARK: future list implementation if necessary
            case .lists : return "list.bullet"
            */
            case .bookmarks : return "bookmark"
            case .messages : return "bubble.left"
            case .notifications : return "bell"
            case .logout : return "arrow.left.square"
        }
    }
    
}
