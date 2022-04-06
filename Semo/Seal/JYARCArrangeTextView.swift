//
//  JYARCArrangeTextView.swift
//  Semo
//
//  Created by jiyang on 2022/3/12.
//

import Foundation
import UIKit

class JYARCArrangeTextView: UIView {
    @objc var color:UIColor = UIColor.init(red: 180/255.0, green: 40/255.0, blue: 40/255.0, alpha: 1.0)
    @objc var text:String = "Seven Mood"
    var textLength:Int = 0 // 文字长度
    var viewWidth:CGFloat = 0 // view宽度
    var viewHeight:CGFloat = 0 // view高度
    var arcRadius:CGFloat = 0 // 圆半径
    var textHeight:CGFloat = 20 // 文字高度
    var totalRadian:CGFloat = 0 // 总弧度
    var eachRadian:CGFloat = 0 // 每个夹角弧度
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textHeight = frame.height / 12
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateConfig() {
        viewWidth = self.frame.size.width - textHeight * 2
        viewHeight = self.frame.size.height - textHeight
        arcRadius = viewHeight / 2 + viewWidth * viewWidth / 8 / viewHeight // 根据垂径定理得到
        textLength = text.isEmpty ? 1 : text.count
        if (textLength > 17) {
            eachRadian = 0.13 // 0.85 // 此处是弧度值 ，可以任意一个角度，0.1弧度约为5.7度
            totalRadian = eachRadian * (CGFloat(textLength) - 1)
        } else {
            totalRadian =  asin(viewWidth / 2 / arcRadius) * 2 * 4 / 5
            eachRadian = totalRadian / (CGFloat(textLength) - 1)
        }
    }
    
   @objc public func drawText() {
       
       updateConfig()
        // 先移除之前创建的
        self.subviews.forEach { (subview) in
            subview.removeFromSuperview()
        }

        let startAngle:CGFloat = -CGFloat.pi / 2 - totalRadian / 2 // 起始角度，从左到右，取第一个字符的位置为起始角度

        for i in 0..<textLength {
            let angle = startAngle + eachRadian * CGFloat(i)
            let x:CGFloat = arcRadius * cos(angle)
            let y:CGFloat = arcRadius * sin(angle)
            let center = CGPoint(x: frame.size.width / 2 + x, y: arcRadius + textHeight + y) // 各个label中点坐标
            
            if text.isEmpty {return}
            let textLayer = CATextLayer()
            textLayer.bounds = CGRect(x: 0, y: 0, width: frame.width / 8, height: frame.height / 8)
            let character:Character = text[text.index(text.startIndex, offsetBy: i)]
            textLayer.string = String(character)
            textLayer.foregroundColor = color.cgColor;
            textLayer.font = UIFont.boldSystemFont(ofSize: frame.height / 8)
            textLayer.fontSize = frame.height / 8
            textLayer.alignmentMode = .center
            textLayer.contentsScale = UIScreen.main.scale
            textLayer.position = center
            self.layer.addSublayer(textLayer)

            // 旋转
            let alpha = angle + CGFloat.pi / 2
            let trans = CATransform3DIdentity
            textLayer.transform = CATransform3DRotate(trans, alpha, 0, 0, 1)
        }
    }
}
