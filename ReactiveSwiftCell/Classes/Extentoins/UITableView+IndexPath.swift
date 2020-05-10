//
//  UITableView+IndexPath.swift
//  ReactiveSwiftCell
//
//  Created by Aleksandr Lis on 03.05.2020.
//  Copyright © 2020 Aleksandr Lis. All rights reserved.
//

import UIKit

extension UITableViewCell {
    func nextIndexPathWithInputText(at indexPath: IndexPath) -> IndexPath? {
        let tableView: UITableView?
        if #available(iOS 11, *) {
            tableView = superview as? UITableView
        } else {
            tableView = superview?.superview as? UITableView
        }
        let rows = tableView?.numberOfRows(inSection: indexPath.section) ?? 0
        guard indexPath.row == rows - 1 else {
            return indexPath.nextRow()
        }
        
        let sections = tableView?.numberOfSections ?? 0
        guard indexPath.section < sections - 1 else { return nil }
        
        var nextIndePath: IndexPath?
        for section in indexPath.section..<sections-1 {
            nextIndePath = nextIndexPathWithInputText(in: section + 1)
        }
        return nextIndePath
    }
    
    private func nextIndexPathWithInputText(in section: Int) -> IndexPath? {
        let tableView: UITableView?
        if #available(iOS 11, *) {
            tableView = superview as? UITableView
        } else {
            tableView = superview?.superview as? UITableView
        }
        let rows = tableView?.numberOfRows(inSection: section) ?? 0
        for row in 0..<rows {
            let nextIndexPath = IndexPath(row: row, section: section)
            let cell = tableView?.cellForRow(at: nextIndexPath)
            var indexPath: IndexPath?
            cell?.contentView.subviews.forEach {
                if $0 is UITextField || $0 is UITextView {
                    indexPath = nextIndexPath
                    return
                }
            }
            return indexPath
        }
        return nil
    }
}

extension IndexPath {
    func nextRow() -> Self {
        return IndexPath(row: row + 1, section: section)
    }
}
