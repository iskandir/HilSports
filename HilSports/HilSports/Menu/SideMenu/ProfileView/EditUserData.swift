//
//  EditUserData.swift
//  HilSports
//
//  Created by Dennis Hasselbusch on 13.06.22.
//

import SwiftUI

struct EditUserData : View
{
    //presentationMode to presentate the profile card
    @Environment(\.presentationMode) var presentationMode
    var body : some View
    {
        NavigationView
        {
            Form
            {
                UserImageData()
                AboutYouData()
            }
            .navigationBarTitle(Text("Profile"))
            .navigationBarItems(trailing: Button( action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {Text("Done")}))

        }
    }
}
struct UserImageData : View
{
    var body : some View
    {
        Section(header: Text("User Image"))
        {
            HStack
            {
                Image(systemName: "person.crop.circle")
                Button(action: {
                    //set action
                }, label: {
                    Text("Change profile image")
                })
            }
        }
        
    }
}
struct AboutYouData : View
{
    @State var description = "DefaultSettings.nameDefaultSettings.nameDefaultSettings.nameDefaultSettings.nameDefaultSettings.nameDefaultSettings.nameDefaultSettings.nameDefaultSettings.nameDefaultSettings.nameDefaultSettings.nameDefaultSettings.nameDefaultSettings.nameDefaultSettings.nameDefaultSettings.nameDefaultSettings.nameDefaultSettings.nameDefaultSettings.nameDefaultSettings.name"
    
    var body : some View
    {
        Section(header: Text("About you"))
        {
            HStack
            {
                TextEditor(text: $description)
            }
        }
        
    }
}
