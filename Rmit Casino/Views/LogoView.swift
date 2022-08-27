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

struct LogoView: View {
    var logoFileName: String
    
    var body: some View {
        Image(logoFileName)
            .resizable()
            .scaledToFit()
            .frame(minHeight: 130, idealHeight: 170, maxHeight: 200, alignment: .center)
            .modifier(ShadowModifier())
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView(logoFileName: "casino-pink-logo")
    }
}
