//
//  IWRegex.swift
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

/// Regex correlation.
/// (正则表达式相关).
public class IWRegex: NSObject {
    
    /// is contain matching text?
    /// (是否包含匹配的文本).
    /// matches: expression(表达式)
    /// content: 被查找的文本
    class func match(_ matches: String, _ content: String) -> Bool {
        let regex = try? NSRegularExpression.init(pattern: matches, options: .caseInsensitive)
        if let matches = regex?.matches(in: content, options: .init(rawValue: 0), range: NSMakeRange(0, content.count)) {
            return matches.count > 0
        }
        return false
    }
    
    /// Matching exp, return finded str.
    /// (匹配表达式, 返回找到的字符串).
    class func expression(_ expression: String, content: String) -> String? {
        let tempBody = content
        do {
            let regex = try NSRegularExpression.init(pattern: expression, options: .caseInsensitive)
            let firstMatch = regex.firstMatch(in: tempBody, options: NSRegularExpression.MatchingOptions.init(rawValue: 0), range: NSMakeRange(0, tempBody.count))
            if let match = firstMatch {
                return (tempBody as NSString).substring(with: match.range)
            }
            return nil
        } catch {
            return nil
        }
    }
    
}
