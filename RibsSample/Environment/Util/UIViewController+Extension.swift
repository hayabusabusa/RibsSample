//
//  UIViewController+Extension.swift
//  Holder
//
//  Created by Yamada Shunya on 2019/09/03.
//  Copyright © 2019 山田隼也. All rights reserved.
//

import UIKit

extension UIViewController {

    func replaceRoot(to nextViewController: UIViewController) {
        guard let window = UIApplication.shared.keyWindow else { return }

        if let presentedVC = window.rootViewController?.presentedViewController {
            print("[REPLACE ROOT] ⚠️ \(self) has presented \(presentedVC)")
        }

        UIView.transition(
            with: window,
            duration: 0.3,
            options: .transitionCrossDissolve,
            animations: { () -> Void in
                let oldState = UIView.areAnimationsEnabled
                UIView.setAnimationsEnabled(false)
                window.rootViewController = nextViewController
                UIView.setAnimationsEnabled(oldState)
            },
            completion: nil
        )
    }
}
