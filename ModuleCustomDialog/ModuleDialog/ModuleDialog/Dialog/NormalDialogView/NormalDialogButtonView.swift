//
//  NormalDialogButtonView.swift
//  ModuleDialog
//
//  Created by Datoutwo on 22/10/2017.
//  Copyright © 2017 Datoutwo. All rights reserved.
//

import UIKit

protocol NormalDialogButtonViewDelegate {
    func normalDialogOnClickButtonWith(style: NormalDialogButtonStyle)
}

class NormalDialogButtonView: UIView {

    var dialogButtonViewDelegate: NormalDialogButtonViewDelegate?
    private var m_aryButtonRect = Array<CGRect>()
    private var m_aryMidLineRect = Array<CGRect>()

    func setButtonViewWith(aryButtonItem: Array<NormalDialogButtonItem>){
        let count = aryButtonItem.count
        if count >= 1 {
            createAllRectWith(buttonCount: count, andMidLineWidth: aryButtonItem[0].middleLineWidth)
            createAllButtonWith(aryButtonItem: aryButtonItem)
            createAllMidLineWith(buttonItem: aryButtonItem[0])
        }
        else{
            print("DialogButtonView create button error")
        }
    }

    private func createAllRectWith(buttonCount: Int, andMidLineWidth: Int){

        let buttonWidth = frame.width/CGFloat(buttonCount)
        var rectTmp : CGRect
        for indexInt in 1...buttonCount{
            rectTmp = CGRect( x:CGFloat(indexInt-1)*buttonWidth,
                              y:0,
                              width:buttonWidth,
                              height:frame.height )
            m_aryButtonRect.append(rectTmp)
            if( buttonCount > indexInt ){
                rectTmp = CGRect( x:CGFloat(indexInt-1)*buttonWidth - CGFloat(andMidLineWidth/2) ,
                                  y:0,
                                  width:CGFloat(andMidLineWidth/2),
                                  height:frame.height )
                m_aryMidLineRect.append(rectTmp)
            }
        }
    }

    private func createAllButtonWith(aryButtonItem: Array<NormalDialogButtonItem>){

        var rect : CGRect
        var buttonItem : NormalDialogButtonItem
        for indexInt in 0...aryButtonItem.count-1{
            let button = UIButton(type: .custom)
            rect = m_aryButtonRect[indexInt]
            buttonItem = aryButtonItem[indexInt]
            button.frame = rect
            button.setTitle(buttonItem.titleText, for: .normal)
            button.setTitleColor(buttonItem.titleColor, for: .normal)
            button.backgroundColor = buttonItem.backgroundColor
            button.titleLabel?.font = buttonItem.titleFont

            if true == buttonItem.buttonWithImage{
                button.setImage(buttonItem.buttonImage, for: .normal)
            }
            switch buttonItem.buttonStyle{
            case .confirm:
                button.addTarget(self, action: #selector(onClickConfirm), for: .touchUpInside)
            case .cancel:
                button.addTarget(self, action: #selector(onClickCancel), for: .touchUpInside)
            case .custom:
                button.addTarget(self, action: #selector(onClickCustom), for: .touchUpInside)
            }
            addSubview(button)
        }
    }

    private func createAllMidLineWith(buttonItem: NormalDialogButtonItem){

        for rect in m_aryMidLineRect{
            let view = UIView(frame:rect)
            view.backgroundColor = buttonItem.middleLineColor
            addSubview(view)
        }
    }

    //MARK: taget /action / delegate
    @objc func onClickConfirm(){
        if dialogButtonViewDelegate != nil {
            dialogButtonViewDelegate!.normalDialogOnClickButtonWith(style: .confirm)
        }
    }

    @objc func onClickCancel(){
        if dialogButtonViewDelegate != nil {
            dialogButtonViewDelegate!.normalDialogOnClickButtonWith(style: .cancel)
        }
    }

    @objc func onClickCustom(){
        if dialogButtonViewDelegate != nil {
            dialogButtonViewDelegate!.normalDialogOnClickButtonWith(style: .custom)
        }
    }

}
