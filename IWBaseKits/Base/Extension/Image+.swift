//
//  Image+.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/4/3.
//  Copyright © 2019 iWECon. All rights reserved.
//

#if os(macOS)
    import Cocoa
    public typealias IWImage = NSImage
#else
    import UIKit
    public typealias IWImage = UIImage
#endif

public extension IWImage {
    
    /// (获取图片均色, 原理：将图片压缩至 1x1, 然后取色值, 如果获取的颜色比较淡, 可使用 iwe.colorWithoutAlpha 转换).
    var averageColor: IWColor? {
        #if swift(>=4.1)
        let data = UnsafeMutableRawPointer.allocate(byteCount: 4, alignment: 1) // unsigned char = 4 bytes
        #else
        let data = UnsafeMutableRawPointer.allocate(bytes: 4, alignedTo: 1) // unsigned char = 4 bytes
        #endif
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        guard let context = CGContext.init(data: data, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Big.rawValue) else {
            assertionFailure("非法 context.")
            return nil
        }
        #if os(macOS)
        let cgimg = self.cgImage(forProposedRect: MakeRect(0, 0, 1, 1), context: context, hints: nil)
        #else
        let cgimg = self.cgImage
        #endif
        context.draw(cgimg!, in: MakeRect(0, 0, 1, 1))
        let rgba = Array(UnsafeBufferPointer(start: data.assumingMemoryBound(to: UInt8.self), count: 4))
        if rgba[3] > 0 {
            let r = CGFloat(rgba[0]) / CGFloat(rgba[3])
            let g = CGFloat(rgba[1]) / CGFloat(rgba[3])
            let b = CGFloat(rgba[2]) / CGFloat(rgba[3])
            let a = CGFloat(rgba[3]) / 255
            return IWColor.init(red: r, green: g, blue: b, alpha: a)
        }
        let r = CGFloat(rgba[0]) / 255
        let g = CGFloat(rgba[1]) / 255
        let b = CGFloat(rgba[2]) / 255
        let a = CGFloat(rgba[3]) / 255
        return IWColor.init(red: r, green: g, blue: b, alpha: a)
    }
    
}


#if os(macOS)
// MARK:- macOS Function
public extension IWImage {
    
    /// (加载 icns 图片组).
    ///
    /// - Parameter filePath: icns文件路径
    /// - Returns: 返回 icns 中的图片组
    static func load(icns filePath: String?) -> [NSImageRep]? {
        guard let fp = filePath else { return nil }
        guard let loads = IWImage.init(contentsOfFile: fp) else { return nil }
        return loads.representations
    }
    
}

public extension Array where Element: NSImageRep {
    
    
    /// (自动获取图片).
    ///
    /// - Parameters:
    ///   - size: 图片size的最大值
    ///   - pixels: 最大pixels
    /// - Returns: 找到了返回图片，没找到返回nil
    func autoGetImage(maxSize size: CGSize, pixels: Int) -> Image? {
        var sizeWidth = size.width
        var sizeHeight = size.height
        var _pixels = pixels
        var imgReps = self.filter({ $0.size.equalTo(MakeSize(sizeWidth, sizeHeight)) && $0.pixelsHigh == _pixels && $0.pixelsWide == _pixels })
        while imgReps.count == 0 {
            _pixels = _pixels / 2
            imgReps = self.filter({ $0.size.equalTo(MakeSize(sizeWidth, sizeHeight)) && $0.pixelsHigh == _pixels && $0.pixelsWide == _pixels })
            if imgReps.count == 0 {
                sizeWidth = sizeWidth / 2
                sizeHeight = sizeHeight / 2
                imgReps = self.filter({ $0.size.equalTo(MakeSize(sizeWidth, sizeHeight)) && $0.pixelsHigh == _pixels && $0.pixelsWide == _pixels })
            }
            
            if sizeWidth < 8 && sizeHeight < 8 { break }
        }
        // 确实没有找到指定参数的图片
        if imgReps.count == 0 { return nil }
        
        let newImage = Image.init(size: MakeSize(sizeWidth, sizeHeight))
        newImage.addRepresentation(imgReps[0])
        return newImage
    }
    
}


#else

// MARK:- unmacOS Variable
public extension IWImage {
    
    /// (图片大小, Bytes).
    var bytesSize: Int {
        return self.jpegData(compressionQuality: 1)?.count ?? 0
    }
    
    /// (图片大小, KBytes).
    var kilobytesSize: Int {
        return bytesSize / 1024
    }
    
    var original: IWImage {
        return withRenderingMode(.alwaysOriginal)
    }
    var template: IWImage {
        return withRenderingMode(.alwaysTemplate)
    }
    
    
    /// (将图片置灰色).
    var grayImage: UIImage? {
        let width = self.size.width * self.scale
        let height = self.size.height * self.scale
        let colorSpace: CGColorSpace = CGColorSpaceCreateDeviceGray()
        let context = CGContext.init(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGBitmapInfo.init(rawValue: 0 << 12).rawValue)
        
        guard let ct = context else { return nil }
        let imageRect = CGRect(x: 0, y: 0, width: width, height: height)
        ct.draw(self.cgImage!, in: imageRect)
        
        var grayi: UIImage? = nil
        let imageRef: CGImage = UIImage.init(cgImage: ct.makeImage()!).cgImage!
        if self.opaque {
            grayi = UIImage.init(cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)
        } else {
            guard let alphaContext = CGContext.init(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGImageAlphaInfo.alphaOnly.rawValue) else {
                return nil
            }
            alphaContext.draw(self.cgImage!, in: imageRect)
            guard let mask = alphaContext.makeImage() else {
                return nil
            }
            guard let maskedGrayImageRef = imageRef.masking(mask) else {
                return nil
            }
            grayi = UIImage.init(cgImage: maskedGrayImageRef, scale: self.scale, orientation: self.imageOrientation)
            
            guard let gi = grayi else {
                return nil
            }
            UIGraphicsBeginImageContextWithOptions(gi.size, false, gi.scale)
            gi.draw(in: imageRect)
            grayi = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return grayi
        }
        return grayi
    }
    
    /// (是否包含透明通道).
    var opaque: Bool {
        guard let alphaInfo = self.cgImage?.alphaInfo else { return false }
        let opq = (alphaInfo == CGImageAlphaInfo.noneSkipLast) || (alphaInfo == CGImageAlphaInfo.noneSkipFirst) || (alphaInfo == CGImageAlphaInfo.none)
        return opq
    }
}


// MARK:- unmacOS Function
public extension IWImage {
    
    /// (设置图片的透明度).
    ///
    /// - Parameter alpha: 透明度
    /// - Returns: 返回一张设置了透明度的图片
    func alpha(_ alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        guard UIGraphicsGetCurrentContext() != nil else {
            assertionFailure("非法 context.")
            return nil
        }
        let drawingRect = MakeRect(0, 0, self.size.width, self.size.height)
        self.draw(in: drawingRect, blendMode: CGBlendMode.normal, alpha: alpha)
        let imgOut = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imgOut
    }
    
    /// (保持当前图片的形状不变, 使用指定的颜色去重新渲染它).
    ///
    /// - Parameter tintColor: 用于渲染的颜色
    /// - Returns: 与当前图片形状一致但颜色与参数 tintColor 相同的新图片
    func tintColor(_ tintColor: UIColor) -> UIImage? {
        let imgIn = self
        let rect = MakeRect(0, 0, imgIn.size.width, imgIn.size.height)
        UIGraphicsBeginImageContextWithOptions(imgIn.size, self.opaque, imgIn.scale)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            assertionFailure("非法 context.")
            return nil
        }
        context.translateBy(x: 0, y: imgIn.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(CGBlendMode.normal)
        context.clip(to: rect, mask: imgIn.cgImage!)
        context.setFillColor(tintColor.cgColor)
        context.fill(rect)
        let imgOut = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imgOut
    }
    
    /// (保持当前图片的形状和纹理不变, 使用指定的颜色去重新渲染它).
    ///
    /// - Parameter blendColor: 用于渲染的颜色
    /// - Returns: 返回一张与当前图片形状纹理一致的经过 blendColor 颜色渲染的图片
    func blendColor(_ blendColor: UIColor) -> UIImage? {
        guard let coloredImage = self.tintColor(blendColor) else { return nil }
        guard let filter = CIFilter.init(name: "CIColorBlendMode") else { return nil }
        filter.setValue(CIImage.init(cgImage: self.cgImage!), forKey: kCIInputBackgroundImageKey)
        filter.setValue(CIImage.init(cgImage: coloredImage.cgImage!), forKey: kCIInputImageKey)
        guard let outputImage = filter.outputImage else { return nil }
        let context = CIContext.init(options: nil)
        guard let imageRef = context.createCGImage(outputImage, from: outputImage.extent) else { return nil }
        let resultImage = UIImage.init(cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)
        return resultImage
    }
    
    // Start -----------
    /// (二维码大小).
    enum QRCodeLogoImageSizeType {
        case big
        case small
        case none
    }
    /// Generate QRCode with txt.
    /// (生成二维码).
    static func generateQRCode(withContent content: String, withSize size: CGFloat, logoImage: UIImage?, logoSizeType sizeType: QRCodeLogoImageSizeType) -> UIImage? {
        guard let filter = CIFilter.init(name: "CIQRCodeGenerator") else {
            return nil
        }
        filter.setDefaults()
        
        let data = content.data(using: .utf8)
        filter.setValue(data, forKey: "inputMessage") // 通过kvo给一个字符串生成二维码
        filter.setValue("H", forKey: "inputCorrectionLevel") // 设置二维码的纠错水平，越高纠错水平越高，可以污损的范围越大
        
        guard let outputImage = filter.outputImage else { return nil }
        return self.createNoneInterpolatedUIImage(from: outputImage, withSize: size, logoImage: logoImage, withLogoSizeType: sizeType)
    }
    /// (创建非插值UII图).
    static func createNoneInterpolatedUIImage(from ciimage: CIImage, withSize size: CGFloat, logoImage: UIImage?, withLogoSizeType sizeType: QRCodeLogoImageSizeType) -> UIImage? {
        let extent = ciimage.extent
        let scale = min(size / extent.width, size / extent.height)
        
        // create bitmap
        let wid = extent.width * scale
        let hei = extent.height * scale
        
        // create one DeviceGray colorSpace
        let colorSpace = CGColorSpaceCreateDeviceGray()
        guard let bitmapRef = CGContext.init(data: nil, width: Int(wid), height: Int(hei), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) else { return nil }
        
        let context = CIContext.init(options: nil)
        // create CoreGraphics image
        guard let bitmapImage = context.createCGImage(ciimage, from: extent) else { return nil }
        bitmapRef.interpolationQuality = .none
        bitmapRef.scaleBy(x: scale, y: scale)
        bitmapRef.draw(bitmapImage, in: extent)
        
        // make bitmap to CGImage
        guard let scaledImage = bitmapRef.makeImage() else { return nil }
        
        // original image
        let outputImage = UIImage.init(cgImage: scaledImage)
        
        guard let logoImg = logoImage else { return outputImage }
        
        // add logo
        // calc logo size
        
        var logoRect: CGRect = .zero
        var logWid = outputImage.size.width * 0
        switch sizeType {
        case .none: // no
            return outputImage
        case .small: // 12%
            logWid = outputImage.size.width * 0.12
        case .big: // 24%
            logWid = outputImage.size.width * 0.24
        }
        let logX = (size - logWid) / 2
        logoRect = MakeRect(logX, logX, logWid, logWid)
        
        // create drawing board
        UIGraphicsBeginImageContextWithOptions(outputImage.size, false, UIScreen.main.scale)
        outputImage.draw(in: MakeRect(0, 0, size, size))
        logoImg.draw(in: logoRect)
        let newPic = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newPic
    }
    // Ended -----------
    
    
    /// (缩放图像至 size 大小).
    ///
    /// - Parameters:
    ///   - size: 缩放至 ... 大小
    ///   - opaque: 是否透明, 默认为不透明
    /// - Returns: 返回缩放后的图像, 可能为nil
    func scale(to size: CGSize, opaque: Bool = false) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        self.draw(in: size.rect)
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage
    }
}
#endif
