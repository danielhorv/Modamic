//
//  UILabel+Extension.swift
//  ModamicPresenter
//
//  Created by Daniel Horvath on 29.03.20.
//  Copyright © 2020 Daniel Horvath. All rights reserved.
//

import UIKit

// For the automatically preferredMaxLayoutWidth calculation
extension UILabel {
    public override var bounds: CGRect {
        didSet {
            if bounds.size.width != oldValue.size.width {
                self.setNeedsUpdateConstraints()
            }
        }
    }

    public override func updateConstraints() {
        if preferredMaxLayoutWidth != bounds.size.width {
            preferredMaxLayoutWidth = bounds.size.width
        }

        super.updateConstraints()
    }
}
