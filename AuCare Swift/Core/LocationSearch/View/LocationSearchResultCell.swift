//
//  LocationSearchResultCell.swift
//  AuCare Swift
//
//  Created by Zitao Guan on 9/8/23.
//

import SwiftUI

struct LocationSearchResultCell: View {
    let Title: String
    let Address: String
    var body: some View {
        HStack {
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .foregroundColor(.purple)
                .accentColor(.white)
                .frame(width:35, height:35)
            
            VStack(alignment: .leading, spacing: 4){
                Text(Title)
                    .font(.body)
                
                Text(Address)
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
                
                Divider()
            }
            .padding(.leading, 4)
            .padding(.vertical, 4)
        }
        .padding(.leading)
    }
}

struct LocationSearchResultCell_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchResultCell(Title: "James House", Address: "8865 E Fallbrook Way, CA")
    }
}
