//
//  UIScrollView+EmptyPage.swift
//  RXSwiftDemo
//
//  Created by sameway on 2019/5/6.
//  Copyright © 2019 sameway. All rights reserved.
//

import UIKit

public extension UIScrollView {
    
    private struct EmptyDataKey {
        static let emptyViewKey = UnsafeRawPointer(bitPattern: "scroll_emptyViewKey".hashValue)!
        static let oldEmptyViewKey = UnsafeRawPointer(bitPattern: "scroll_oldEmptyViewKey".hashValue)!
    }
    
    weak var oldEmptyView:UIView? {
    get {
    return objc_getAssociatedObject(self, EmptyDataKey.oldEmptyViewKey) as? UIView
    }
        set {
            if oldEmptyView?.superview != nil  {
                return
            }
            if let emptyView:AnyObject = newValue {
                objc_setAssociatedObject(self, EmptyDataKey.oldEmptyViewKey, emptyView, .OBJC_ASSOCIATION_RETAIN)
            }
        }
    }
    
    //空白视图
    var emptyView:UIView? {
        get {
           return objc_getAssociatedObject(self, EmptyDataKey.emptyViewKey) as? UIView
        }
        set {
            if let emptyView : AnyObject = newValue {
                self.oldEmptyView = self.emptyView
                switch self {
                    case _ as UITableView: EmptyPage.swizzingTableView()
                    case _ as UICollectionView: EmptyPage.swizzingCollectionView()
                    default : break
                }
                objc_setAssociatedObject(self, EmptyDataKey.emptyViewKey, emptyView, .OBJC_ASSOCIATION_RETAIN)
            }else {
                emptyView?.removeFromSuperview()
                self.oldEmptyView = nil
        objc_setAssociatedObject(self,EmptyDataKey.emptyViewKey,nil,.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
}
