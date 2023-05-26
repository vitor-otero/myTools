//
//  Color.swift
//  
//
//  Created by Vítor Otero on 26/05/2023.
//

import Foundation
import SwiftUI


    // .foregroundColor(Color.theme.accent)
extension Color {
    
    static let theme = ColorTheme()
    
}

struct ColorTheme {
    
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryText = Color("SecondaryTextColor")
    
}

