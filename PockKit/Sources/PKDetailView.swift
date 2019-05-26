//
//  PKDetailView.swift
//  PockKit
//
//  Created by Pierluigi Galdi on 26/05/2019.
//  Copyright © 2019 Pierluigi Galdi. All rights reserved.
//

import Foundation
import SnapKit

open class PKDetailView: PKView {
    
    /// Core
    public static       let kBounceAnimationKey: String = "kBounceAnimationKey"
    public private(set) var isAnimating:         Bool   = false
    public              var leftToRight:         Bool   = true {
        didSet {
            updateLayout()
        }
    }
    
    /// UI
    @IBOutlet public var imageView:    NSImageView!
    @IBOutlet public var titleView:    NSTextField!
    @IBOutlet public var subtitleView: NSTextField!
    
    public convenience init(frame: NSRect = .zero, leftToRight: Bool = true) {
        self.init(frame: frame)
        self.leftToRight = leftToRight
        
        imageView = NSImageView(frame: .zero)
        imageView.autoresizingMask = .height
        imageView.imageScaling = .scaleProportionallyDown
        
        titleView = NSTextField(labelWithString: "")
        titleView.autoresizingMask = .height
        titleView.alignment = .left
        titleView.font = NSFont.systemFont(ofSize: 9)
        
        subtitleView = NSTextField(labelWithString: "")
        subtitleView.autoresizingMask = .height
        subtitleView.alignment = .left
        subtitleView.font = NSFont.systemFont(ofSize: 9)
        subtitleView.textColor = NSColor(calibratedRed: 124/255, green: 131/255, blue: 127/255, alpha: 1)
        
        addSubview(imageView)
        addSubview(titleView)
        addSubview(subtitleView)
        
        updateLayout()
        didLoad()
    }
    
    /// Override this function to do your initial setup.
    open func didLoad() {
        /// do your implementation
    }
    
    /// Override this function to layout subviews as you prefer.
    /// SnapKit can help you in this.
    open func updateLayout() {
        if leftToRight {
            imageView.snp.makeConstraints({ maker in
                maker.width.equalTo(24)
                maker.top.bottom.equalTo(self)
                maker.left.equalTo(self)
            })
            titleView.sizeToFit()
            titleView.snp.makeConstraints({ maker in
                maker.height.equalTo(titleView.frame.height)
                maker.left.equalTo(imageView.snp.right).offset(4)
                maker.top.equalTo(imageView).inset(4)
                maker.right.equalTo(self).inset(4)
            })
            subtitleView.sizeToFit()
            subtitleView.snp.makeConstraints({ maker in
                maker.left.equalTo(titleView)
                maker.top.equalTo(titleView.snp.bottom)
                maker.right.equalTo(titleView)
                maker.bottom.equalTo(self)
            })
        }else {
            titleView.sizeToFit()
            titleView.snp.makeConstraints({ maker in
                maker.height.equalTo(titleView.frame.height)
                maker.left.equalTo(self)
                maker.top.equalTo(self).inset(4)
            })
            subtitleView.sizeToFit()
            subtitleView.snp.makeConstraints({ maker in
                maker.top.equalTo(titleView.snp.bottom)
                maker.left.equalTo(titleView)
                maker.bottom.equalTo(self).inset(4)
            })
            imageView.snp.makeConstraints({ maker in
                maker.width.equalTo(24)
                maker.top.bottom.equalTo(self)
                maker.right.equalTo(self)
                maker.left.equalTo((titleView.frame.width > subtitleView.frame.width ? titleView : subtitleView).snp.right).offset(4)
            })
        }
    }
    
    open func set(title: String?) {
        titleView?.stringValue = title ?? "Error"
        updateLayout()
    }
    
    open func set(subtitle: String?) {
        subtitleView?.stringValue = subtitle ?? "Missing location"
        updateLayout()
    }
    
    open func set(image: NSImage?) {
        imageView?.image = image
    }
    
}

extension PKDetailView {
    
    public func startBounceAnimation() {
        if !isAnimating {
            self.loadBounceAnimation()
        }
    }
    
    public func stopBounceAnimation() {
        self.imageView.layer?.removeAnimation(forKey: PKDetailView.kBounceAnimationKey)
        self.isAnimating = false
    }
    
    private func loadBounceAnimation() {
        isAnimating                   = true
        
        let bounce                   = CABasicAnimation(keyPath: "transform.scale")
        bounce.fromValue             = 0.86
        bounce.toValue               = 1
        bounce.duration              = 1.2
        bounce.autoreverses          = true
        bounce.repeatCount           = Float.infinity
        bounce.timingFunction        = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        let frame = self.imageView.layer?.frame
        self.imageView.layer?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.imageView.layer?.frame = frame ?? .zero
        self.imageView.layer?.add(bounce, forKey: PKDetailView.kBounceAnimationKey)
    }
    
}

