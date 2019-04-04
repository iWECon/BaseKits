//
//  Optional+.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/4/3.
//  Copyright © 2019 iWECon. All rights reserved.
//

#if os(macOS)
    import Cocoa
#else
    import UIKit
#endif

public extension Optional {
    
    /// is nil(none)
    var isNone: Bool {
        switch self {
        case .none: return true
        default: return false
        }
    }
    
    /// has some value.
    var isSome: Bool {
        switch self {
        case .some(_): return true
        default: return false
        }
    }
    
    var any: Any {
        return self as Any
    }
    
    /// Returns value.
    /// (返回解析值, 若目标值为nil 则直接崩溃).
    var value: Wrapped {
        if self.isSome { return self! }
        fatalError("Unexpectedly found nil while unwrapping an Optional value (解析失败, 目标值为nil).")
    }
    
    /// Return the value of the Optional or the `default` parameter
    /// (如果目标有值则返回目标值, 否则返回defualt).
    func or(_ default: Wrapped) -> Wrapped {
        return self ?? `default`
    }
    
    /// Returns the unwrapped value of the optional *or*
    /// the result of an expression `else`
    /// I.e. optional.or(else: print("Arrr"))
    func or(else: @autoclosure () -> Wrapped) -> Wrapped {
        return self ?? `else`()
    }
    
    /// Returns the unwrapped value of the optional *or*
    /// the result of calling the closure `else`
    /// I.e. optional.or(else: {
    /// ... do a lot of stuff
    /// })
    func or(else: () -> Wrapped) -> Wrapped {
        return self ?? `else`()
    }
    
    /// Returns the unwrapped contents of the optional if it is not empty
    /// If it is empty, throws exception `throw`
    func or(throw exception: Error) throws -> Wrapped {
        guard let unwrapped = self else { throw exception }
        return unwrapped
    }
    
    /// (类似 or, 当条件(fn)不成立时, 以 `default` 作为返回值).
    func map<T>(_ fn: (Wrapped) throws -> T, default: T) rethrows -> T {
        return try map(fn) ?? `default`
    }
    
    /// (类似 or, 当条件(fn)不成立时, 以返回的 `else()` 作为返回值).
    ///
    ///     let str: String? = "a"
    ///     str.map({ $0 == "a" }, else: { false }) -> true
    ///     str.map({ $0 == "c" }, else: { false }) -> false
    func map<T>(_ fn: (Wrapped) throws -> T, else: () throws -> T) rethrows -> T {
        return try map(fn) ?? `else`()
    }
    
    /// (self 为 nil 时返回 nil, 否则返回可选值 B).
    func and<B>(_ optional: B?) -> B? {
        guard self != nil else { return nil }
        return optional
    }
    
    /// (self 有值则传递至 then 闭包进行处理, 否则返回 nil).
    func and<T>(then: (Wrapped) throws -> T?) rethrows -> T? {
        guard let unwrapped = self else { return nil }
        return try then(unwrapped)
    }
    
    /// (self 且 with 有值, 则返回解包后的结果「以元组类型返回」, 否则返回 nil).
    ///
    ///     let hello: String? = "hello"
    ///     let world: String? = "world"
    ///     hello.zip2(with: world) -> ("hello", "world")
    func zip2<A>(with other: Optional<A>) -> (Wrapped, A)? {
        guard let first = self, let second = other else { return nil }
        return (first, second)
    }
    
    /// (self 且 with 且 another 都有值, 则返回解包后的结果「以元组类型返回」, 否则返回 nil).
    ///
    ///     let hello: String? = "hello"
    ///     let world: String? = "world"
    ///     let done: String? = "."
    ///     hello.zip3(with: world, another: done) -> ("hello", "world", ".")
    func zip3<A, B>(with other: Optional<A>, another: Optional<B>) -> (Wrapped, A, B)? {
        guard let first = self,
            let second = other,
            let third = another else { return nil }
        return (first, second, third)
    }
    
    /// (self 有值则执行 some 闭包).
    func on(some: (_ unwrapped: Wrapped) throws -> Void) rethrows {
        if self != nil { try some(self!) }
    }
    
    /// (self 为 nil 则执行 none 闭包).
    func on(none: () throws -> Void) rethrows {
        if self == nil { try none() }
    }
    
    /// (self 有值且条件成立时返回自身, 否则返回 nil).
    ///
    ///     let str: String? = "a"
    ///     str.filter({ $0 == "a" }) -> Optional("a")
    ///     str.filter({ $0 == "0" }) -> nil
    func filter(_ predicate: (Wrapped) throws -> Bool) rethrows -> Wrapped? {
        guard let unwrapped = self,
            try predicate(unwrapped) else { return nil }
        return self
    }
    
    /// (强制解包, 失败则触发 fatalError(message)).
    func despair(_ message: String) -> Wrapped {
        guard let value = self else { fatalError(message) }
        return value
    }
    
    /// (also 条件成立时返回解包值, 否则返回 nil).
    func also(_ also: (Wrapped) throws -> Bool) rethrows -> Wrapped? {
        guard let unwrapped = self, try also(unwrapped) else { return nil }
        return unwrapped
    }
}

public extension Optional where Wrapped == Bool {
    
}

public extension Optional where Wrapped == String {
    
    /// Returns "", if the optional value isNone
    var orEmpty: String {
        return self ?? ""
    }
    
}

public extension Optional where Wrapped: Collection {
    
    var unwrapCount: Int {
        return self?.count ?? 0
    }
}

public extension Optional where Wrapped: Any {
    
    var string: String? {
        return self as? String
    }
    var stringValue: String {
        return self as! String
    }
    
    var int: Int? {
        return self as? Int
    }
    var intValue: Int {
        return self as! Int
    }
    
    var float: Float? {
        return self as? Float
    }
    var floatValue: Float {
        return self as! Float
    }
    
    var cgFloat: CGFloat? {
        return self as? CGFloat
    }
    var cgFloatValue: CGFloat {
        return self as! CGFloat
    }
    
    var size: IWSize? {
        return self as? IWSize
    }
    var sizeValue: IWSize {
        return self as! IWSize
    }
}
