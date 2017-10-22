//
//  NormalDialogItem.swift
//  ModuleDialog
//
//  Created by Datoutwo on 22/10/2017.
//  Copyright © 2017 Datoutwo. All rights reserved.
//

import Foundation

public struct NormalDialogLabelItem {

    private(set) var labelText = "Warning"
    private(set) var textColor = UIColor.white
    private(set) var backgroundColor = UIColor.red
    private(set) var textFout = UIFont.boldSystemFont(ofSize: 17.0)
    private(set) var textAlignment = NSTextAlignment.center
    private(set) var labelLines = 1

    public init(){}

    mutating public func initWithCustom(
        labelText:String,
        textColor:UIColor,
        bgColor:UIColor,
        font:UIFont,
        alignment:NSTextAlignment,
        labelLines:Int){

        self.labelText = labelText
        self.textColor = textColor
        backgroundColor = bgColor
        textFout = font
        textAlignment = alignment
        self.labelLines = labelLines
    }
}

public enum NormalDialogButtonStyle : Int{
    case confirm, cancel, custom
}

let bundle = Bundle(identifier:"com.ModuleDialog")

public struct NormalDialogButtonItem {


    private(set) var titleColor = UIColor.black
    private(set) var backgroundColor = UIColor.white
    private(set) var titleAlignment = NSTextAlignment.center
    private(set) var titleFont = UIFont.boldSystemFont(ofSize: 17.0)
    private(set) var middleLineColor = UIColor.yellow
    private(set) var middleLineWidth = 2

    private(set) var titleText = "Confirm"
    private(set) var buttonImage = UIImage(named:"DialogImage_Confirm.png", in:bundle, compatibleWith:nil)
    private(set) var buttonStyle = NormalDialogButtonStyle.confirm
    private(set) var buttonWithImage = true


    public init (){}

    mutating public func initWithDefaultOkWithImage(){
        titleText = "Confirm"
        buttonImage = UIImage(named:"DialogImage_Confirm.png", in:bundle, compatibleWith:nil)
        buttonStyle = .confirm
        buttonWithImage = true
    }

    mutating public func initWithDefaultOkWithoutImage(){
        titleText = "Confirm"
        buttonStyle = .confirm
        buttonWithImage = false
    }

    mutating public func initWithDefaultCancelWithImage(){
        titleText = "Cancel"
        buttonImage = UIImage(named:"DialogImage_Cancel.png", in:bundle, compatibleWith:nil)
        buttonStyle = .cancel
        buttonWithImage = true
    }

    mutating public func initWithDefaultCancelWithoutImage(){
        titleText = "Cancel"
        buttonStyle = .cancel
        buttonWithImage = false
    }

    mutating public func initWithCustom(
        titleColor:UIColor,
        bgColor:UIColor,
        midLineColor:UIColor,
        midLineWidth:Int,
        titleAligment:NSTextAlignment,
        titleFont:UIFont,
        titleText:String,
        image:UIImage,
        style:NormalDialogButtonStyle,
        withImage:Bool){

        self.titleColor = titleColor
        backgroundColor = bgColor
        titleAlignment = titleAligment
        self.titleFont = titleFont
        self.titleText = titleText
        buttonImage = image
        buttonStyle = style
        buttonWithImage = withImage
        middleLineWidth = midLineWidth
        middleLineColor = midLineColor
    }
}

public struct NormalDialogFrameItem {

    private(set) var borderLineWidth : CGFloat = 0
    private(set) var borderLineColor = UIColor.clear
    private(set) var labelHeight : CGFloat = 40.0
    private(set) var buttonHeight : CGFloat = 60.0
    private(set) var dialogAlpha : BaseDialog_Alpha = .notClear

    public init(){}

    mutating public func initWithCustom(
        borderWidth:CGFloat,
        borderColor:UIColor,
        labelHeight:CGFloat,
        buttonHeight:CGFloat,
        dialogAlpha:BaseDialog_Alpha){

        borderLineWidth = borderWidth
        borderLineColor = borderColor
        self.labelHeight = labelHeight
        self.buttonHeight = buttonHeight
        self.dialogAlpha = dialogAlpha
    }
}
