//
//  UIAlertControllerExtensions.swift
//  Ideas2itStarter
//
//  Created by Pandiyaraj on 11/09/17.
//  Copyright © 2017 Pandiyaraj. All rights reserved.
//

import UIKit
import AudioToolbox

public extension UIAlertController {
    
    public func show(title: String, contentText: String, actions: [UIAlertAction]) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: contentText, preferredStyle: .alert)
            for action in actions {
                alertController.addAction(action)
            }
            self.present(alertController, animated: true, completion: nil)
        }
    }
	
	/// Create new alert view controller with default OK action.
	public convenience init(title: String, message: String? = nil, defaultActionButtonTitle: String = "OK", tintColor: UIColor? = nil) {
		self.init(title: title, message: message, preferredStyle: .alert)
		let defaultAction = UIAlertAction(title: defaultActionButtonTitle, style: .default, handler: nil)
		self.addAction(defaultAction)
		if let color = tintColor {
			self.view.tintColor = color
		}
	}
    
    public convenience init(title: String, message: String? = nil, defaultActionButtonTitle: String = "OK", tintColor: UIColor? = nil, handler: ((UIAlertAction) -> Void)?) {
        self.init(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: defaultActionButtonTitle, style: .default, handler: handler)
        self.addAction(defaultAction)
        if let color = tintColor {
            self.view.tintColor = color
        }
    }
    
    
	
	/// Create new error alert view controller from Error with default OK action.
	public convenience init(title: String = "Error", error: Error, defaultActionButtonTitle: String = "OK", tintColor: UIColor? = nil) {
		self.init(title: title, message: error.localizedDescription, preferredStyle: .alert)
		let defaultAction = UIAlertAction(title: defaultActionButtonTitle, style: .default, handler: nil)
		self.addAction(defaultAction)
		if let color = tintColor {
			self.view.tintColor = color
		}
	}
    
    
    public convenience init(actionButtonTitle: String, message: String, handler: ((UIAlertAction) -> Void)?) {
        self.init(title: "", message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: actionButtonTitle, style: .default, handler: handler)
        self.addAction(defaultAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        self.addAction(cancelAction)
    }
	
    
    public convenience init(actionButtonTitleForOkAction: String, message: String, handler: ((UIAlertAction) -> Void)?) {
        self.init(title: "", message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: actionButtonTitleForOkAction, style: .default, handler: handler)
        self.addAction(defaultAction)

    }
    
    
    
	/// Present alert view controller in the current view controller.
	///
	/// - parameter vibrate: Set true to vibrate the device while presenting the alert
	public func show(vibrate: Bool = false) {
		UIApplication.shared.keyWindow?.rootViewController?.present(self, animated: true, completion: nil)
        if vibrate {
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
        }
	}
	
	/// Add an action to Alert
	///
	/// - Parameters:
	///   - title: action title
	///   - style: action style, default is UIAlertActionStyle.default
	///   - isEnabled: isEnabled status for action, default is: true
	///   - handler: optional action handler
	/// - Returns: action created by this method
	func addAction(title: String, style: UIAlertActionStyle = .default, isEnabled: Bool = true, handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertAction {
		let action = UIAlertAction(title: title, style: style, handler: handler)
		action.isEnabled = isEnabled
		self.addAction(action)
		return action
	}
	
	/// Add a text field to Alert
	///
	/// - Parameters:
	///   - text: text field text
	///   - placeholder: text field placeholder text
	///   - editingChangedTarget: an optional target for text field's editingChanged
	///   - editingChangedSelector: an optional selector for text field's editingChanged
	func addTextField(text: String? = nil, placeholder: String? = nil, editingChangedTarget: Any?, editingChangedSelector: Selector? = nil) {
		addTextField { tf in
			tf.text = text
			tf.placeholder = placeholder
			if let target = editingChangedTarget, let selector = editingChangedSelector {
				tf.addTarget(target, action: selector, for: .editingChanged)
			}
		}
	}
    

    
    
    
	
}
