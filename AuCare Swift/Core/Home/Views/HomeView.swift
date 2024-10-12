//
//  HomeView.swift
//  AuCare Swift
//
//  Created by Zitao Guan on 8/31/23.
//

import SwiftUI

struct HomeView: View {
    @State private var mapState = MapViewState.noInput
    var body: some View {
        ZStack(alignment: .top) {
            AuMapViewRepresentable()
                .ignoresSafeArea()
            
            if mapState == .searchingForLocation {
                LocationSearchView(mapState: $mapState)
                
                MapViewActionButton(mapState: $mapState)
                        .padding(.leading)
                        .padding(.vertical, 0.4)
                
            } else if mapState == .noInput{
                LocationSearchActivationView()
                    .padding(.top, 72)
                    .onTapGesture {
                        withAnimation(.spring()){
                            mapState = .searchingForLocation
                        }
                    }
            }
        }
    }
    
    struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView()
        }
    }
}
