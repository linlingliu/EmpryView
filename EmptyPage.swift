//
//  EmptyPage.swift
//  RXSwiftDemo
//
//  Created by sameway on 2019/5/6.
//  Copyright © 2019 sameway. All rights reserved.
//

import UIKit

public struct EmptyPage {
    
    fileprivate static var tableViewLock = false
    
    //MARK: 替换tableView reload 函数
    
    static func swizzingTableView() {
        if tableViewLock { return }
        tableViewLock = true
        replaceMethod(selector: #selector(UITableView.layoutSubviews), with: #selector(UITableView.tableView_emptyLayoutSubViews), class: UITableView.self)
        replaceMethod(selector: #selector(UITableView.layoutIfNeeded), with: #selector(UITableView.tableView_emptyLayoutIfNeeded), class: UITableView.self)
        replaceMethod(selector: #selector(UITableView.insertRows(at:with:)), with: #selector(UITableView.tableView_emptyInsertRows(at:with:)), class: UITableView.self)
        replaceMethod(selector: #selector(UITableView.deleteRows(at:with:)), with: #selector(UITableView.tableView_emptyDeleteRows(at:with:)), class: UITableView.self)
        
        replaceMethod(selector: #selector(UITableView.insertSections(_:with:)), with: #selector(UITableView.tableView_emptyInsertSections(_:with:)), class: UITableView.self)
        
        replaceMethod(selector: #selector(UITableView.deleteSections(_:with:)), with: #selector(UITableView.tableView_empty_DeleteSections(_:with:)), class: UITableView.self)
        replaceMethod(selector: #selector(UITableView.reloadData), with: #selector(UITableView.tableView_emptyReload), class: UITableView.self)
    }
    
    fileprivate static var collectionViewLock = false
    
    /// 替换 CollectionView 相关函数
    static func swizzingCollectionView() {
        if collectionViewLock { return }
        collectionViewLock = true
        replaceMethod(selector: #selector(UICollectionView.layoutSubviews),
                      with: #selector(UICollectionView.collectionView_emptyLayoutSubViews),
                      class: UICollectionView.self)
        
        replaceMethod(selector: #selector(UICollectionView.layoutIfNeeded),
                      with: #selector(UICollectionView.collectionView_emptyLayoutIfNeeded),
                      class: UICollectionView.self)
        
        replaceMethod(selector: #selector(UICollectionView.reloadData),
                      with: #selector(UICollectionView.collectionView_emptyReloadData),
                      class: UICollectionView.self)
        
        replaceMethod(selector: #selector(UICollectionView.insertItems(at:)),
                      with: #selector(UICollectionView.collectionView_emptyInsertItems(at:)),
                      class: UICollectionView.self)
        
        replaceMethod(selector: #selector(UICollectionView.deleteItems(at:)),
                      with: #selector(UICollectionView.collectionView_emptyDeleteItems(at:)),
                      class: UICollectionView.self)
        
        replaceMethod(selector: #selector(UICollectionView.insertSections(_:)),
                      with: #selector(UICollectionView.collectionView_emptyInsertSections(_:)),
                      class: UICollectionView.self)
        
        replaceMethod(selector: #selector(UICollectionView.deleteSections(_:)),
                      with: #selector(UICollectionView.collectionView_emptyDeleteSections(_:)),
                      class: UICollectionView.self)
    }
}

//MARK: 交换方法的实现

extension EmptyPage {
    
    static func replaceMethod(selector:Selector,with:Selector,class classType:AnyClass) {
        let select1 = selector
        let select2 = with
        guard let select1Method = class_getInstanceMethod(classType, select1) else {
            assertionFailure("没有发现方法" + select1.description)
            return
        }
        guard let select2Method = class_getInstanceMethod(classType, select2) else {
            assertionFailure("没有发现方法" + select2.description)
            return
        }
        
        let didAddMethod = class_addMethod(classType, select1, method_getImplementation(select2Method), method_getTypeEncoding(select2Method))
        if didAddMethod {
            class_replaceMethod(classType, select2, method_getImplementation(select1Method), method_getTypeEncoding(select1Method))
        }else {
            method_exchangeImplementations(select1Method, select2Method)
        }
        
    }
}
