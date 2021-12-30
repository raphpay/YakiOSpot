//
//  PushNotificationSender.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 24/12/2021.
//

import Foundation

class PushNotificationSender: NSObject {
    static let shared = PushNotificationSender()
}

extension PushNotificationSender {
    func sendPresenceNotification(to token: String, from pseudo: String) {
        let urlString = SecureKeys.googleSendURL
        let url = NSURL(string: urlString)!
        let notificationBody: [String : Any] = ["to" : token,
                                           "notification" : ["title" : "Une personne vient d'arriver au spot !", "body" : "\(pseudo) est là"],
                                           "data" : ["user" : "test_id"]]
        
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: notificationBody, options: [.prettyPrinted])
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("key=\(SecureKeys.notificationServerKey)", forHTTPHeaderField: "Authorization")
        
        let task =  URLSession.shared.dataTask(with: request as URLRequest)  { (data, response, error) in
            guard error == nil else {
                print("======= \n error sending notification : \(error!.localizedDescription) \n=====")
                return
            }
            guard let data = data else {
                print("======= \n no data \n=====")
                return
            }
            guard response != nil else {
                print("===== \n no response \n=====")
                return
            }
    
            do {
                if let jsonDataDict  = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject] {
                    NSLog("Received data:\n\(jsonDataDict))")
                }
            } catch let err as NSError {
                print(err.debugDescription)
            }
        }
        task.resume()
    }
}
