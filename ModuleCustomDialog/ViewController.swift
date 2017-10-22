//
//  ViewController.swift
//  ModuleCustomDialog
//
//  Created by Datoutwo on 22/10/2017.
//  Copyright © 2017 Datoutwo. All rights reserved.
//

import UIKit
import ModuleDialog

class ViewController: UIViewController, NormalDialogDelegate {
    var normalDialog : NormalDialogViewController?

    func normalDialogOnClickButton(style: NormalDialogButtonStyle) {
        normalDialog?.dismissDialog()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func clickShowButton(_ sender: UIButton) {
        if true == CustomAPPDialog.sharedInstance.checkUserDialogFileExist(fileName: "TemplateDialog"){
            let templateDialog = CustomAPPDialog.sharedInstance.getUserDialogItemWith(fileName: "TemplateDialog")
            normalDialog = NormalDialogViewController(
                withButtonArray:templateDialog.buttonArray,
                labelItem:templateDialog.labelItem,
                frameItem:templateDialog.frameItem)
            normalDialog!.normalDialogDelegate = self

            normalDialog!.showDialog(parentVC: self)
            let tempView = normalDialog!.customView
            tempView?.backgroundColor = UIColor.black
        }
    }

}

