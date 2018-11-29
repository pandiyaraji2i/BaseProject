//
//  NetworkUtilities.swift
//  SampleApp_Swift_iOS
//
//  Created by Pandiyaraj on 13/10/16.
//  Copyright © 2016 Pandiyaraj. All rights reserved.
//
//
//  Have to implement Reachability
//
//
import UIKit

extension URLSession
{
    /// Return data from synchronous URL request
    public func requestSynchronousData(request: URLRequest) -> (NSData?, URLResponse?) {
        var data: NSData?, response: URLResponse?
        
        let semaphore = DispatchSemaphore(value: 0)
        
        
        let task = self.dataTask(with: request as URLRequest) { (taskData, taskResponse, taskError) in
            data = taskData as NSData?
            response = taskResponse
            if data == nil, let taskError = taskError {print(taskError)}
            semaphore.signal()
        }
        task.resume()
        semaphore.wait()
        
        return (data, response)
    }
}

public class NetworkUtilities {


    /**
     create session
     
     - parameter contentType: either JSON OR URLENCODED
     
     - returns: URLSession
     */
    static func getSessionWithContentType(contentType : String) -> URLSession {
        let sessoinConfiguration = URLSessionConfiguration.default
        sessoinConfiguration.httpAdditionalHeaders = ["Content-Type":contentType]
        let session : URLSession  = URLSession.shared
        return session
    }
    
    
    
    /**
     Create mutable url request to send the server
     
     - parameter actionName:  which action to be performed login
     - parameter httpMethod:  either POST OR GET OR PUT OR DELETE
     - parameter requestBody: parameters
     - parameter contentType: either JSON OR URLENCODED
     
     - returns: URLRequest
     */
    static func getUrlRequest(actionName:String , httpMethod : String, requestBody: AnyObject?,contentType : String) -> URLRequest {
        
        var urlString : String = actionName
        urlString = "\(URLConstants.BASEURL)\(actionName)"
        print("Current Url -->*******\(urlString) *****")
        
        let urlStr : String = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let requestUrl = URL(string: urlStr as String)
        var request  = URLRequest(url: requestUrl!)
        request.httpMethod = httpMethod
        request.timeoutInterval = 120
    
        if requestBody != nil {
            
            var jsonData = Data()
            if contentType == CommonValues.jsonApplication{
                do {
                    jsonData = try JSONSerialization.data(withJSONObject: requestBody!, options: .prettyPrinted)
                    // here "jsonData" is the dictionary encoded in JSON data
                    
                    //#-- For checking given format is json or not
//                    let jsonString = NSString.init(data: jsonData, encoding: String.Encoding.utf8.rawValue)
//                    print(jsonString as Any);
                    
                    request.httpBody =  jsonData
                    let postLength = String(jsonData.count)
                    request.setValue(contentType, forHTTPHeaderField: "Content-type")
                    request.setValue(postLength, forHTTPHeaderField: "Content-Length")
                    request.setValue("application/json", forHTTPHeaderField: "Accept")
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
            if contentType == CommonValues.urlencoded {
                if requestBody != nil {
                    jsonData = (requestBody as! String).data(using: .utf8)!
                }
                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                request.setValue("application/json", forHTTPHeaderField: "Accept")
                request.httpBody = jsonData
            }
            
            //TODO: Set authorization based on auth (eg: Bearer \(auth) or auth)
            request.setValue(nil, forHTTPHeaderField: "Authorization")        }
        else{
            
        }
        return request
        
    }
    
    /**
     Synchronous request
     
     - parameter actionName:  action Name like Login
     - parameter httpMethod:  http methid like Get or Post
     - parameter requestBody: parameters with json format
     - parameter contentType: content type - json or urlencoded
     
     - returns: Object if success or error
     */
    static public func sendSynchronousRequestToServer(actionName : String,httpMethod : String, requestBody :AnyObject?, contentType : String ) -> AnyObject?{
        let request = self.getUrlRequest(actionName: actionName, httpMethod: httpMethod, requestBody: requestBody, contentType: contentType)
        let responseObject = self.getSessionWithContentType(contentType: contentType).requestSynchronousData(request: request)
        return self.getResponseData(responseData: responseObject.0, response: responseObject.1)
    }
    
    
    /**
     Asynchronous request
     
     - parameter actionName:        action Name like Login
     - parameter httpMethod:        http methid like Get or Post
     - parameter requestBody:       parameters with json format
     - parameter contentType:       ontent type - json or urlencoded
     - parameter completionHandler: completiontype Called after request was finished or failed
     */
    static public func sendAsynchronousRequestToServer(actionName:String, httpMethod:String, requestBody:AnyObject?, contentType:String, completionHandler: @escaping ((_ obj: AnyObject)->())){
        print(actionName)
        let request = self.getUrlRequest(actionName: actionName, httpMethod: httpMethod, requestBody: requestBody, contentType: contentType)
        let  postDataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            completionHandler(self.getResponseData(responseData: data as NSData?, response: response)!)
        };
        postDataTask.resume()
    }
   
    static public func hasConnectivity() -> Bool {
        let reachability  = Reachability()!
        do {
            try reachability.startNotifier()
        } catch {
            
        }
        return reachability.isReachable
    }
    
    
    
    static public func uploadImageToServer(actionName:String, httpMethod:String,parameters: [String:Any]? ,image:UIImage, contentType:String, completionHandler: @escaping ((_ obj: AnyObject)->())){
        
            let body = NSMutableData();
            let boundary = "Boundary---------------------------Identifier)"
            if parameters != nil {
                for (key, value) in parameters! {
                    body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                    body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                    body.append("\(value)\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                }
            }
        
            if let imageData = image.compressImgage(expectedSize: 1) {
                if imageData.count > 0 {
                    let filename = "Img-\((Date().timeIntervalSince1970).rounded()).jpg"
                    let mimetype = "image/jpg"
                    let filePathKey = "file"
                    
                    body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                    body.append("Content-Disposition: form-data; name=\"\(filePathKey)\"; filename=\"\(filename)\"\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                    body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                    body.append(imageData)
                    body.append("\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                    body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                }
            }
        
            var request = URLRequest(url: URL(string: actionName)!)
            request.httpMethod = httpMethod
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        //TODO: Set authorization based on auth (eg: Bearer \(auth) or auth)
            request.setValue(nil, forHTTPHeaderField: "Authorization")
            request.httpBody = body as Data
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if data == nil{
                   // UIApplication.shared.stopNetworkActivity()
                    completionHandler("error" as AnyObject)
                    return
                }
                guard let dataString =  try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject] else{
                   // UIApplication.shared.stopNetworkActivity()
                    completionHandler(AnyObject.self as AnyObject)
                    return
                }
                //print(dataString)
                completionHandler(self.getResponseData(responseData: data as NSData?, response: response)!)
            }
            task.resume()
        
        }
    
    static func getResponseData(responseData : NSData? , response: URLResponse?) -> AnyObject? {
        guard response != nil else{
            return "Your device is having poor or no connection to connect the server. Please check or reset your connection." as AnyObject?;
        }
        let httpResponse = response as? HTTPURLResponse
        let statusCode = httpResponse?.statusCode
        let allHeaderFields : NSDictionary = (httpResponse?.allHeaderFields)! as NSDictionary
        let contentType = allHeaderFields.value(forKey: "Content-Type") as? String
        
        //#-- Response is success
        if statusCode == 200 {
            //#-- Check respose is either JSON or XML or TEXT
            if (httpResponse?.url?.relativePath.contains("subscription"))!{
                let responseStr  = NSString.init(data:responseData! as Data, encoding: String.Encoding.utf8.rawValue)
                return responseStr as! AnyObject
            }
            
            if (contentType!.range(of:"application/json") != nil ) {
                //#--  JSON
                var jsonResponse: AnyObject?
                do {
                    jsonResponse = try JSONSerialization.jsonObject(with: responseData! as Data, options: JSONSerialization.ReadingOptions()) as AnyObject
                } catch let jsonError {
                    print(jsonError)
                }
                return jsonResponse
            }
            else if (contentType!.range(of:"text/json") != nil){
                let responseStr  = NSString.init(data:responseData! as Data, encoding: String.Encoding.utf8.rawValue)
                
                if let responseData1 = responseStr?.data(using: String.Encoding.utf8.rawValue) {
                    do {
                        let value = try? JSONSerialization.jsonObject(with: responseData1, options: [])
                        return value as AnyObject?
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            else {
                //#-- Do part other values
                let responseStr  = NSString.init(data:responseData! as Data, encoding: String.Encoding.utf8.rawValue)
                if (responseStr != nil)  {
                    return responseStr
                }
            }
            
        }  else if statusCode == 204 {
            return "success" as AnyObject?
        } else {
            //#-- Response is failure case
            //#-- Response is failure case
            var jsonResponse : AnyObject?
            do {
                jsonResponse = try JSONSerialization.jsonObject(with: responseData! as Data, options: JSONSerialization.ReadingOptions()) as AnyObject
            } catch let jsonError {
                print(jsonError)
            }
            
            if jsonResponse as? NSDictionary != nil
            {
                let response = jsonResponse as! NSDictionary
                if  response.value(forKey: "error") as? NSDictionary != nil {
                    let errorDict = response.value(forKey: "error") as! NSDictionary
                    return errorDict.value(forKey: "message") as AnyObject
                }else{
                    return response.value(forKey:"message") as AnyObject
                }
            }else{
                return "Error while send request" as AnyObject?
            }
        }
        return "Error while send request" as AnyObject?
    }
}



