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
    
    let resultHandler: ((Result<MailViewResult, Error>) -> Void)?
    
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
                resultHandler: ((Result<MailViewResult, Error>) -> Void)? = nil,
                subject: String = "",
                toRecipients: [String]? = nil,
                ccRecipients: [String]? = nil,
                bccRecipients: [String]? = nil,
                messageBody: String = "",
                isHtml: Bool = false,
                attachments: [AttachmentData]? = nil,
                preferredSendingAddress: String = "") {
        self._isShowing = isShowing
        
        self.resultHandler = resultHandler
        
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
                    resultHandler: self.resultHandler)
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
        
        let resultHandler: ((Result<MailViewResult, Error>) -> Void)?
        
        init(isShowing: Binding<Bool>,
             resultHandler: ((Result<MailViewResult, Error>) -> Void)? = nil) {
            self._isShowing = isShowing
            self.resultHandler = resultHandler
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
            self.resultHandler?(.success(result))
            return
        }
        self.resultHandler?(.failure(error))
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
        
        let joinedRecipients = self.toRecipients?.joined(separator: ",") ?? ""
        
        var nextSeparator = "?"
        
        var joinedCc = ""
        if self.ccRecipients != nil {
            joinedCc = "\(nextSeparator)cc=" + self.ccRecipients!.joined(separator: ",")
            nextSeparator = "&"
        }
        
        var joinedBcc = ""
        if self.bccRecipients != nil {
            joinedBcc = "\(nextSeparator)bcc=" + self.bccRecipients!.joined(separator: ",")
            nextSeparator = "&"
        }
        
        let formattedSubject = "\(nextSeparator)subject=" +
            (self.subject.stringByAddingPercentEncodingForRFC3986() ?? "")
        
        let formattedBody = "&body=" +
            (self.messageBody.stringByAddingPercentEncodingForRFC3986() ?? "")
        
        let mailtoUrl = URL(string: "mailto:\(joinedRecipients)\(joinedCc)\(joinedBcc)\(self.subject.count > 0 ?  formattedSubject : "")\(self.messageBody.count > 0 ? formattedBody : "")")
        
        if !MailView.canSendMail || true {
            DispatchQueue.main.async {
                // dismiss modal view
                self.isShowing = false
            }
            if let url = mailtoUrl  {
                UIApplication.shared.open(url,
                options: [:],
                completionHandler: {
                    result in
                    if result {
                        // we have no idea if it's been sent.
                        self.resultHandler?(.success(.sent))
                    } else {
                        self.resultHandler?(.failure(MailViewError.openFailed))
                    }
                })
            } else {
                self.resultHandler?(.failure(MailViewError.badUrl))
            }
        }
        
        if let url = mailtoUrl,
            true {
            UIApplication.shared.open(url,
                                      options: [:],
                                      completionHandler: { _ in})
        }
        
        return Group {
            if !MailView.canSendMail {
                self
            } else {
                EmptyView()
            }
        }
        
        
    }
    
}

// MARK: encode string
extension String {
    public func stringByAddingPercentEncodingForRFC3986() -> String? {
      let unreserved = "-._~/?"
      let allowedCharacterSet = NSMutableCharacterSet.alphanumeric()
      allowedCharacterSet.addCharacters(in: unreserved)
      return addingPercentEncoding(withAllowedCharacters: allowedCharacterSet as CharacterSet)
    }
}

// MARK: custom errors
public enum MailViewError: Error {
    case badUrl
    case openFailed
}
