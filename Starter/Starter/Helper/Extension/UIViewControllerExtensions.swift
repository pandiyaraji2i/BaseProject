//
//  UIViewControllerExtensions.swift
//  Ideas2itStarter
//
//  Created by Pandiyaraj on 11/09/17.
//  Copyright © 2017 Pandiyaraj. All rights reserved.
//

import UIKit

extension UIViewController {
	/// Assign as listener to notification.
    public func addNotificationObserver(name: Notification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: name, object: nil)
    }
	
//    /// Return true if ViewController is onscreen and not hidden.
    public var isVisible: Bool {
        // http://stackoverflow.com/questions/2777438/how-to-tell-if-uiviewcontrollers-view-is-visible
        return self.isViewLoaded && view.window != nil
    }
//
//    /// Return navigationBar in a ViewController.
//    public var navigationBar: UINavigationBar? {
//        return navigationController?.navigationBar
//    }
	
    /// Unassign as listener to notification.
    public func removeNotificationObserver(name: Notification.Name) {
        NotificationCenter.default.removeObserver(self, name: name, object: nil)
    }

    /// Unassign as listener from all notifications.
    public func removeNotificationsObserver() {
        NotificationCenter.default.removeObserver(self)
    }
 
    
    func showAlert(title: String, contentText: String, actions: [UIAlertAction]?) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: contentText, preferredStyle: .alert)
            
            if actions != nil{
                if let acctions = actions {
                    for action in acctions {
                        alertController.addAction(action)
                    }
                }
            }else{
                let okAlert : UIAlertAction = UIAlertAction.init(title: "Ok", style: .default, handler: nil)
                alertController.addAction(okAlert)
            }
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

extension UIResponder {
    func getParentViewController() -> UIViewController? {
        if self.next is UIViewController {
            return self.next as? UIViewController
        } else {
            if self.next != nil {
                return (self.next!).getParentViewController()
            }
            else {return nil}
        }
    }
}


extension UISplitViewController {
    
    /// Obtain the master/primary UIViewController.
    public var masterViewController: UIViewController {
        return viewControllers[0]
    }
    
    
    /// Obtain the detail/secondary UIViewController, if present.
    public var detailViewController: UIViewController? {
        guard viewControllers.count > 1 else { return nil }
        return viewControllers[1]
    }
    
}
