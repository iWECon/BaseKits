//
//  BasicType+.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/4/3.
//  Copyright © 2019 iWECon. All rights reserved.
//

#if os(macOS)
    import Cocoa
    public typealias IWSize = NSSize
#else
    import UIKit
    public typealias IWSize = CGSize
#endif
import Foundation

protocol BasicTypeable {
    var string: String { get }
}

extension BasicTypeable {
    var string: String {
        return "\(self)"
    }
}

extension CGFloat: BasicTypeable { }
extension Float: BasicTypeable { }
extension Int: BasicTypeable { }

// MARK:- CGFloat
public extension CGFloat {
    
    var float: Float {
        return Float(self)
    }
    
    static let min = CGFloat.leastNormalMagnitude
    static let max = CGFloat.greatestFiniteMagnitude
}

// MARK:- Float
public extension Float {
    
    static let min = Float.leastNormalMagnitude
    static let max = Float.greatestFiniteMagnitude
    
    var cgFloat: CGFloat {
        return CGFloat(self)
    }
    
    var int: Int {
        return Int(self)
    }
    var double: Double {
        return Double(self)
    }
    /// (保留两位小数).
    var retain: String {
        return String(format: "%.2f", self)
    }
    /// (保留 digit 位小数).
    func retain(_ digit: Int) -> String {
        return String(format: "%.\(digit)f", self)
    }
}

// MARK:- Int
public extension Int {
    
    var float: Float {
        return Float(self)
    }
    
    var cgFloat: CGFloat {
        return CGFloat(self)
    }
    
    /// (返回一个 0 ..< self 的区间).
    var countableRange: CountableRange<Int> {
        return 0 ..< self
    }
    /// (返回一个 0 ... self 的区间).
    var closeRange: ClosedRange<Int> {
        return 0 ... self
    }
    
    /// (随机取一个从 from - to 之间的数)
    static func random(from: Int = 0, to: Int) -> Int {
        guard from < to else { return 0 }
        return Int(arc4random() % UInt32(to)) + from
    }
    static var random: Int {
        return Int(arc4random() % 100) + 1
    }
    
    /// (是否为质数).
    ///     质数定义为在大于1的自然数中，除了1和它本身以外不再有其他因数。
    var isPrime: Bool {
        if self == 2 { return true }
        guard self > 1, self % 2 != 0 else { return false }
        
        let base = Int(sqrt(Double(self)))
        for i in Swift.stride(from: 3, through: base, by: 2) where self % i == 0 {
            return false
        }
        return true
    }
}

// MARK:- CGSize/NSSize
public extension IWSize {
    
    var rect: CGRect {
        return CGRect(x: 0, y: 0, width: self.width, height: self.height)
    }
    
    var bounds: CGRect {
        return rect
    }
    
    /// (是否为空, width<=0 && height<=0 则为空).
    var isZero: Bool {
        return isWidthZero && isHeightZero
    }
    
    /// (value.width <= 0).
    var isWidthZero: Bool {
        return self.width <= 0
    }
    
    /// (value.height <= 0).
    var isHeightZero: Bool {
        return self.height <= 0
    }
}

// MARK:- Bool
public extension Bool {
    
    /// (随机一个 ture or false)
    static var random: Bool {
        return arc4random_uniform(2) == 1
    }
    
    /// (Returns !self)
    var inversed: Bool {
        return !self
    }
    
    /// (bool = true).
    mutating func enable() -> Void {
        self = true
    }
    /// (bool = false).
    mutating func disable() -> Void {
        self = false
    }
    
    var yesOrNo: String {
        return self ? "是" : "否"
    }
    
    /// (或)
    /// eg: a || b || c || d
    /// ->: a.or(b).or(c).or(d)
    ///
    /// - Parameter other: 条件
    /// - Returns: 最总结果
    func or(_ other: @autoclosure () -> Bool) -> Bool {
        return self || other()
    }
    
    /// (或)
    /// eg: a || b || c || d
    /// ->: a.or(b).or(c).or(d)
    ///
    /// - Parameter other: 条件
    /// - Returns: 最总结果
    func or(_ other: (() -> Bool)) -> Bool {
        return self || other()
    }
    
    /// (且)
    /// eg: a && b && c && d
    /// ->: a.and(b).and(c).and(d)
    ///
    /// - Parameter other: 条件
    /// - Returns: 最终结果
    func and(_ other:@autoclosure () -> Bool) -> Bool {
        return self && other()
    }
    
    /// (且)
    /// eg: a && b && c && d
    /// ->: a.and(b).and(c).and(d)
    ///
    /// - Parameter other: 条件
    /// - Returns: 最终结果
    func and(_ other: (() -> Bool)) -> Bool {
        return self && other()
    }
}

// MARK:- SingedInteger
public extension SignedInteger {
    
    /// (取绝对值).
    var abs: Self { return Swift.abs(self) }
    /// (是否为正数, int > 0).
    var isPositive: Bool { return self > 0 }
    /// (是否为负数, int < 0).
    var isNegative: Bool { return self < 0 }
    /// (是否为偶数, (int % 2) == 0).
    var isEven: Bool { return (self % 2) == 0 }
    /// (是否为奇数, (int % 2) != 0).
    var isOdd: Bool { return (self % 2) != 0 }
    /// (Bool, value > 0?).
    var bool: Bool {
        return self > 0
    }
    
    var timeStr: String {
        guard self > 0 else { return "0 sec" }
        if self < 60 { return "\(self) sec" }
        if self < 3600 { return "\(self / 60) min" }
        let hours = self / 3600
        let mins = (self % 3600) / 60
        if hours != 0, mins == 0 {
            return "\(hours) h"
        }
        return "\(hours)h \(mins)m"
    }
    
    var size: IWSize {
        let wh = CGFloat(Int(self))
        return IWSize(width: wh, height: wh)
    }
}

// MARK:- FloatingPoint
public extension FloatingPoint {
    
    /// (取绝对值).
    var abs: Self { return Swift.abs(self) }
    /// (是否为正数).
    var isPositive: Bool { return self > 0 }
    /// (是否为负数).
    var isNegative: Bool { return self < 0 }
    /// (向上取整).
    var ceil: Self { return Foundation.ceil(self) }
    /// (向下取整).
    var floor: Self { return Foundation.floor(self) }
    
}

// MARK:- Double
public extension Double {
    
    var int: Int {
        return Int(self)
    }
    var float: Float {
        return Float(self)
    }
    var cgFloat: CGFloat {
        return CGFloat(self)
    }
    
    var string: String {
        return "\(self)"
    }
    /// (保留两位小数).
    var retain: String {
        return String(format: "%.2f", self)
    }
    /// (保留 digit 位小数).
    func retain(_ digit: Int) -> String {
        return String(format: "%.\(digit)f", self)
    }
    
    
}

// MARK:- Optional String
public extension Optional where Wrapped == String {
    
    /// Check if the value meets the conditions(process)
    ///
    /// - Parameter process: Check process.
    /// - Returns: Bool
    func check(_ process: (String) -> Bool) -> Bool {
        return process(self ?? "")
    }
}

// MARK:- String Variable
public extension String {
    
    var url: URL? {
        return URL.init(string: self)
    }
    
    var urlValue: URL {
        return url!
    }
    
    var urlRequest: URLRequest? {
        return self.url.and(then: { URLRequest.init(url: $0) })
    }
    var urlRequestValue: URLRequest {
        return urlRequest!
    }
    
    var anyClass: AnyClass? {
        return NSClassFromString(self)
    }
    
    /// Convert to NSString
    var nsString: NSString {
        return self as NSString
    }
    
    /// Convert to Int
    /// (转换为整数).
    ///     "123".toInt -> 123
    ///     "135abc35".toInt -> 135
    ///     "abc123".toInt -> 0
    var int: Int {
        let text = self.nsString
        return text.integerValue
    }
    /// Convert to Float
    var float: Float {
        let text = self.nsString
        return text.floatValue
    }
    /// Convert to UIColor
    var color: IWColor {
        return .hex(self)
    }
    /// Convert to UIColor
    func color(alpha: Float) -> IWColor {
        return .hex(self, alpha)
    }
    
    var fileURL: URL {
        return URL.init(fileURLWithPath: self)
    }
    
    var base64Encode: String? {
        return data(using: .utf8)?.base64EncodedString()
    }
    var base64EncodeValue: String {
        return base64Encode!
    }
    
    var base64: Data? {
        return data(using: .utf8)?.base64EncodedData()
    }
    var base64Value: Data? {
        return base64!
    }
    
    var base64Decode: String? {
        guard let decodeData = Data(base64Encoded: self) else { return nil }
        return String(data: decodeData, encoding: .utf8)
    }
    var base64DecodeValue: String {
        return base64Decode!
    }
    
    var urlEncode: String? {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
    var urlEncodeValue: String {
        return urlEncode!
    }
    
    /// (URL 解码).
    var urlDecode: String? {
        return removingPercentEncoding ?? nil
    }
    var urlDecodeValue: String {
        return urlDecode!
    }
    
    /// (获取最后一个字符串).
    var last: String {
        return (self.count == 1) ? self : self[self.index(before: self.endIndex)...].string
    }
    /// (移除最后一个字符串).
    var removeLast: String {
        guard self == "" else {
            var temp = self
            temp.remove(at: temp.index(before: temp.endIndex))
            return temp
        }
        return self
    }
    
    /// (获取文件名, 无扩展名).
    var lastPathNotHasPathExtension: String? {
        return (self as NSString).pathComponents.last.and(then: { ($0.nsString).deletingPathExtension })
    }
    /// (获取扩展名).
    var pathExtension: String {
        return (self as NSString).pathExtension
    }
    /// (获取文件名, 有扩展名).
    var lastPath: String {
        return (self as NSString).lastPathComponent
    }
    
    /// (第一个字符大写).
    var uppercaseFirst: String {
        return self.uppercased(with: Locale.current)
    }
    
    /// (是否为电子邮件).
    var isEmail: Bool {
        // http://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
        let email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"// "^[A-Z0-9a-z._%+-]+@[A-Za-z]{2,4}$"
        return self =~ email
    }
    
    /// (随机生成一个 32 位字符串).
    static var random32Bit: String {
        return String.random(32)
    }
    
    /// (返回词组).
    /// From SwifterSwift.
    ///     "Swift is so faster".words() -> ["Swift", "is", "so", "faster"]
    ///     "我 今天 吃了五碗饭".words() -> ["我", "今天", "吃了五碗饭"]
    ///     "我,今天,吃了五碗饭".words() -> ["我", "今天", "吃了五碗饭"]
    ///     "我-今天-吃了五碗饭".words() -> ["我", "今天", "吃了五碗饭"]
    ///     "我,今天-吃了五碗饭".words() -> ["我", "今天", "吃了五碗饭"]
    ///     "我今天吃了五碗饭".words() -> ["我今天吃了五碗饭"]
    var words: [String] {
        // https://stackoverflow.com/questions/42822838
        let chararacterSet = CharacterSet.whitespacesAndNewlines.union(.punctuationCharacters)
        let comps = components(separatedBy: chararacterSet)
        return comps.filter { !$0.isEmpty }
    }
    
    /// (返回出现次数最多的字符).
    var mostCommonCharacter: Character? {
        let mostCommon = reduce(into: [Character: Int]()) {
            let count = $0[$1].or(0)
            $0[$1] = count + 1
        }.max { $0.1 < $1.1 }?.0
        return mostCommon
    }
    
    /// (是否全为数字).
    var isNumber: Bool {
        return self =~ "^\\d$"
    }
    
    /// (是否为电话号码).
    var isPhoneNumber: Bool {
        return isCMCC.or(isCUCC).or(isCTCC)
    }
    /// (是否为移动号码段).
    var isCMCC: Bool {
        let cmcc = "^((13)[4-9]|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8])|(198))\\d{8}$"
        let fictitious_cmcc = "^(170[3,5-6])\\d{7}$" // 虚拟号码段
        return (self =~ cmcc).or(self =~ fictitious_cmcc)
    }
    /// (是否为联通号码段).
    var isCUCC: Bool {
        let cucc = "^((13)[0-2]|(145)|(15[5,6])|(166)|(17[5,6])|(18[5,6]))\\d{8}$"
        let fictitious_cucc = "^(170[4,7-9])\\d{7}|(171)\\d{8}$" // 虚拟号码段
        return (self =~ cucc).or(self =~ fictitious_cucc)
    }
    /// (是否为电信号码段).
    var isCTCC: Bool {
        let ctcc = "^((133)|(149)|(153)|(17[3,7])|(18[0,1,9])|(199))\\d{8}$"
        let fictitious_ctcc = "^(170[0-2])\\d{7}$" // 虚拟号码段
        return (self =~ ctcc).or(self =~ fictitious_ctcc)
    }
    
    
}

// MARK:- String Function
public extension String {
    
    /// Check if the value meets the conditions(process)
    ///
    /// - Parameter process: Check process.
    /// - Returns: Bool
    func check(_ process: (String) -> Bool) -> Bool {
        return process(self)
    }
    
    static func hex(string withInteger: NSInteger) -> String {
        var tempInteger = withInteger
        var hexStr = ""
        var remainder: NSInteger = 0
        for _ in 0 ..< 9 {
            remainder = tempInteger % 16
            tempInteger = tempInteger / 16
            let letter = self.hex(letterString: remainder)
            hexStr = "\(letter)\(hexStr)"
            if withInteger == 0 {
                break
            }
        }
        return hexStr
    }
    
    /// (10进制转16进制, integer < 16).
    static func hex(letterString withInteger: NSInteger) -> String {
        assert(withInteger < 16, "要转换的数必须是16进制里的个位数，即小于16，但你写的是 \(withInteger)")
        let hex = ["A", "B", "C", "D", "E", "F"]
        return (withInteger >= 10) ? hex[withInteger - 10] : "\(withInteger)"
    }
    
    /// (随机生成字符串).
    static func random(_ length: Int) -> String {
        guard length.isPositive else { return "" }
        let base = "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz0123456789"
        var randomString = ""
        for _ in 1 ... length {
            let randomIndex = arc4random_uniform(UInt32(base.count))
            let randomCharacter = Array(base)[Int(randomIndex)]
            randomString.append(randomCharacter)
        }
        return randomString
    }
    
    /// (本地语言).
    func localized(comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
    
}

// MARK:- Substring
public extension Substring {
    
    var string: String {
        return String(self)
    }
}

// MARK:- Data
public extension Data {
    
    var string: String? {
        return String(data: self, encoding: .utf8)
    }
    var stringValue: String {
        return string.despair("The date to string is nil.")
    }
    
    var json: Any? {
        let a = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
        Console.debug(a.any)
        return a
    }
    var jsonValue: Any {
        return json.despair("The date to json is nil.")
    }
    
    var base64Decode: String? {
        let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters)
        if data != nil {
            let decodeDataString = String(data: data!, encoding: .utf8)
            return decodeDataString ?? nil
        }
        return nil
    }
    var base64DecodeValue: String {
        return base64Decode.despair("The data to base64Decode is nil.")
    }
}
