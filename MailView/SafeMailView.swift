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
    
    let toRecipients: [String]?
    let ccRecipients: [String]?
    let bccRecipients: [String]?
    
    let messageBody: String
    let isHtml: Bool
    
    let attachments: [AttachmentData]?
    
    let preferredSendingAddress: String
    
    // MARK: init
    public init(isShowing: Binding<Bool>,
                subject: String = "",
                toRecipients: [String]? = nil,
                ccRecipients: [String]? = nil,
                bccRecipients: [String]? = nil,
                messageBody: String = "",
                isHtml: Bool = false,
                attachments: [AttachmentData]? = nil,
                preferredSendingAddress: String = "") {
        self._isShowing = isShowing
        
        self.subject = subject
        
        self.toRecipients = toRecipients
        self.ccRecipients = ccRecipients
        self.bccRecipients = bccRecipients
        
        self.messageBody = messageBody
        self.isHtml = isHtml
        
        self.attachments = attachments
        
        self.preferredSendingAddress = preferredSendingAddress
    }
    
    public var body: some View {
        Group {
            if MailView.canSendMail {
                MailView(isShowing: self.$isShowing,
                         subject: self.subject,
                         toRecipients: self.toRecipients,
                         ccRecipients: self.ccRecipients,
                         bccRecipients: self.bccRecipients,
                         messageBody: self.messageBody,
                         isHtml: self.isHtml,
                         attachments: self.attachments,
                         preferredSendingAddress: self.preferredSendingAddress)
            } else {
                Text("test")
            }
        }
    }
    
}
