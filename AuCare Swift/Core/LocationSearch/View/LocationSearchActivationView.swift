//
//  LocationSearchActivationView.swift
//  AuCare Swift
//
//  Created by Zitao Guan on 9/8/23.
//

import SwiftUI

struct LocationSearchActivationView: View {
    var body: some View {
        HStack{
            
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color.purple)
                .font(.system(size: 16))
                .padding(.horizontal)
            
            Text("Care Where?")
                .foregroundColor(Color(.darkGray))
            
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width - 64,
            height: 50)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(color: .black, radius: 6)
        )
    }
}

struct LocationSearchActivationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchActivationView()
    }
}
