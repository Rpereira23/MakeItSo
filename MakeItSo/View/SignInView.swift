//
//  SignInView.swift
//  MakeItSo
//
//  Created by Rick on 8/19/20.
//  Copyright © 2020 Rick. All rights reserved.
//

import SwiftUI


struct SignInView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var coordinator: SignInWithAppleCoordinator?
    
    
    var body: some View {
        VStack {
            Spacer()
            SignInWithAppleButton()
                .frame(width: 280, height: 45)
                .onTapGesture {
                    self.coordinator = SignInWithAppleCoordinator()
                    if let coordinator = self.coordinator {
                        coordinator.startSignInWithAppleFlow {
                            print("Signed in...")
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
            }
            Spacer()
        }
    }
}
