//
//  SideView.swift
//  IosCW
//
//  Created by Naveen Dhananjaya on 2024-03-23.
//

import SwiftUI

struct SideView: View {
    @Binding var isShowing: Bool
    var content: AnyView
    var direction: Edge
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if isShowing {
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                
                content.transition(.move(edge: direction))
                    .background(
                        Color.white
                    )
            }
        }
        .frame( maxWidth:  .infinity,  maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
//        .animation(.easeInOut, value: Equatable)
    }
}


