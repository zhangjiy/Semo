//
//  JYCircleMenuView.swift
//  Semo
//
//  Created by jiyang on 2022/6/22.
//

import Foundation
import CircleMenu

@objc public protocol JYCircleMenuViewDelegate {

    @objc optional func circleMenuView(_ circleMenu: JYCircleMenuView, willDisplay button: UIButton, atIndex: Int)

    @objc optional func circleMenuView(_ circleMenu: JYCircleMenuView, buttonWillSelected button: UIButton, atIndex: Int)

    @objc optional func circleMenuView(_ circleMenu: JYCircleMenuView, buttonDidSelected button: UIButton, atIndex: Int)

    @objc optional func circleMenuViewCollapsed(_ circleMenu: JYCircleMenuView)

    @objc optional func circleMenuViewOpened(_ circleMenu: JYCircleMenuView)
}

open class JYCircleMenuView: UIView, CircleMenuDelegate {
    @IBOutlet open weak var delegate: AnyObject?
    let items: [(icon: String, color: UIColor)] = [
        ("icon_home", UIColor(red: 0.19, green: 0.57, blue: 1, alpha: 1)),
        ("icon_search", UIColor(red: 0.22, green: 0.74, blue: 0, alpha: 1)),
        ("notifications-btn", UIColor(red: 0.96, green: 0.23, blue: 0.21, alpha: 1)),
        ("settings-btn", UIColor(red: 0.51, green: 0.15, blue: 1, alpha: 1)),
        ("nearby-btn", UIColor(red: 1, green: 0.39, blue: 0, alpha: 1)),
        ("icon_home", UIColor(red: 0.19, green: 0.57, blue: 1, alpha: 1)),
        ("icon_search", UIColor(red: 0.22, green: 0.74, blue: 0, alpha: 1))
    ]
    var menuButton: CircleMenu!
    var visualEffectView: UIVisualEffectView!
    var isShow: Bool = false
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConfig()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
    }

    private func setupConfig() {
        self.alpha = 0;
    }
    
    private func setupView() {
        
        let blurEffect = UIBlurEffect.init(style: .light);
        visualEffectView = UIVisualEffectView.init(effect: blurEffect)
        visualEffectView.frame = bounds
        addSubview(visualEffectView);
        
        menuButton = CircleMenu(
            frame: CGRect(x: (bounds.width - 50) / 2, y: (bounds.height - 50) / 2, width: 50, height: 50),
          normalIcon:"icon_menu",
          selectedIcon:"icon_close",
          buttonsCount: 7,
          duration: 4,
          distance: 120)
        menuButton.delegate = self
        //button.layer.cornerRadius = button.frame.size.width / 2.0
        menuButton.backgroundColor = UIColor.red
        addSubview(menuButton)
    }
    
    @objc public func onTap() {
        
        isShow = !isShow
        let duration = isShow ? 0.2 : 0.2
        let alp:CGFloat = isShow ? 1 : 0
        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: UIView.AnimationOptions.curveEaseIn,
            animations: { () -> Void in
                self.alpha = alp
            }, completion: { (_) -> Void in
        })
        menuButton.onTap()
    }
    
    public func circleMenu(_ circleMenu: CircleMenu, willDisplay button: UIButton, atIndex: Int) {
        button.backgroundColor = items[atIndex].color

        button.setImage(UIImage(named: items[atIndex].icon), for: .normal)

        // set highlited image
        let highlightedImage = UIImage(named: items[atIndex].icon)?.withRenderingMode(.alwaysTemplate)
        button.setImage(highlightedImage, for: .highlighted)
        button.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        delegate?.circleMenuView?(self, willDisplay: button, atIndex: atIndex)
    }

    public func circleMenu(_ circleMenu: CircleMenu, buttonWillSelected button: UIButton, atIndex: Int) {
        delegate?.circleMenuView?(self, buttonWillSelected: button, atIndex: atIndex)
    }

    public func circleMenu(_ circleMenu: CircleMenu, buttonDidSelected button: UIButton, atIndex: Int) {
        delegate?.circleMenuView?(self, buttonDidSelected: button, atIndex: atIndex)
    }
    
    public func menuCollapsed(_ circleMenu: CircleMenu) {
        delegate?.circleMenuViewCollapsed?(self)
    }

    public func menuOpened(_ circleMenu: CircleMenu) {
        delegate?.circleMenuViewOpened?(self)
    }
}
