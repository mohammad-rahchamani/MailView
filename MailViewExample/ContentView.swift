//
//  ContentView.swift
//  MailViewExample
//
//  Created by Mohammad Rahchamani on 4/5/1399 AP.
//  Copyright © 1399 AP BetterSleep. All rights reserved.
//

import SwiftUI
import MailView



struct ContentView: View {
    
    @State private var showMailSheet = false
    
    var body: some View {
        NavigationView {
            Text("mail view showcase.")
        }
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
