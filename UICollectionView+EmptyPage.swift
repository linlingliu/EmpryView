//
//  UICollectionView+EmptyPage.swift
//  RXSwiftDemo
//
//  Created by sameway on 2019/5/9.
//  Copyright © 2019 sameway. All rights reserved.
//

import UIKit

@objc
extension UICollectionView {
    
    @objc func collectionView_emptyLayoutSubViews() {
        collectionView_emptyLayoutSubViews()
        setEmptyView {
            
        }
    }
    
    @objc func collectionView_emptyLayoutIfNeeded() {
        collectionView_emptyLayoutIfNeeded()
        setEmptyView {
            
        }
    }
    
    @objc func collectionView_emptyInsertItems(at indexPaths:[IndexPath]) {
        setEmptyView {
            [weak self] in
            guard let base = self else {return}
            base.collectionView_emptyInsertItems(at: indexPaths)
        }
    }
    
    @objc func collectionView_emptyDeleteItems(at indexPaths:[IndexPath]) {
        setEmptyView {
            [weak self] in
            guard let base = self else {return}
            base.collectionView_emptyDeleteItems(at: indexPaths)
        }
    }
    
    @objc func collectionView_emptyInsertSections(_ sections:IndexSet) {
        setEmptyView {
            [weak self] in
            guard let base = self else {return}
            base.collectionView_emptyInsertSections(sections)
        }
    }
    
    @objc func collectionView_emptyDeleteSections(_ sections:IndexSet) {
        setEmptyView {
            [weak self] in
            guard let base = self else {return}
            base.collectionView_emptyDeleteSections(sections)
        }
    }
    
    @objc func collectionView_emptyReloadData() {
        setEmptyView {
            [weak self] in
            guard let base = self else {return}
            base.collectionView_emptyReloadData()
        }
    }
    
    func setEmptyView(event:()->()) {
       oldEmptyView?.removeFromSuperview()
        event ()
        guard bounds.width != 0, bounds.height != 0 else {
            return
        }
        var isHasRows = false
        let sectionCount = dataSource?.numberOfSections?(in: self) ?? numberOfSections
        for index in 0..<sectionCount {
            if numberOfItems(inSection: index) > 0 {
                isHasRows = true
                break
            }
        }
        
        isScrollEnabled = isHasRows
        if isHasRows {
            emptyView?.removeFromSuperview()
            return
        }
        
        guard let view = emptyView else {
            return
        }
        view.frame = bounds
        addSubview(view)
        sendSubviewToBack(view)
    }
}
