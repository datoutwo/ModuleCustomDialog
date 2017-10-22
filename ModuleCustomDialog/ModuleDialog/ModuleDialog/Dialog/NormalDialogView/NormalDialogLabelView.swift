//
//  NormalDialogLabelView.swift
//  ModuleDialog
//
//  Created by Datoutwo on 22/10/2017.
//  Copyright © 2017 Datoutwo. All rights reserved.
//

import UIKit

class NormalDialogLabelView: UILabel {

    func setLabelParameterWith(LabelItem: NormalDialogLabelItem){

        text = LabelItem.labelText
        font = LabelItem.textFout
        textColor = LabelItem.textColor
        backgroundColor = LabelItem.backgroundColor
        textAlignment = LabelItem.textAlignment
        lineBreakMode = .byWordWrapping
        numberOfLines = LabelItem.labelLines

    }

}
