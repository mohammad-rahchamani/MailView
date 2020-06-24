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

struct MailView: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let viewController = MFMailComposeViewController()
        //
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {
        
    }
    
}
