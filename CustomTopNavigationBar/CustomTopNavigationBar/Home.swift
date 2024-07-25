//
//  ContentView.swift
//  CustomTopNavigationBar
//
//  Created by Anas Hamad on 7/25/24.
//

import SwiftUI

struct Home: View {
    var body: some View {
       
            CustomNavView{
                ZStack{
                    CustomNavLink {
                        Text("SecondScreen")
                            .customNavigationColor(.blue)
                            .customNavigationTitle("Second")
                            .customBackButtonColor(.white)
                    } label: {
                        Text("Go to second")
                    }

                }
                .customNavigationTitle("Title")
                .customNavigationColor(.purple)
                .customBackButtonColor(.white)
                .customNavigationBackBottun(true)
                
            }

    }
}

#Preview {
    Home()
}
