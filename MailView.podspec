Pod::Spec.new do |spec|

  spec.name             = "MailView"
  spec.version          = "1.1.0"
  spec.summary          = "SwiftUI Mail composer view."

  spec.description      = <<-DESC
   SwiftUI equivalent of MFMailComposeViewController
                   DESC

  spec.homepage         = "https://github.com/mohammad-rahchamani/MailView"

  spec.license          = { :type => "MIT", :file => "LICENSE" }

  spec.author           = { "Mohammad Rahchamani" => "mohammad.rahchamani@gmail.com" }
  
  spec.platform         = :ios, "13.0"
  
  spec.swift_version    = "5.5"

  spec.source           = { :git => "https://github.com/mohammad-rahchamani/MailView.git", :tag => "#{spec.version}" }

  spec.source_files     = "MailView/**/*.{swift}"

end
