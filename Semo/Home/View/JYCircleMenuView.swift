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
    let items: [(title: String, color: UIColor)] = [
        (NSLocalizedString("喜", comment: ""), UIColor(red: 218/255, green: 88/255, blue: 78/255, alpha: 1)),
        (NSLocalizedString("怒", comment: ""), UIColor(red: 230/255, green: 206/255, blue: 78/255, alpha: 1)),
        (NSLocalizedString("忧", comment: ""), UIColor(red: 241/255, green: 206/255, blue: 97/255, alpha: 1)),
        (NSLocalizedString("思", comment: ""), UIColor(red: 121/255, green: 193/255, blue: 114/255, alpha: 1)),
        (NSLocalizedString("悲", comment: ""), UIColor(red: 64/255, green: 122/255, blue: 235/255, alpha: 1)),
        (NSLocalizedString("恐", comment: ""), UIColor(red: 173/255, green: 127/255, blue: 207/255, alpha: 1)),
        (NSLocalizedString("惊", comment: ""), UIColor(red: 149/255, green: 134/255, blue: 108/255, alpha: 1))
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
        let distance:Float = Float((self.bounds.width - 60) / 2)
        menuButton = CircleMenu(
            frame: CGRect(x: (bounds.width - 54) / 2, y: (bounds.height - 54) / 2, width: 54, height: 54),
          normalIcon:"",
          selectedIcon:"story_publish_icon_close",
          buttonsCount: 7,
            duration: 0.5,
          distance: distance)
        menuButton.delegate = self
        menuButton.layer.cornerRadius = menuButton.frame.size.width / 2.0
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
        button.setTitle(items[atIndex].title, for: .normal)
        button.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        delegate?.circleMenuView?(self, willDisplay: button, atIndex: atIndex)
    }

    public func circleMenu(_ circleMenu: CircleMenu, buttonWillSelected button: UIButton, atIndex: Int) {
        delegate?.circleMenuView?(self, buttonWillSelected: button, atIndex: atIndex)
    }

    public func circleMenu(_ circleMenu: CircleMenu, buttonDidSelected button: UIButton, atIndex: Int) {
        delegate?.circleMenuView?(self, buttonDidSelected: button, atIndex: atIndex)
    }
    
    public func menuCollapsed(_ circleMenu: CircleMenu) {
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: UIView.AnimationOptions.curveEaseIn,
            animations: { () -> Void in
                self.alpha = 0
            }, completion: { (_) -> Void in
                self.removeFromSuperview()
        })
        delegate?.circleMenuViewCollapsed?(self)
    }

    public func menuOpened(_ circleMenu: CircleMenu) {
        delegate?.circleMenuViewOpened?(self)
    }
}
