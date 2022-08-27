/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Hoang Quoc Dai
  ID: s3426353
  Created  date: 27/08/2022
  Last modified: 28/08/2022
  Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI

struct ReelView: View {
    var body: some View {
        Image("reel-blue")
            .resizable()
            .modifier(ReelImageModifier())
    }
}

struct ReelView_Previews: PreviewProvider {
    static var previews: some View {
        ReelView()
            .previewLayout(.sizeThatFits)
    }
}
