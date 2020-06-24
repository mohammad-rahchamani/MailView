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
    
    @Binding var isShowing: Bool
    
    let subject: String
    
    public init(isShowing: Binding<Bool>,
                subject: String = "") {
        self._isShowing = isShowing
        self.subject = subject
        
    }
    
    public var body: some View {
        Group {
            if MailView.canSendMail {
                MailView(isShowing: self.$isShowing,
                         subject: self.subject)
            } else {
                Text("test")
            }
        }
    }
    
}
