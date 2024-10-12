//
//  LocationSearchView.swift
//  AuCare Swift
//
//  Created by Zitao Guan on 9/8/23.
//

import SwiftUI

struct LocationSearchView: View {
    @State private var CareLocation = ""
    @Binding var mapState: MapViewState
    @EnvironmentObject var viewModel: LocationSearchViewModel
    
    var body: some View {
        VStack{
            //Header
            HStack{
                
                Image(systemName: "mappin.circle")
                    .font(.title2)
                    .foregroundColor(.purple)
                
                TextField("Current Location", text:
                            $viewModel.queryFragment)
                    .frame(height:32)
                    .background(Color(.systemGroupedBackground))
                    .padding(.trailing)
            }
            .padding(.leading)
            .padding(.top, 64)
            
            Divider()
                .padding(.vertical)
            
            //List
            ScrollView{
                VStack(alignment: .leading){
                    ForEach(viewModel.results, id: \.self){ result in
                        LocationSearchResultCell(Title: result.title, Address: result.subtitle)
                            .onTapGesture {
                                viewModel.selectLocation(result)
                                mapState = .locationSelected
                            }
                    }
                }
            }
        }
        .background(.white)
    }
}

struct LocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchView(mapState: .constant(.searchingForLocation))
    }
}
