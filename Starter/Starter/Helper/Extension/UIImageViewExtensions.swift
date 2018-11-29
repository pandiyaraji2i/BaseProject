//
//  UIImageViewExtensions.swift
//  Ideas2itStarter
//
//  Created by Pandiyaraj on 11/09/17.
//  Copyright © 2017 Pandiyaraj. All rights reserved.
//

import UIKit

extension UIImageView {
	/// Download image from url and set it in imageView with an optional completionHandler.
	public func download(from: URL?,
	                     contentMode: UIViewContentMode = .scaleAspectFit,
	                     placeHolder: UIImage? = nil,
	                     completionHandler: ((UIImage?, Error?) -> Void)? = nil) {
		
		image = placeHolder
		
		guard let url = from else {
			return
		}
		
		self.contentMode = contentMode
		
		
		URLSession.shared.dataTask(with: url) { (data, response, error) in
			guard
				let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
				let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
				let data = data, error == nil,
				let image = UIImage(data: data)
				else {
					completionHandler?(nil, error)
					return
			}
			DispatchQueue.main.async() { () -> Void in
				self.image = image
				completionHandler?(image, nil)
			}
			}.resume()
	}
	
	/// Make image view blurry
	func blur(withStyle: UIBlurEffectStyle = .light) {
		let blurEffect = UIBlurEffect(style: withStyle)
		let blurEffectView = UIVisualEffectView(effect: blurEffect)
		blurEffectView.frame = self.bounds
		blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
		self.addSubview(blurEffectView)
		self.clipsToBounds = true
	}
	
	/// Return a blurred version of an image view
	func blurred(withStyle: UIBlurEffectStyle = .light) -> UIImageView {
		return self.blurred(withStyle: withStyle)
	}
        
    func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}
extension UIImage {
    
    func maskWithColor(color : UIColor) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()!
        
        color.setFill()
        
        context.translateBy(x: 0, y: self.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        
        let rect = CGRect(x: 0.0, y: 0.0, width: self.size.width, height: self.size.height)
        context.draw(self.cgImage!, in: rect)
        
        context.setBlendMode(CGBlendMode.sourceIn)
        context.addRect(rect)
        context.drawPath(using: CGPathDrawingMode.fill)
        
        let coloredImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return coloredImage!
    }
    
    
    /// Compress uiimage and return data
    ///
    /// - Parameter maxSize: expected size of the image data in mb
    /// - Returns: compressed image data
    func compressImgage(expectedSize: Int) -> Data? {
        let sizeInBytes = expectedSize * 1024 * 1024
        var needCompress:Bool = true
        var imgData:Data?
        var compressingValue:CGFloat = 1.0
        while (needCompress && compressingValue > 0.0) {
            if let data:Data = UIImageJPEGRepresentation(self, compressingValue) {
                if data.count < sizeInBytes {
                    needCompress = false
                    imgData = data
                } else {
                    compressingValue -= 0.1
                }
            }
        }
        
        if let data = imgData {
            //            if (data.count < sizeInBytes) {
            return data
            //            }
        }
        return nil
    }
    
}
