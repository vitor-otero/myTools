//
//  GifView.swift
//  
//
//  Created by Vítor Otero on 26/05/2023.
//

import SwiftUI
import UIKit
import ImageIO
import MobileCoreServices


///Loads a gif image and set frameVelocity
///```
/// GIFView(gifName: String, frameVelocity: 0.030)
/// frameVelocity 0.1 slow -  0.03 fast
///```
struct GIFView: UIViewRepresentable {
    let gifName: String
    let frameVelocity: Double
    
    func makeUIView(context: UIViewRepresentableContext<GIFView>) -> UIImageView {
        return UIImageView()
    }
    
    func updateUIView(_ uiView: UIImageView, context: UIViewRepresentableContext<GIFView>) {
        guard let gifURL = Bundle.main.url(forResource: gifName, withExtension: "gif"),
              let imageData = try? Data(contentsOf: gifURL),
              let source = CGImageSourceCreateWithData(imageData as CFData, nil)
        else {
            return
        }
        
        var images: [UIImage] = []
        let frameCount = CGImageSourceGetCount(source)
        
        for i in 0..<frameCount {
            guard let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil),
                  let properties = CGImageSourceCopyPropertiesAtIndex(source, i, nil) as? [String: Any],
                  let gifInfo = properties[kCGImagePropertyGIFDictionary as String] as? [String: Any],
                  let delayTime = gifInfo[kCGImagePropertyGIFDelayTime as String] as? Double
            else {
                continue
            }
            
            let image = UIImage(cgImage: cgImage)
            images.append(image)
            
            let velocity = delayTime * frameVelocity
            let frameDuration = CFTimeInterval(velocity)
            let frameDurationValue = NSNumber(value: frameDuration)
            let frameProperties = [kCGImagePropertyGIFDictionary as String: [kCGImagePropertyGIFDelayTime as String: frameDurationValue]]
            
            if let destination = CGImageDestinationCreateWithURL(gifURL as CFURL, kUTTypeGIF, frameCount, nil) {
                CGImageDestinationAddImage(destination, cgImage, frameProperties as CFDictionary)
                CGImageDestinationFinalize(destination)
            }
        }
        
        uiView.animationImages = images
        uiView.animationDuration = frameVelocity * Double(frameCount)
        uiView.startAnimating()
    }
}


