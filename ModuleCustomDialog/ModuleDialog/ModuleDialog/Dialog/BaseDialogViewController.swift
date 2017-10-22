//
//  BaseDialogViewController.swift
//  ModuleDialog
//
//  Created by Datoutwo on 22/10/2017.
//  Copyright © 2017 Datoutwo. All rights reserved.
//

import UIKit


public enum BaseDialog_Alpha : Int {
    case clear = 0, notClear = 1
}

public class BaseDialogViewController: UIViewController {

    var m_parentVC_Base = UIViewController()
    //MARK: Life Cycle
    override public func viewDidLoad() {
        super.viewDidLoad()
        if view is UIControl {
            let controlView = view as! UIControl
            controlView.addTarget(self, action: #selector(puiOnBackGroundClick), for:.touchUpInside)
        }
    }

    //MARK: func
    public func showDialog( parentVC : UIViewController ){
        m_parentVC_Base = parentVC
        if #available(iOS 8.0, *){
            modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            m_parentVC_Base.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            m_parentVC_Base.present(self, animated: false, completion: nil)
        }
        else{
            view.frame = UIScreen.main.bounds
            let frontToBackWindows = UIApplication.shared.windows.reversed()
            for window in frontToBackWindows {
                if window.screen == UIScreen.main
                    && !window.isHidden
                    && window.alpha > 0
                    && window.windowLevel == UIWindowLevelNormal{
                    window.addSubview(self.view)
                    break
                }
            }
        }
        setAlphaStyle(alphaStyle: .clear)
    }

    public func dismissDialog() {
        if #available(iOS 8.0, *){
            dismiss(animated: false, completion: nil)
        }
        else{
            view.removeFromSuperview()
        }
        m_parentVC_Base.view.alpha = 1.0
    }

    public func setAlphaStyle(alphaStyle: BaseDialog_Alpha){
        if alphaStyle == .clear {
            view.backgroundColor = UIColor.black.withAlphaComponent(0)
            view.isOpaque = false
        }
        else{
            view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            view.isOpaque = false
        }
    }


    @objc func puiOnBackGroundClick(){

    }
}

