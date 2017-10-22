//
//  CustomAPPDialog.swift
//  ModuleCustomDialog
//
//  Created by Datoutwo on 22/10/2017.
//  Copyright © 2017 Datoutwo. All rights reserved.
//

import UIKit
import ModuleDialog

let NormalDialog_File = "NormalDialog"
let PLIST_FILE = "plist"

class CustomAPPDialog: NSObject {

    static let sharedInstance = CustomAPPDialog()

    func checkUserDialogFileExist(fileName: String)->Bool{
        if !FileManager.default.fileExists(atPath: Bundle.main.path(forResource: NormalDialog_File, ofType: PLIST_FILE)!)
        {
            print("file not exist")
            return false
        }
        let dialogDic = NSDictionary(contentsOfFile: Bundle.main.path(forResource: NormalDialog_File, ofType: PLIST_FILE)!)!
        if dialogDic[fileName] != nil {
            return true
        }
        return false
    }

    typealias dialogItem = (buttonArray: Array<NormalDialogButtonItem>,
        labelItem: NormalDialogLabelItem,
        frameItem: NormalDialogFrameItem)

    func getUserDialogItemWith(fileName: String)->(dialogItem){

        let item : dialogItem = (buttonArray:getUserDialogButtonItemWith(fileName: fileName),
                                 labelItem:getUserDialogLabelItemWith(fileName: fileName),
                                 frameItem:getUserDialogFrameItemWith(fileName: fileName))

        return item
    }

    private func getUserDialogButtonItemWith(fileName: String)->(Array<NormalDialogButtonItem>){
        var aryReturn = Array<NormalDialogButtonItem>()
        let dialogDic = NSDictionary(contentsOfFile: Bundle.main.path(forResource: NormalDialog_File, ofType: PLIST_FILE)!)!
        let dialogItem = dialogDic[fileName] as! Dictionary<String, Any>
        let buttonArray: Array = dialogItem[NORMAL_ArrayButtons] as! Array<AnyObject>

        if buttonArray.count >= 1{
            for index in 0...buttonArray.count-1{
                var buttonDic : Dictionary = buttonArray[index] as! Dictionary<String, Any>
                var dialogButonItem = NormalDialogButtonItem()

                dialogButonItem.initWithCustom(
                    titleColor: colorWithHexString(hex: buttonDic[NORMAL_DialogButtonTitleColor] as! String ),
                    bgColor: colorWithHexString(hex: buttonDic[NORMAL_DialogButtonBGColor] as! String),
                    midLineColor: colorWithHexString(hex: buttonDic[NORMAL_DialogButtonMidLineColor] as! String),
                    midLineWidth: buttonDic[NORMAL_DialogButtonMidLineWidth] as! Int,
                    titleAligment: alignmentWithString(align: buttonDic[NORMAL_DialogButtonTitleAlignment] as! String),
                    titleFont: fontWithCGFloat(fontFloat: buttonDic[NORMAL_DialogButtonTitleFont] as! CGFloat),
                    titleText: buttonDic[NORMAL_DialogButtonTitleText] as! String,
                    image: imageWithString(image: buttonDic[NORMAL_DialogButtonImage] as? String),
                    style: styleWithString(style: buttonDic[NORMAL_DialogButtonStyle] as! String),
                    withImage: buttonDic[NORMAL_DialogButtonWithImage] as! Bool)

                aryReturn.append(dialogButonItem)
            }
        }

        return aryReturn
    }

    func getUserDialogLabelItemWith(fileName: String)->(NormalDialogLabelItem){
        let dialogDic = NSDictionary(contentsOfFile: Bundle.main.path(forResource: NormalDialog_File, ofType: PLIST_FILE)!)!
        let dialogItem = dialogDic[fileName] as! Dictionary<String, Any>
        let labelItemDic: Dictionary = dialogItem[NORMAL_Label] as! Dictionary<String, Any>
        var labelItem = NormalDialogLabelItem()

        labelItem.initWithCustom(
            labelText: labelItemDic[NORMAL_DialogLabelText] as! String,
            textColor: colorWithHexString(hex: labelItemDic[NORMAL_DialogLabelTextColor] as! String ),
            bgColor: colorWithHexString(hex: labelItemDic[NORMAL_DialogLabelBGColor] as! String),
            font: fontWithCGFloat(fontFloat: labelItemDic[NORMAL_DialogLabelTextFont] as! CGFloat),
            alignment: alignmentWithString(align: labelItemDic[NORMAL_DialogLabelTextAlignment] as! String),
            labelLines: labelItemDic[NORMAL_DialogLabelLines] as! Int)

        return labelItem
    }

    func getUserDialogFrameItemWith(fileName: String)->(NormalDialogFrameItem){
        let dialogDic = NSDictionary(contentsOfFile: Bundle.main.path(forResource: NormalDialog_File, ofType: PLIST_FILE)!)!
        let dialogItem = dialogDic[fileName] as! Dictionary<String, Any>
        let frameItemDic: Dictionary = dialogItem[NORMAL_Frame] as! Dictionary<String, Any>
        var frameItem = NormalDialogFrameItem()

        frameItem.initWithCustom(
            borderWidth: frameItemDic[NORMAL_DialogFrameBorderWidth] as! CGFloat,
            borderColor: colorWithHexString(hex: frameItemDic[NORMAL_DialogFrameBorderColor] as! String ),
            labelHeight: frameItemDic[NORMAL_DialogFrameLabelHeight] as! CGFloat,
            buttonHeight: frameItemDic[NORMAL_DialogFrameButtonHeight] as! CGFloat,
            dialogAlpha: alphaWithCGFloat( alphaFloat:frameItemDic[NORMAL_DialogFrameBGAlpha] as! CGFloat))

        return NormalDialogFrameItem()
    }

    func colorWithHexString (hex:String) -> UIColor {
        var cString:String =
            hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            let indexPrefix = cString.index(cString.startIndex, offsetBy: 1)
            cString = String(cString[indexPrefix...])
        }
        if (cString.count != 6) {
            return UIColor.gray
        }

        let indexR = cString.index(cString.startIndex, offsetBy: 2)
        let rString = String(cString[..<indexR])
        let indexStartG = cString.index(cString.startIndex, offsetBy: 2)
        let indexEedG = cString.index(cString.startIndex, offsetBy: 4)
        let gString = String(cString[indexStartG..<indexEedG])
        let indexEndB = cString.index(cString.startIndex, offsetBy: 4)
        let bString = String(cString[indexEndB...])
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }

    func alignmentWithString (align: String) -> NSTextAlignment{
        switch align.lowercased() {
        case "center":
            return .center
        case "left":
            return .left
        case "right":
            return .right
        default:
            return .center
        }
    }

    func styleWithString (style:String) -> NormalDialogButtonStyle{
        switch style.lowercased() {
        case "confirm":
            return .confirm
        case "cancel":
            return .cancel
        case "custom":
            return .custom
        default:
            return .confirm
        }
    }

    func imageWithString (image:String?) ->UIImage{
        if image != nil && image != ""{
            return UIImage(named:image!)!
        }
        return UIImage()
    }

    func fontWithCGFloat (fontFloat:CGFloat) -> UIFont{
        return UIFont.boldSystemFont(ofSize:fontFloat)
    }

    func alphaWithCGFloat (alphaFloat: CGFloat) -> BaseDialog_Alpha{
        return alphaFloat > 0 ? .notClear : .clear
    }

}
