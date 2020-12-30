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
    
    @State var showMailSheet = false
    
    var body: some View {
        NavigationView {
            Button(action: {
                self.showMailSheet.toggle()
            }) {
                Text("compose")
            }
        }
        .sheet(isPresented: self.$showMailSheet) {
            MailView(isShowing: self.$showMailSheet,
                     resultHandler: {
                        value in
                        switch value {
                        case .success(let result):
                            switch result {
                            case .cancelled:
                                print("cancelled")
                            case .failed:
                                print("failed")
                            case .saved:
                                print("saved")
                            default:
                                print("sent")
                            }
                        case .failure(let error):
                            print("error: \(error.localizedDescription)")
                        }
            },
                     subject: "test Subjet",
                     toRecipients: ["recipient@test.com"],
                     ccRecipients: ["cc@test.com"],
                     bccRecipients: ["bcc@test.com"],
                     messageBody: "works like a charm!",
                     isHtml: false,
                     attachments: [("Sample file content".data(using: .utf8)!,
                                    "Text",
                                    "sample.txt")])
            .safe()
            
        }
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
