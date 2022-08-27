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

struct InfoView: View {
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
      ZStack{
          Color(red: 0.067, green: 0.541, blue: 0.698)
          VStack(alignment: .center, spacing: 10) {
            LogoView(logoFileName: "casino-pink-logo")
            
            Spacer()
            
            Form {
              Section(header: Text("How To Play")) {
                  Text("Just spin the reels to play.")
                  Text("Matching 3 icons in a row or a column to win.")
                  Text("The winning amount will be 20x of your betting amount.")
                  Text("You can reset the money and highscore by clicking on the button Reset.")
              }
                Section(header: Text("Application Information")) {
                    HStack {
                      Text("App Name")
                      Spacer()
                      Text("RMIT Casino")
                    }
                    HStack {
                      Text("Course")
                      Spacer()
                      Text("COSC2659")
                    }
                    HStack {
                      Text("Year Published")
                      Spacer()
                      Text("2022")
                    }
                    HStack {
                      Text("Location")
                      Spacer()
                      Text("Saigon South Campus")
                    }
              }
            }
            .font(.system(.body, design: .rounded))
          }
          .padding(.top, 40)
          .overlay(
            Button(action: {
              audioPlayer?.stop()
              dismiss()
            }) {
              Image(systemName: "xmark.circle")
                .font(.title)
            }
            .foregroundColor(.white)
            .padding(.top, 30)
            .padding(.trailing, 20),
            alignment: .topTrailing
            )
            .onAppear(perform: {
              playSound(sound: "drum-music", type: "mp3")
            })
      }
    
  }
}


struct InfoView_Previews: PreviewProvider {
  static var previews: some View {
    InfoView()
  }
}
