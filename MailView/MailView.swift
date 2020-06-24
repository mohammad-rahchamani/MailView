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
    
    @Binding var isShowing: Bool
    
    let subject: String
    let recipients: [String]?
    
    // MARK: init
    public init(isShowing: Binding<Bool>,
                recipients: [String]? = nil,
                subject: String = "") {
        self._isShowing = isShowing
        self.recipients = recipients
        self.subject = subject
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(isShowing: self.$isShowing)
    }
    
    // MARK: make view controller
    public func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let viewController = MFMailComposeViewController()
        viewController.mailComposeDelegate = context.coordinator
        viewController.setToRecipients(self.recipients)
        viewController.setSubject(self.subject)
        //
        return viewController
    }
    
    // MARK: update view controller
    public func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {
        
    }
    
    // MARK: coordinator
    public class Coordinator: NSObject {
        
        @Binding var isShowing: Bool
        
        init(isShowing: Binding<Bool>) {
            self._isShowing = isShowing
        }
        
    }
    
}

// MARK: coordinator extension
extension MailView.Coordinator: MFMailComposeViewControllerDelegate {
    
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.isShowing = false
    }
    
}

// MARK: mail view extension
extension MailView {
    
    public static var canSendMail: Bool {
        MFMailComposeViewController.canSendMail()
    }
    
}
