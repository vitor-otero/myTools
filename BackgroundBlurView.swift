//
//  BackgroundBlurView.swift
//  
//
//  Created by Vítor Otero on 26/05/2023.
//

import SwiftUI

///Creates a BackgroundBlurView instead of color.
///```
/// BackgroundBlurView(blurStyle: .light)
/// }.background(BackgroundBlurView(blurStyle: .light))
///```
struct BackgroundBlurView: UIViewRepresentable {
    
    let blurStyle: UIBlurEffect.Style
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
    
    func makeUIView(context: Context) -> UIView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }
}

