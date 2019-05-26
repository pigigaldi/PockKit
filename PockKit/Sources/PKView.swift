//
//  PKView.swift
//  PockKit
//
//  Created by Pierluigi Galdi on 17/02/2019.
//  Copyright © 2019 Pierluigi Galdi. All rights reserved.
//

import Foundation

/// `PKView` is a tappable `NSView` subclass.
/// You can override the given methods to create action in response to a user action, like a tap or a swipe.
open class PKView: NSView {
    
    /// Core
    private var initialPosition: NSPoint?
    
    /// The completion to be executed on tap
    open func didTapHandler()        { /***/ }
    
    /// The completion to be executed on left swipe
    open func didSwipeLeftHandler()  { /***/ }
    
    /// The completion to be executed on right swipe
    open func didSwipeRightHandler() { /***/ }
    
    /// Override
    override open func touchesBegan(with event: NSEvent) {
        /// Touches began
        super.touchesBegan(with: event)
        /// Get touch
        guard let touch = event.allTouches().first else { return }
        /// Get touch location
        let location = touch.location(in: self.superview)
        /// Check if location is in self
        if self.frame.contains(location) {
            self.initialPosition = location
        }
    }
    
    /// Override
    override open func touchesEnded(with event: NSEvent) {
        /// Touches ended
        super.touchesEnded(with: event)
        /// Get touch
        guard let touch = event.allTouches().first else { return }
        /// Get touch location
        let location = touch.location(in: self.superview)
        /// Check if location is in self
        if self.frame.contains(location) {
            /// Check
            if location.x < initialPosition?.x ?? location.x {
                didSwipeLeftHandler()
            }else if location.x > initialPosition?.x ?? location.x {
                didSwipeRightHandler()
            }else {
                didTapHandler()
            }
        }
    }
}
