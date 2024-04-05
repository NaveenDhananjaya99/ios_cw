//
//  CategoryView.swift
//  IosCW
//
//  Created by Naveen Dhananjaya on 2024-03-21.
//

import SwiftUI

struct CategoryView: View {
    var isSelected : Bool = false
    var title : String = "All"
    let darkGreen = Color(red: 0.0, green: 0.5, blue: 0.0)
    var body: some View {
        VStack{
            Text(title)
                .font(.system(size: 18))
                .multilineTextAlignment(.center)
                .foregroundColor(isSelected ?darkGreen : Color.black.opacity(0.5))
            
            if isSelected{
                Rectangle()
                    .foregroundColor(.black)
                    .frame(width: 5,height: 5)
                    .rotationEffect(Angle(degrees: 45))
            }
        }
    }
}

#Preview {
    CategoryView()
}
