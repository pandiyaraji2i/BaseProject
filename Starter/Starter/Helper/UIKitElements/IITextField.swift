//
//  IITextField.swift
//  Starter
//
//  Created by Mac on 11/29/18.
//  Copyright © 2018 Durai-Ideas2IT. All rights reserved.
//

import UIKit

class IITextField: UITextField {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        self.setupOptimumFontSize()
        self.createBorder()
    }
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        self.setupOptimumHeight()
        self.setupOptimumFontSize()
        self.createBorder()
    }
    
    func setupOptimumFontSize() {
        if let font  = self.font {
            let size = font.pointSize
            if (DeviceType.IS_IPHONE_5 ) {
                self.font = UIFont(name: font.fontName, size: size * 0.8)
            } else if DeviceType.IS_IPHONE_6 {
                self.font = UIFont(name: font.fontName, size: size * 0.85)
            } else if DeviceType.IS_IPHONE_8P {
                self.font = UIFont(name: font.fontName, size: size * 0.95)
            }
        }
    }
    
    
    func setupOptimumHeight() {
        let height = self.height
        if (DeviceType.IS_IPHONE_5 ) {
            self.height = height * 0.8
        } else if DeviceType.IS_IPHONE_6 {
            self.height = height * 0.85
        } else if DeviceType.IS_IPHONE_8P {
            self.height = height * 0.95
        }
        self.layoutIfNeeded()
    }
    
    func createBorder() {
        self.setPlaceHolderTextColor(UIColor.init(hex: 0xababab))
        self.addBorder(edges: .bottom, colour: UIColor.init(hex: 0xdfdfdf), thickness: 1.0)
    }
    
}
