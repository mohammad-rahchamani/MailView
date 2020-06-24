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
    
    public init() {
        
    }
    
    public func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let viewController = MFMailComposeViewController()
        //
        return viewController
    }
    
    public func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {
        
    }
    
}

// MARK: extension
extension MailView {
    
    public static var canSendMail: Bool {
        MFMailComposeViewController.canSendMail()
    }
    
}
