//
//  MailView.swift
//  MailView
//
//  Created by Mohammad Rahchamani on 4/5/1399 AP.
//  Copyright © 1399 AP BetterSleep. All rights reserved.
//

import Foundation
import MessageUI
import SwiftUI

public struct MailView: UIViewControllerRepresentable {
    
    let subject: String
    let recipients: [String]?
    
    public init(recipients: [String]? = nil,
                subject: String = "") {
        self.recipients = recipients
        self.subject = subject
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    public func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let viewController = MFMailComposeViewController()
        viewController.setToRecipients(self.recipients)
        viewController.setSubject(self.subject)
        //
        return viewController
    }
    
    public func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {
        
    }
    
    public class Coordinator: NSObject {
        
    }
    
}

// MARK: extension
extension MailView {
    
    public static var canSendMail: Bool {
        MFMailComposeViewController.canSendMail()
    }
    
}
