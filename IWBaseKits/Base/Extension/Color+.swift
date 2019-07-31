//
//  Color+.swift
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

#if !os(watchOS)
    import CoreImage
#endif

public extension IWColor {
    
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
    }
    
    @available(iOS 9.3, *)
    convenience init(hex: UInt) {
        let limit = 255.0.cgFloat
        let r: CGFloat = CGFloat((hex & 0xFF0000) >> 24) / limit
        let g: CGFloat = CGFloat((hex & 0x00FF00) >> 16) / limit
        let b: CGFloat = CGFloat((hex & 0x0000FF) >> 8) / limit
        self.init(red: r, green: g, blue: b)
    }
    
    @available(OSX 10.12, *)
    convenience init(hex: Int) {
        self.init(red: CGFloat((hex >> 16) & 0xFF), green: CGFloat((hex >> 8) & 0xFF), blue: CGFloat(hex & 0xFF))
    }
    
    /// (返回一个随机颜色).
    static var random: IWColor {
        let red = CGFloat(arc4random() % 255) / 255.0
        let gre = CGFloat(arc4random() % 255) / 255.0
        let blu = CGFloat(arc4random() % 255) / 255.0
        return IWColor(red: red, green: gre, blue: blu, alpha: 1.0)
    }
    
    /// (返回一个随机的暗色).
    static var randomWithDark: IWColor {
        var randomColor = IWColor.random
        while !randomColor.isDark {
            randomColor = IWColor.random
        }
        return randomColor
    }
    
    /// (返回一个随机的亮色).
    static var randomWithLight: IWColor {
        var randomColor = IWColor.random
        while !randomColor.isLight {
            randomColor = IWColor.random
        }
        return randomColor
    }
    
    /// (返回当前颜色的反色).
    final var inverseColor: IWColor? {
        guard let componentColors = self.cgColor.components else { return nil }
        let newColor = IWColor.init(red: 1.0 - componentColors[0], green: 1.0 - componentColors[1], blue: 1.0 - componentColors[3], alpha: componentColors[3])
        return newColor
    }
    
    /// (是否为暗色).
    final var isDark: Bool {
        var red: CGFloat = 0.0, gre: CGFloat = 0.0, blu: CGFloat = 0.0, alpha: CGFloat = 0.0
        self.getRed(&red, green: &gre, blue: &blu, alpha: &alpha)
        let referenceValue: CGFloat = 0.411
        let colorDelta = (red * 0.299) + (gre * 0.587) + (blu * 0.114)
        return (1.0 - colorDelta) > referenceValue
    }
    
    /// (是否为亮色).
    final var isLight: Bool {
        return !isDark
    }
    
    #if os(iOS)
    /// (返回当前颜色 红色 通道的值).
    final var redChannel: CGFloat {
        var r: CGFloat = 0
        if self.getRed(&r, green: nil, blue: nil, alpha: nil) {
            return r
        }
        return 0
    }
    
    /// (返回当前颜色 绿色 通道的值).
    final var greenChannel: CGFloat {
        var g: CGFloat = 0
        if self.getRed(nil, green: &g, blue: nil, alpha: nil) {
            return g
        }
        return 0
    }
    
    /// (返回当前颜色 蓝色 通道的值).
    final var blueChannel: CGFloat {
        var b: CGFloat = 0
        if self.getRed(nil, green: nil, blue: &b, alpha: nil) {
            return b
        }
        return 0
    }
    
    /// (返回当前颜色 透明 通道的值).
    final var alphaChannel: CGFloat {
        var a: CGFloat = 0
        if self.getRed(nil, green: nil, blue: nil, alpha: &a) {
            return a
        }
        return 0
    }
    
    /// (返回当前颜色 hue 通道的值).
    final var hueChannel: CGFloat {
        var h: CGFloat = 0
        if self.getHue(&h, saturation: nil, brightness: nil, alpha: nil) {
            return h
        }
        return 0
    }
    
    
    /// (返回当前颜色16进制代码, 通道排序为 RGBA).
    final var hex: String {
        let a = self.alphaChannel, r = self.redChannel, g = self.greenChannel, b = self.blueChannel
        let hexA = self.alignColor(hexString: String.hex(string: NSInteger(a)))
        let hexR = self.alignColor(hexString: String.hex(string: NSInteger(r)))
        let hexG = self.alignColor(hexString: String.hex(string: NSInteger(g)))
        let hexB = self.alignColor(hexString: String.hex(string: NSInteger(b)))
        return "#\(hexR)\(hexG)\(hexB)\(hexA)"
    }
    #endif
    
    /// (补齐单色值, 例如 "F" 会补齐为 "0F").
    func alignColor(hexString: String) -> String {
        return hexString.count < 2 ? "0\(hexString)" : hexString
    }
    
    #if os(iOS)
    /// (返回去除 透明 通道后的颜色).
    final var colorWithoutAlpha: IWColor? {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        if self.getRed(&r, green: &g, blue: &b, alpha: nil) {
            return IWColor.init(red: r, green: g, blue: b, alpha: 1.0)
        }
        return nil
    }
    
    
    /// (返回当前颜色 saturation 通道的值).
    final var saturation: CGFloat {
        var s: CGFloat = 0
        if self.getHue(nil, saturation: &s, brightness: nil, alpha: nil) {
            return s
        }
        return 0
    }
    
    /// (返回当前颜色 brightness 通道的值).
    final var brightness: CGFloat {
        var b: CGFloat = 0
        if self.getHue(nil, saturation: nil, brightness: &b, alpha: nil) {
            return b
        }
        return 0
    }
    #endif
    
    #if os(iOS)
    /// (返回一张 4x4 的纯色图片).
    final var image: UIImage? {
        return self.image(withColor: self, cornerRadius: 0)
    }
    #endif
    
}

public extension IWColor {
    
    /// (按钮默认的蓝色).
    static var defaultOfButton: IWColor {
        return IWColor(red: 0, green: 0.478431, blue: 1, alpha: 1)
    }
    
    /// (十六进制颜色).
    static func hex(_ hex: String, _ alpha: CGFloat = 1.0) -> IWColor {
        var color = IWColor.red
        var cStr : String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if cStr.hasPrefix("#") {
            let index = cStr.index(after: cStr.startIndex)
            cStr = String(cStr[index...]) //cStr.iwe.substring(from: index)
        }
        if cStr.count != 6 {
            return IWColor.black
        }
        
        let rRange = cStr.startIndex ..< cStr.index(cStr.startIndex, offsetBy: 2)
        let rStr = String(cStr[rRange]) //cStr.iwe.substring(with: rRange)
        
        let gRange = cStr.index(cStr.startIndex, offsetBy: 2) ..< cStr.index(cStr.startIndex, offsetBy: 4)
        let gStr = String(cStr[gRange]) //cStr.iwe.substring(with: gRange)
        
        let bIndex = cStr.index(cStr.endIndex, offsetBy: -2)
        let bStr = String(cStr[bIndex...]) //cStr.iwe.substring(from: bIndex)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rStr).scanHexInt32(&r)
        Scanner(string: gStr).scanHexInt32(&g)
        Scanner(string: bStr).scanHexInt32(&b)
        
        color = IWColor(red: CGFloat(r) / 255.0,
                        green: CGFloat(g) / 255.0,
                        blue: CGFloat(b) / 255.0,
                        alpha: CGFloat(alpha))
        return color
    }
    
    static func hex(_ hex: UInt, _ alpha: CGFloat = 1.0) -> IWColor {
        
        let limit = 255.0.cgFloat
        let r: CGFloat = CGFloat((hex & 0xFF000000) >> 24) / limit
        let g: CGFloat = CGFloat((hex & 0x00FF0000) >> 16) / limit
        let b: CGFloat = CGFloat((hex & 0x0000FF00) >> 8) / limit
        return IWColor(red: r, green: g, blue: b, alpha: alpha)
    }
    
    #if os(iOS)
    /// (返回一张自定义的纯色图片).
    ///
    /// - Parameters:
    ///   - color: 图片颜色
    ///   - size: 图片大小, 默认为 4x4
    ///   - cornerRadius: 图片圆角
    /// - Returns: 图片, 可能为nil
    final func image(withColor color: IWColor?, size: CGSize = IWSize(width: 4, height: 4), cornerRadius: CGFloat) -> UIImage? {
        func removeFloatMin(_ floatValue: CGFloat) -> CGFloat {
            return floatValue == CGFloat.min ? 0 : floatValue
        }
        func flatSpecificScale(_ floatValue: CGFloat, _ scale: CGFloat) -> CGFloat {
            let fv = removeFloatMin(floatValue)
            let sc = (scale == 0 ? UIScreen.main.scale : scale)
            let flattedValue = ceil(fv * sc) / sc
            return flattedValue
        }
        func flat(_ floatValue: CGFloat) -> CGFloat {
            return flatSpecificScale(floatValue, 0)
        }
        let sz = IWSize(width: flat(size.width), height: flat(size.height))
        if sz.width < 0 || sz.height < 0 { assertionFailure("CGPostError, 非法的 size") }
        
        var resultImage: UIImage? = nil
        let co = (color != nil ? color! : IWColor.clear)
        
        let opaque = (cornerRadius == 0.0 && co.alphaChannel == 1.0)
        UIGraphicsBeginImageContextWithOptions(sz, opaque, 0)
        guard let context = UIGraphicsGetCurrentContext() else {
            assertionFailure("非法 context.")
            return nil
        }
        context.setFillColor(co.cgColor)
        
        if cornerRadius > 0 {
            let path = UIBezierPath.init(roundedRect: sz.rect, cornerRadius: cornerRadius)
            path.addClip()
            path.fill()
        } else {
            context.fill(sz.rect)
        }
        
        resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resultImage
    }
    #endif
    
    /// (.withAlphaComponent()).
    func alpha(_ value: CGFloat) -> IWColor {
        return self.withAlphaComponent(value)
    }
}
