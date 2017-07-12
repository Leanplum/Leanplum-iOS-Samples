//
//  NotificationService.swift
//  richPushExtension
//
//  Created by Matthew Bell on 7/11/17.
//  Copyright © 2017 Leanplum. All rights reserved.
//

import UserNotifications

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        let imageKey = "LP_URL"
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        // MARK: - Leanplum Rich Push
        if let bestAttemptContent = bestAttemptContent {
            let userInfo = request.content.userInfo;
            
            // LP_URL is the key that is used from Leanplum to
            // send the image URL in the payload.
            //
            // If there is no LP_URL in the payload than
            // the code will still show the push notification.
            if userInfo[imageKey] == nil {
                contentHandler(bestAttemptContent);
                return;
            }
            
            // If there is an image in the payload,
            // download and display the image.
            if let attachmentMedia = userInfo[imageKey] as? String {
                let mediaUrl = URL(string: attachmentMedia)
                let LPSession = URLSession(configuration: .default)
                LPSession.downloadTask(with: mediaUrl!, completionHandler: { temporaryLocation, response, error in
                    if let err = error {
                        print("Leanplum: Error with downloading rich push: \(String(describing: err.localizedDescription))")
                        contentHandler(bestAttemptContent);
                        return;
                    }
                    
                    let fileType = self.determineType(fileType: (response?.mimeType)!)
                    let fileName = temporaryLocation?.lastPathComponent.appending(fileType)
                    
                    let temporaryDirectory = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName!)
                    
                    do {
                        try FileManager.default.moveItem(at: temporaryLocation!, to: temporaryDirectory)
                        let attachment = try UNNotificationAttachment(identifier: "", url: temporaryDirectory, options: nil)
                        
                        bestAttemptContent.attachments = [attachment];
                        contentHandler(bestAttemptContent);
                        // The file should be removed automatically from temp
                        // Delete it manually if it is not
                        if FileManager.default.fileExists(atPath: temporaryDirectory.path) {
                            try FileManager.default.removeItem(at: temporaryDirectory)
                        }
                    } catch {
                        print("Leanplum: Error with the rich push attachment: \(error)")
                        contentHandler(bestAttemptContent);
                        return;
                    }
                }).resume()
                
            }
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }
    
    // MARK: - Leanplum Rich Push
    func determineType(fileType: String) -> String {
        // Determines the file type of the attachment to append to URL.
        if fileType == "image/jpeg" {
            return ".jpg";
        }
        if fileType == "image/gif" {
            return ".gif";
        }
        if fileType == "image/png" {
            return ".png";
        } else {
            return ".tmp";
        }
    }

}
