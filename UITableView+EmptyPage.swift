//
//  UITableView+EmptyPage.swift
//  RXSwiftDemo
//
//  Created by sameway on 2019/5/6.
//  Copyright © 2019 sameway. All rights reserved.
//

import UIKit

@objc

extension UITableView {
     @objc func tableView_emptyLayoutSubViews() {
        tableView_emptyLayoutSubViews()
        setEmptyView {}
    }
    
    @objc func tableView_emptyLayoutIfNeeded() {
        tableView_emptyLayoutIfNeeded()
        setEmptyView {}
    }
    
    @objc func tableView_emptyInsertRows(at indexPaths:[IndexPath], with animation:UITableView.RowAnimation) {
        setEmptyView {
            [weak self] in
            guard let base = self else {
                return
            }
            base.tableView_emptyInsertRows(at: indexPaths, with: animation)
        }
    }
    
    @objc func tableView_emptyDeleteRows(at indexPaths:[IndexPath], with animation:UITableView.RowAnimation) {
        setEmptyView {
            [weak self] in
            guard let base = self else {return}
            base.tableView_emptyDeleteRows(at: indexPaths, with: animation)
        }
    }
    
    @objc func tableView_emptyInsertSections(_ sections:IndexSet, with animation:UITableView.RowAnimation) {
        setEmptyView {
            [weak self] in
            guard let base = self else {return}
            base.tableView_emptyInsertSections(sections, with: animation)
        }
    }
    
    @objc func tableView_empty_DeleteSections(_ sections:IndexSet, with animation:UITableView.RowAnimation) {
        setEmptyView {
            [weak self] in
            guard let base = self else {return}
            base.tableView_empty_DeleteSections(sections, with: animation)
        }
    }
    
    @objc func tableView_emptyReload() {
        setEmptyView {
            [weak self] in
            guard let base = self else { return}
            base.tableView_emptyReload()
        }
    }
    
    func setEmptyView(event:()->())  {
        oldEmptyView?.removeFromSuperview()
        event()
        guard bounds.width != 0, bounds.height != 0 else { return }
        var isHasRows = false
        let sectionCount = dataSource?.numberOfSections?(in: self) ?? numberOfSections
        for index in 0..<sectionCount {
            if numberOfRows(inSection: index) > 0 {
                isHasRows = true
                break
            }
        }
        isScrollEnabled = isHasRows
        if isHasRows {
            emptyView?.removeFromSuperview()
            return
        }
        guard let view = emptyView else{ return }
        view.frame = bounds
        addSubview(view)
        sendSubviewToBack(view)
    }
}

