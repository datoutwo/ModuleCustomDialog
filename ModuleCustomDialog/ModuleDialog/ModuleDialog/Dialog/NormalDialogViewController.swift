//
//  NormalDialogViewController.swift
//  ModuleDialog
//
//  Created by Datoutwo on 22/10/2017.
//  Copyright © 2017 Datoutwo. All rights reserved.
//

import UIKit

public protocol NormalDialogDelegate {
    func normalDialogOnClickButton(style: NormalDialogButtonStyle)
}

public class NormalDialogViewController: BaseDialogViewController, NormalDialogButtonViewDelegate {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var titleLabel: NormalDialogLabelView!
    @IBOutlet weak public var customView: UIView!
    @IBOutlet weak var buttonView: NormalDialogButtonView!
    @IBOutlet weak var labelHeight: NSLayoutConstraint!
    @IBOutlet weak var buttonHeight: NSLayoutConstraint!

    private var dialogButtonAry = Array<NormalDialogButtonItem>()
    private var dialogLabelItem = NormalDialogLabelItem()
    private var dialogFrameItem = NormalDialogFrameItem()
    public var normalDialogDelegate : NormalDialogDelegate?

    //MARK: Life Cycle
    convenience public init(withButtonArray: Array<NormalDialogButtonItem>,
                            labelItem: NormalDialogLabelItem,
                            frameItem: NormalDialogFrameItem) {
        let bundle = Bundle(identifier:"com.ModuleDialog")
        self.init(nibName: "NormalDialogViewController", bundle: bundle)
        dialogButtonAry = withButtonArray
        dialogLabelItem = labelItem
        dialogFrameItem = frameItem
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        setMainViewFrame()
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setAlphaStyle(alphaStyle: dialogFrameItem.dialogAlpha)
    }

    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setTitleViewParameter()
        setButtonViewParameter()
    }

    //MARK: func
    private func setMainViewFrame(){
        mainView.layer.cornerRadius = 10
        mainView.layer.masksToBounds = true

        mainView.layer.borderWidth = dialogFrameItem.borderLineWidth
        mainView.layer.borderColor = dialogFrameItem.borderLineColor.cgColor

        labelHeight.constant = dialogFrameItem.labelHeight
        buttonHeight.constant = dialogFrameItem.buttonHeight
    }

    private func setTitleViewParameter(){
        titleLabel.setLabelParameterWith(LabelItem: dialogLabelItem)
    }

    private func setButtonViewParameter(){
        buttonView.dialogButtonViewDelegate = self
        buttonView.setButtonViewWith(aryButtonItem: dialogButtonAry)
    }

    //MARK: delegate
    func normalDialogOnClickButtonWith(style: NormalDialogButtonStyle) {
        if normalDialogDelegate != nil{
            normalDialogDelegate!.normalDialogOnClickButton(style: style)
        }
    }

}
