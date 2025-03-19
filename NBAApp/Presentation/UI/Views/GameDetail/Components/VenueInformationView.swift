//
//  VenueInformationView.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 19/03/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct VenueInformationView: View {
    
    let venue: VenueModel
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("Venue")
                .font(.title2)
                .bold()
            
            ZStack {
                
                WebImage(url: URL(string: venue.image))
                    .resizable()
                    .frame(height: 150)
                    .cornerRadius(10)
                    .opacity(0.7)
                VStack {
                    Spacer()
                    HStack{
                        Text(venue.fullName)
                            .font(Font(Fonts.body1.semibold600))
                        Spacer()
                    }
                }
                .padding([.leading, .bottom], 5)
            }
            
            Text("\(venue.address.city), \(venue.address.state)")
                .font(Font(Fonts.body2.regular400))
                .padding(.leading, 5)
            
            
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}

#Preview {
    VenueInformationView(
        venue: VenueModel(
            id: "516",
            fullName: "American Airlines Center",
            address: AddressModel(
                city: "Dallas",
                state: "TX"
            ),
            image: "https://a.espncdn.com/i/venues/nba/day/516.jpg"
        )
    )
    .frame(height: 200)
}
