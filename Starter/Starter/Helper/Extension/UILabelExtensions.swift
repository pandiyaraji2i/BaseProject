//
//  UILabelExtensions.swift
//  Ideas2itStarter
//
//  Created by Pandiyaraj on 11/09/17.
//  Copyright © 2017 Pandiyaraj. All rights reserved.
//

import UIKit

public extension UILabel {
	
	/// Return required height for a label
	public var requiredHeight: CGFloat {
		let label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: CGFloat.greatestFiniteMagnitude))
		label.numberOfLines = 0
		label.lineBreakMode = NSLineBreakMode.byWordWrapping
		label.font = font
		label.text = text
		label.attributedText = attributedText
		label.sizeToFit()
		return label.frame.height
	}
}


extension UIButton {
    /// Return required height for a label
    public var requiredwidth: CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = titleLabel?.font
        label.text = titleLabel?.text
        label.sizeToFit()
        return label.frame.width+15
    }
    
}
