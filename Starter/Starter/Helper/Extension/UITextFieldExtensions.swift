//
//  UITextFieldExtensions.swift
//  Ideas2itStarter
//
//  Created by Pandiyaraj on 11/09/17.
//  Copyright © 2017 Pandiyaraj. All rights reserved.
//

import UIKit
public extension UITextField {
    
    /// Return true if text field is empty.
    public var isEmpty: Bool {
        if let text = self.text {
            return text.characters.isEmpty
        }
        return true
    }
    
    /// Return text with no spaces or new lines in beginning and end.
    var trimmedText: String? {
        return text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    /// shakes the textfield
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
    
    func setLeftPadding() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 20))
        self.leftView = view
        self.leftViewMode = .always
    }
    
    /// Set place holder text color
    public func setPlaceHolderTextColor(_ color: UIColor) {
        self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedStringKey.foregroundColor: color])
    }
    
    /// Left view tint color
    @IBInspectable
    var leftViewTintColor: UIColor? {
        get {
            guard let iconView = self.leftView as? UIImageView else {
                return nil
            }
            return iconView.tintColor
        }
        set {
            guard let iconView = self.leftView as? UIImageView else {
                return
            }
            iconView.image = iconView.image?.withRenderingMode(.alwaysTemplate)
            iconView.tintColor = newValue
        }
    }
    
    /// Right view tint color
    @IBInspectable
    var rightViewTintColor: UIColor? {
        get {
            guard let iconView = self.rightView as? UIImageView else {
                return nil
            }
            return iconView.tintColor
        }
        set {
            guard let iconView = self.rightView as? UIImageView else {
                return
            }
            iconView.image = iconView.image?.withRenderingMode(.alwaysTemplate)
            iconView.tintColor = newValue
        }
    }
    
    
    @IBInspectable
    var leftViewImage: UIImage {
        get {
            return self.leftViewImage
        }
        set {
            let imageView = UIImageView()
            imageView.image = newValue
            imageView.frame = CGRect(x: 0, y: 0, width: self.frame.height, height: self.frame.height)
            self.leftView = imageView
            self.leftViewMode = UITextFieldViewMode.always
        }
    }
    
    @IBInspectable
    var rightViewImage: UIImage {
        get {
            return self.rightViewImage
        }
        set {
            let imageView = UIImageView()
            imageView.image = newValue
            imageView.frame = CGRect(x: 0, y: 0, width: self.frame.height, height: self.frame.height)
            self.rightView = imageView
            self.rightViewMode = UITextFieldViewMode.always
        }
    }
    
}
