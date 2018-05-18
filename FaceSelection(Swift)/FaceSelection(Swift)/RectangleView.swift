//
//  RectangleView.swift
//  FaceSelection(Swift)
//
//  Created by M. on 5/18/18.
//

import UIKit

class RectangleView: UIView {

    var isPressed = false
    
    override func draw(_ rect: CGRect) {
        SquareStyleKit3.drawCanvas1(pressed: isPressed)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isPressed = true
        self.setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isPressed = false
        self.setNeedsDisplay()
    }

}
