//
//  MapViewActionButton.swift
//  AuCare Swift
//
//  Created by Zitao Guan on 9/8/23.
//

import SwiftUI

struct MapViewActionButton: View {
    @Binding var mapState: MapViewState
    var body: some View {
        Button{
            withAnimation(.spring()){
                actionForState(mapState)
            }
        } label: {
            Image(systemName: "arrow.left")
                .font(.title2)
                .foregroundColor(.black)
                .padding()
                .background(.white)
                .clipShape(Circle())
                .shadow(color: .black, radius: 6)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func actionForState(_ state: MapViewState){
        switch state{
        case .noInput:
            print("no input")
        case .searchingForLocation:
            mapState = .noInput
        case .locationSelected:
            print("Clear map view")
        }
    }
}

struct MapViewActionButton_Previews: PreviewProvider {
    static var previews: some View {
        MapViewActionButton(mapState: .constant(.noInput))
    }
}
