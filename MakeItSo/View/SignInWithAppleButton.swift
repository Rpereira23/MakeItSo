//
//  SignInWithAppleButton.swift
//  MakeItSo
//
//  Created by Rick on 8/19/20.
//  Copyright © 2020 Rick. All rights reserved.
//

import Foundation
import SwiftUI
import AuthenticationServices


struct SignInWithAppleButton: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        return ASAuthorizationAppleIDButton(type: .signIn, style: .black)
    }
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
        
    }
    
}
