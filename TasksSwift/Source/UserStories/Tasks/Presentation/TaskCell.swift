//
//  TaskCell.swift
//  TasksSwift
//
//  Created by Jace on 8/5/18.
//  Copyright © 2018 Cultured Code GmbH & Co. KG. All rights reserved.
//

import UIKit

private extension UIImage {

    static func taskMarkImageWithCompletionStatus(_ completed: Bool) -> UIImage {
        let imageName = completed ? "Checkbox-Checked" : "Checkbox-Empty"
        return UIImage(named: imageName)!
    }
}

private extension UIColor {

    static func taskTextColorWithCompletionStatus(_ completed: Bool) -> UIColor {
        return completed ? UIColor.lightGray : UIColor.black
    }
}

class TaskCell : UITableViewCell {

    private weak var markImageView: UIImageView?
    private weak var titleLabel: UILabel?

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupTextLabel()
        setupMarkView()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func subview(for tag: UInt) -> UIView? {
        for subview in self.subviews {
            if subview.tag == tag {
                return subview
            }
        }

        return nil
    }
}

private extension TaskCell {

    func setupMarkView() {
        let markImageView = UIImageView()
        markImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(markImageView)

        self.markImageView = markImageView
    }

    func setupTextLabel() {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.init(name: "AmericanTypewriter", size: 16)
        titleLabel.textColor = UIColor.black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)

        self.titleLabel = titleLabel
    }

    func setupLayout() {
        guard let markImageView = self.markImageView else { return }
        markImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        markImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        markImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        markImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        titleLabel?.leftAnchor.constraint(equalTo:markImageView.rightAnchor).isActive = true
        titleLabel?.rightAnchor.constraint(equalTo:rightAnchor).isActive = true
        titleLabel?.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}

extension TaskCell {

    func setupWithTask(_ task: Task) {
        titleLabel?.text = task.title
        titleLabel?.textColor = UIColor.taskTextColorWithCompletionStatus(task.completed)
        markImageView?.image = UIImage.taskMarkImageWithCompletionStatus(task.completed)
        accessoryType = task.childrenTasks?.isEmpty != false ? .none : .detailDisclosureButton
    }
}
