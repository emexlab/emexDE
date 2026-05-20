/*
 SPDX-License-Identifier: AGPL-3.0-or-later

 Copyright (C) 2025 - 2026 emexlab

 This file is part of Nyxian.

 Nyxian is free software: you can redistribute it and/or modify
 it under the terms of the GNU Affero General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 Nyxian is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 GNU Affero General Public License for more details.

 You should have received a copy of the GNU Affero General Public License
 along with Nyxian. If not, see <https://www.gnu.org/licenses/>.
*/

import UIKit

class ProjectTableCell: UITableViewCell {
    static var reuseIdentifier: String = "NXProjectTableCell"
    
    var textCenterConstraint: NSLayoutConstraint? = nil
    var textCenterConstraintBox: NSLayoutConstraint? = nil
    var detailBelowTitleConstraint: NSLayoutConstraint? = nil
    var imageConstraints: [NSLayoutConstraint]? = nil
    
    var leadingConstraintWImage: NSLayoutConstraint? = nil
    var leadingConstraintWHImage: NSLayoutConstraint? = nil
    var detailLeadingConstraintWImage: NSLayoutConstraint? = nil
    var detailLeadingConstraintWHImage: NSLayoutConstraint? = nil
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        self.textLabel?.numberOfLines = 1
        self.textLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        self.detailTextLabel?.numberOfLines = 1
        self.detailTextLabel?.font = UIFont.systemFont(ofSize: 10)
        
        self.imageView?.translatesAutoresizingMaskIntoConstraints = false
        self.textLabel?.translatesAutoresizingMaskIntoConstraints = false
        self.detailTextLabel?.translatesAutoresizingMaskIntoConstraints = false
        
        let imageSize: CGFloat = 50
        
        self.imageConstraints = [
            self.imageView!.widthAnchor.constraint(equalToConstant: imageSize),
            self.imageView!.heightAnchor.constraint(equalToConstant: imageSize),
            self.imageView!.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.imageView!.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ]
        
        self.leadingConstraintWImage = self.textLabel!.leadingAnchor.constraint(equalTo: self.imageView!.trailingAnchor, constant: 16)
        self.leadingConstraintWHImage = self.textLabel!.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16)
        self.detailLeadingConstraintWImage = self.detailTextLabel!.leadingAnchor.constraint(equalTo: self.imageView!.trailingAnchor, constant: 16)
        self.detailLeadingConstraintWHImage = self.detailTextLabel!.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16)
        
        self.textCenterConstraint = self.textLabel?.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        self.textCenterConstraintBox = self.textLabel?.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: -10)
        self.detailBelowTitleConstraint = self.detailTextLabel?.topAnchor.constraint(equalTo: self.textLabel!.bottomAnchor, constant: 4)
        
        NSLayoutConstraint.activate([
            self.textCenterConstraint!,
            self.detailBelowTitleConstraint!,
            
            self.textLabel!.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.detailTextLabel!.trailingAnchor.constraint(equalTo: self.textLabel!.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate(self.imageConstraints!)
        self.leadingConstraintWImage?.isActive = true
        self.detailLeadingConstraintWImage?.isActive = true
        
        if #available(iOS 26.0, *) {
            self.imageView?.layer.cornerRadius = 15
        } else {
            self.imageView?.layer.cornerRadius = 10
        }
        
        self.imageView?.clipsToBounds = true
        self.imageView?.layer.borderWidth = 0.5
        self.imageView?.layer.borderColor = UIColor.gray.cgColor
        
        self.separatorInset = .zero
        self.layoutMargins = .zero
        self.preservesSuperviewLayoutMargins = false
    }
    
    func configure(displayName: String,
                   bundleIdentifier: String?,
                   appIcon: UIImage?,
                   showArrow: Bool) {
        self.textLabel?.text = displayName
        self.imageView?.image = appIcon
        self.accessoryType = showArrow ? .disclosureIndicator : .none
        
        if let bundleIdentifier = bundleIdentifier {
            self.detailTextLabel?.text = bundleIdentifier
            self.detailTextLabel?.isHidden = false
            self.detailBelowTitleConstraint?.isActive = true
            self.textCenterConstraint?.isActive = false
            self.textCenterConstraintBox?.isActive = true
        } else {
            self.detailTextLabel?.isHidden = true
            self.detailBelowTitleConstraint?.isActive = false
            self.textCenterConstraint?.isActive = true
            self.textCenterConstraintBox?.isActive = false
        }
        
        if let appIcon = appIcon {
            self.imageView?.isHidden = false
            NSLayoutConstraint.activate(self.imageConstraints!)
            self.leadingConstraintWHImage?.isActive = false
            self.leadingConstraintWImage?.isActive = true
            self.detailLeadingConstraintWHImage?.isActive = false
            self.detailLeadingConstraintWImage?.isActive = true
        } else {
            self.imageView?.isHidden = true
            self.leadingConstraintWImage?.isActive = false
            self.leadingConstraintWHImage?.isActive = true
            self.detailLeadingConstraintWHImage?.isActive = false
            self.detailLeadingConstraintWImage?.isActive = true
            self.detailLeadingConstraintWImage?.isActive = false
            self.detailLeadingConstraintWHImage?.isActive = true
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.textLabel?.text = nil
        self.detailTextLabel?.text = nil
        self.imageView?.image = nil
        self.accessoryType = .none
        self.imageView?.isHidden = false
        self.detailTextLabel?.isHidden = false
    }
}
