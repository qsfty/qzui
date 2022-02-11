//
// Created by 强子 on 2021/10/10.
//

//
// Created by 强子 on 2020/12/20.
//

import SwiftUI
import Photos
import QzLib

public class MyPhotoUtil {

    public static func loadUploadImage(_ source: PHAsset, complete: @escaping (UIImage) -> Void){

        DispatchQueue.global(qos: .background).async {
            let options = PHImageRequestOptions()
            options.isSynchronous = true
            // You can give your own Image size by replacing .init() to CGSize....
            let newWidth = MyUIUtil.fullWidth() * 3
            let newHeight = UIScreen.main.bounds.height * 1.5
            let cgsize: CGSize = CGSize(width: newWidth, height: newHeight)

            options.deliveryMode = .highQualityFormat
            options.isNetworkAccessAllowed = true
            options.resizeMode = .fast

            PHCachingImageManager.default().requestImage(for: source, targetSize: cgsize, contentMode: .aspectFit, options: options) { (image, _) in
                complete(image!)
            }
        }

    }

    public static func loadImage(_ source: PHAsset, complete: @escaping (UIImage) -> Void){
        DispatchQueue.global(qos: .background).async {
            let options = PHImageRequestOptions()
            options.isSynchronous = true

            options.deliveryMode = .highQualityFormat
            options.isNetworkAccessAllowed = true
            options.resizeMode = .fast
            // You can give your own Image size by replacing .init() to CGSize....
            let newWidth = MyUIUtil.fullWidth() * 2
            let newHeight = UIScreen.main.bounds.height * 2
            PHCachingImageManager.default().requestImage(for: source, targetSize: CGSize(width: newWidth, height: newHeight), contentMode: .aspectFit, options: options) { (image, _) in
                complete(image!)
            }
        }
    }


    public static func loadImage2(_ source: PHAsset, complete: @escaping (UIImage) -> Void){
        let options = PHImageRequestOptions()
        options.isSynchronous = true

        options.deliveryMode = .highQualityFormat
        options.isNetworkAccessAllowed = true
        options.resizeMode = .fast
        // You can give your own Image size by replacing .init() to CGSize....
        let newWidth = MyUIUtil.fullWidth() * 2
        let newHeight = UIScreen.main.bounds.height * 2
        PHCachingImageManager.default().requestImage(for: source, targetSize: CGSize(width: newWidth, height: newHeight), contentMode: .aspectFit, options: options) { (image, _) in
            complete(image!)
        }
    }


    public static func loadOriginImage(_ source: PHAsset, complete: @escaping (UIImage) -> Void){
        DispatchQueue.global(qos: .background).async {
            let options = PHImageRequestOptions()
            options.isSynchronous = true

            options.deliveryMode = .highQualityFormat
            options.isNetworkAccessAllowed = true
            options.resizeMode = .fast
            // You can give your own Image size by replacing .init() to CGSize....
            let newWidth = source.pixelWidth.toFloat()
            let newHeight = source.pixelHeight.toFloat()
            PHCachingImageManager.default().requestImage(for: source, targetSize: CGSize(width: newWidth, height: newHeight), contentMode: .aspectFit, options: options) { (image, _) in
                if(image != nil){
                    complete(image!)
                }
            }
        }
    }

    //必须在后台调用
    public static func loadSampleImage(_ source: PHAsset, complete: @escaping (UIImage) -> Void){
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        // You can give your own Image size by replacing .init() to CGSize....
        PHCachingImageManager.default().requestImage(for: source, targetSize: CGSize(width: 200, height: 200), contentMode: .aspectFill, options: options) { (image, _) in
            if(image != nil){
                complete(image!)
            }
        }
    }


    public static func getImageSize(_ source: PHAsset, complete: @escaping (ImageInfo) -> Void){
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        // You can give your own Image size by replacing .init() to CGSize....
        PHCachingImageManager.default().requestImage(for: source, targetSize: .init(), contentMode: .aspectFill, options: options) { (image, _) in
            getImageInfo(image: image!, complete: complete)
        }
    }


    public static func getImageInfo(image: UIImage, complete: @escaping (ImageInfo) -> Void){
        let size = (image.pngData()?.count)!.toFloat()
        let width = image.size.width
        let height = image.size.height
        complete(ImageInfo(width: width, height: height, size: size))
    }
}

public struct ImageInfo: Codable {

    var width: CGFloat
    var height: CGFloat
    var size: CGFloat

    public var showSize: String {
        if(size < 1024){
            return "\(size) Byte"
        }
        var v = size / 1024.0
        if(v < 1024){
            return "\(v.toFixed(2))Kb"
        }
        v = v / 1024.0
        return "\(v.toFixed(2))Mb"
    }
}


