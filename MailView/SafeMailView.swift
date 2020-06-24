//
//  SafeMailView.swift
//  MailView
//
//  Created by Mohammad Rahchamani on 4/5/1399 AP.
//  Copyright © 1399 AP BetterSleep. All rights reserved.
//

import Foundation
import SwiftUI

public struct SafeMailView: View {
    
    let subject: String
    
    public init(subject: String = "") {
        
        self.subject = subject
        
    }
    
    public var body: some View {
        Group {
            if MailView.canSendMail {
                MailView(subject: self.subject)
            } else {
                Text("test")
            }
        }
    }
    
}
