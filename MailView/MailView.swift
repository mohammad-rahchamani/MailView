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

public typealias AttachmentData = (Data, String, String)
public typealias MailViewResult = MFMailComposeResult

public struct MailView: UIViewControllerRepresentable {
    
    @Binding var isShowing: Bool
    var result: ((Result<MailViewResult, Error>) -> Void)?
    
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
                result: ((Result<MailViewResult, Error>) -> Void)? = nil,
                subject: String = "",
                toRecipients: [String]? = nil,
                ccRecipients: [String]? = nil,
                bccRecipients: [String]? = nil,
                messageBody: String = "",
                isHtml: Bool = false,
                attachments: [AttachmentData]? = nil,
                preferredSendingAddress: String = "") {
        self._isShowing = isShowing
        
        self.result = result
        
        self.subject = subject
        
        self.toRecipients = toRecipients
        self.ccRecipients = ccRecipients
        self.bccRecipients = bccRecipients
        
        self.messageBody = messageBody
        self.isHtml = isHtml
        
        self.attachments = attachments
        
        self.preferredSendingAddress = preferredSendingAddress
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(isShowing: self.$isShowing,
                    result: self.result)
    }
    
    // MARK: make view controller
    public func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let viewController = MFMailComposeViewController()
        viewController.mailComposeDelegate = context.coordinator
        
        viewController.setSubject(self.subject)
        
        viewController.setToRecipients(self.toRecipients)
        viewController.setCcRecipients(self.ccRecipients)
        viewController.setBccRecipients(self.bccRecipients)
        
        viewController.setMessageBody(self.messageBody,
                                      isHTML: self.isHtml)
        
        viewController.setPreferredSendingEmailAddress(self.preferredSendingAddress)
        
        for attachment in self.attachments ?? [] {
            viewController.addAttachmentData(attachment.0,
                                             mimeType: attachment.1,
                                             fileName: attachment.2)
        }
        return viewController
    }
    
    // MARK: update view controller
    public func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {
        // nothing to do here.
    }
    
    // MARK: coordinator
    public class Coordinator: NSObject {
        
        @Binding var isShowing: Bool
        var result: ((Result<MailViewResult, Error>) -> Void)?
        
        init(isShowing: Binding<Bool>,
             result: ((Result<MailViewResult, Error>) -> Void)? = nil) {
            self._isShowing = isShowing
            self.result = result
        }
        
    }
    
}

// MARK: coordinator extension
extension MailView.Coordinator: MFMailComposeViewControllerDelegate {
    
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        defer {
            self.isShowing = false
        }
        
        guard let error = error else {
            self.result?(.success(result))
            return
        }
        self.result?(.failure(error))
    }
    
}

// MARK: canSendMail extension
public extension MailView {
    
    static var canSendMail: Bool {
        MFMailComposeViewController.canSendMail()
    }
    
}

// MARK: safe mail view extension
public extension MailView {
    
    func safe() -> some View {
        
        Group {
            if MailView.canSendMail {
                self
            } else {
                // TODO open mailto link
                Text("not safe!")
            }
        }
        
    }
    
}
