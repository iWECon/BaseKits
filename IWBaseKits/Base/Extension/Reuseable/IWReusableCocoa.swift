//
//  IWReusableCocoa.swift
//  Dove
//
//  Created by 未来 on 2019/7/10.
//  Copyright © 2019 Baige Inc. All rights reserved.
//

#if os(macOS)
import Foundation
import Cocoa

public extension NSTableView {
    
    func makeView(with identifier: String) -> NSView? {
        return self.makeView(withIdentifier: NSUserInterfaceItemIdentifier.init(identifier), owner: nil)
    }
    
    func useComponent<T: NSView>(_ cls: T.Type) -> T? {
        return self.makeView(withIdentifier: NSUserInterfaceItemIdentifier(String(describing: cls)), owner: nil) as? T
    }
    
    func registerView(nibName: String, identifier: String? = nil) -> Void {
        var _identifier = identifier
        if _identifier == nil {
            _identifier = nibName
        }
        self.register(NSNib.init(nibNamed: NSNib.Name.init(nibName), bundle: .main), forIdentifier: NSUserInterfaceItemIdentifier.init(_identifier!))
    }
    
    func registerView<T: NSView>(nibClass: T.Type) -> Void {
        registerView(nibName: String(describing: nibClass))
    }
    
}

public extension NSCollectionView {
    
    func useComponent<T: NSCollectionViewItem>(_ cls: T.Type, for indexPath: IndexPath) -> T {
        return self.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(String(describing: cls)), for: indexPath) as! T
    }
    
    func registerComponent<T: NSCollectionViewItem>(_ cls: T.Type) -> Void {
        register(cls, forItemWithIdentifier: NSUserInterfaceItemIdentifier(rawValue: String(describing: cls)))
    }
    
    func registerSupplementary<T: NSView>(_ cls: T.Type, kind: NSCollectionView.SupplementaryElementKind) -> Void {
        register(cls, forSupplementaryViewOfKind: kind, withIdentifier: NSUserInterfaceItemIdentifier(String(describing: cls)))
    }
    func reuseSupplementary<T: NSView>(_ cls: T.Type, kind: NSCollectionView.SupplementaryElementKind, for indexPath: IndexPath) -> T {
        return makeSupplementaryView(ofKind: kind, withIdentifier: NSUserInterfaceItemIdentifier(String(describing: cls)), for: indexPath) as! T
    }
    
    // It's Invalid in Swift
//    func registerComponents<T>(_ componentsClass: [T.Type] = [T.self]) -> Void where T: NSCollectionViewItem {
//        for cls in componentsClass {
//            registerComponent(cls: cls)
//        }
//    }
}


#endif
