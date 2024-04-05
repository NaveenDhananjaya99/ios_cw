//
//  FooterView.swift
//  IosCW
//
//  Created by Naveen Dhananjaya on 2024-03-23.
//

import SwiftUI

struct FooterView: View {
    var body: some View {
        VStack{
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(height: 150)
                .padding()
                .padding(.top,10)
            Text("Explore more with us...")
        }
    }
}

#Preview {
    FooterView()
}
