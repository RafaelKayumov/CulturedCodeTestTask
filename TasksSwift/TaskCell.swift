//
//  TaskCell.swift
//  TasksSwift
//
//  Created by Jace on 8/5/18.
//  Copyright © 2018 Cultured Code GmbH & Co. KG. All rights reserved.
//

import Foundation
import UIKit


let CHECKMARKVIEW: UInt = 100


class TaskCell : UITableViewCell {

    var task: TSTask? {
        didSet {
            self.textLabel?.text = task?.title
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    func configureStyle() {
        self.textLabel?.font = UIFont.init(name: "AmericanTypewriter", size: 16)
        self.textLabel?.textColor = UIColor.black
    }

    func setInactive() {
        self.textLabel?.textColor = UIColor.lightGray
    }

    func subview(for tag: UInt) -> UIView? {
        for subview in self.subviews {
            if subview.tag == tag {
                return subview
            }
        }

        return nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        // Configure Image View
        var imageView: UIImageView? = self.subview(for: CHECKMARKVIEW) as! UIImageView?
        if (imageView == nil) {
            imageView = UIImageView.init(image: UIImage.init(named: "Checkbox-Empty.png"))
            imageView?.tag = Int(CHECKMARKVIEW)
        }

        imageView?.bounds = CGRect.init(x: 0, y: 0, width: 40, height: self.bounds.size.height)
        self.addSubview(imageView!)

        // Configure Title
        var r = self.textLabel?.bounds;
        r?.origin.x = 40
        self.textLabel?.frame = r!

        // Switch Image
        if task!.completed() {
            imageView?.image = UIImage.init(named: "Checkbox-Checked.png")
        }
        else {
            imageView?.image = UIImage.init(named: "Checkbox-Empty.png")
        }
    }
}
