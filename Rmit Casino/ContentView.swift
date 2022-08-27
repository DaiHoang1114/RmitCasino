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

struct ContentView: View {
    // MARK: - PROPERTIES
    let icons = ["bee","cat","elephant","koala","whale"
                 ,"dog","apple","orange","hen"]
    
    let haptics = UINotificationFeedbackGenerator()
    let lightBlue = Color(red: 0.878, green: 0.984, blue: 0.988)
    let shadowBlue = Color(red: 0.067, green: 0.541, blue: 0.698)
    let lightPink = Color(red: 0.937, green: 0.278, blue: 0.435)
    
    @State private var highscore = UserDefaults.standard.integer(forKey: "highscore")
    @State private var coins = 200
    @State private var betAmount = 10
    @State private var reels = [0, 1, 2, 3, 4, 5, 6, 7, 8]
    
    @State private var isChooseBet10 = true
    @State private var isChooseBet20 = false
    
    @State private var showingInfoView = false
    @State private var showGameOverModal = false
    
    @State private var animatingIcon = false

    
    // MARK: - FUNCTIONS (GAME LOGICS)
    
    // MARK: - SPIN LOGIC
    func spinReels(){
        reels = reels.map({ _ in
            Int.random(in: 0...icons.count - 1)
        })
        playSound(sound: "spin", type: "mp3")
        haptics.notificationOccurred(.success)
    }
    
    // MARK: - CHECK WINNING LOGIC
    func checkWinning(){
        if isRowTheSame() || isColumnTheSame(){
            // PLAYER WINS LOGIC
            playerWins()
            
            // NEW HIGHSCORE LOGIC
            if coins > highscore{
                newHighScore()
            } else {
                playSound(sound: "winning", type: "mp3")
            }
            
        } else {
            // PLAYER LOSES
            playLoses()
        }
    }
    
    //checking Winning logic 1
    func isRowTheSame() -> Bool {
        if (reels[0] == reels[1] && reels[1] == reels[2])
            || (reels[3] == reels[4] && reels[4] == reels[5])
            || (reels[6] == reels[7] && reels[7] == reels[8]) {
            return true
        }
        
        return false
    }
    
    //checking Winning logic 2
    func isColumnTheSame() -> Bool {
        if (reels[0] == reels[3] && reels[3] == reels[6])
            || (reels[1] == reels[4] && reels[4] == reels[7])
            || (reels[2] == reels[5] && reels[5] == reels[8]) {
            return true
        }
        
        return false
    }
    
    // MARK: - PLAYER WIN LOGIC
    func playerWins() {
        coins += betAmount * 20
    }
    
    // MARK: - HIGHSCORE LOGIC
    func newHighScore(){
        highscore = coins
        UserDefaults.standard.set(highscore, forKey: "highscore")
        playSound(sound: "highscore", type: "mp3")
    }
    
    // MARK: - PLAYER LOSE LOGIC
    func playLoses() {
        coins -= betAmount
    }
    
    // MARK: - BET 20 LOGIC
    func chooseBet20() {
        betAmount = 20
        isChooseBet20 = true
        isChooseBet10 = false
        playSound(sound: "bet-chip", type: "mp3")
    }
    
    // MARK: - BET 10 LOGIC
    func chooseBet10() {
        betAmount = 10
        isChooseBet10 = true
        isChooseBet20 = false
        playSound(sound: "bet-chip", type: "mp3")
    }
    
    // MARK: - GAME OVER LOGIC
    func isGameOver() {
        if coins <= 0 {
            // SHOW MODAL MESSAGE OF GAME OVER
            showGameOverModal = true
            playSound(sound: "gameover", type: "mp3")
        }
    }
    
    // MARK: - RESET GAME LOGIC
    func resetGame(){
        UserDefaults.standard.set(0, forKey: "highscore")
        highscore = 0
        coins = 200
        chooseBet10()
        playSound(sound: "ring-up", type: "mp3")
    }
    
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            // MARK: - BACKGROUND
            LinearGradient(gradient: Gradient(colors: [Color("ColorRedRMIT"), lightBlue]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            
            // MARK: - GAME UI
            VStack {
                // MARK: - LOGO HEADER
                LogoView(logoFileName: "casino-pink-logo")
                Spacer()
                
                // MARK: - SCORE
                HStack{
                    HStack{
                        Text("Your\nMoney".uppercased())
                            .modifier(scoreLabelStyle())
                            .multilineTextAlignment(.trailing)
                        Text("\(coins)")
                            .modifier(scoreNumberStyle())
                    }
                    .modifier(scoreCapsuleStyle()
                    
                    )
                    Spacer()
                    HStack{
                        Text("\(highscore)")
                            .modifier(scoreNumberStyle())
                            .multilineTextAlignment(.leading)
                        Text("High\nScore".uppercased())
                            .modifier(scoreLabelStyle())
                        
                    }
                    .modifier(scoreCapsuleStyle()
                    )
                }
                
                // MARK: - SLOT MACHINE
                VStack{
                    HStack{
                        // MARK: - FIRST REEL
                        ZStack{
                            ReelView()
                            Image(icons[reels[0]])
                                .resizable()
                                .modifier(IconImageModifier())
                                .opacity(animatingIcon ? 1 : 0)
                                .offset(y: animatingIcon ? 0 : -50)
                                .animation(.easeOut(duration: Double.random(in: 0.7...0.9)), value: animatingIcon)
                                .onAppear(perform: {
                                    self.animatingIcon.toggle()
                                    playSound(sound: "blink", type: "mp3")
                                })
                        }
                        
                        // MARK: - SECOND REEL
                        ZStack{
                            ReelView()
                            Image(icons[reels[1]])
                                .resizable()
                                .modifier(IconImageModifier())
                                .opacity(animatingIcon ? 1 : 0)
                                .offset(y: animatingIcon ? 0 : -50)
                                .animation(.easeOut(duration: Double.random(in: 0.7...0.9)), value: animatingIcon)
                                .onAppear(perform: {
                                    self.animatingIcon.toggle()
                                    playSound(sound: "blink", type: "mp3")
                                })
                        }
                        
                        Spacer()
                        
                        // MARK: - THIRD REEL
                        ZStack{
                            ReelView()
                            Image(icons[reels[2]])
                                .resizable()
                                .modifier(IconImageModifier())
                                .opacity(animatingIcon ? 1 : 0)
                                .offset(y: animatingIcon ? 0 : -50)
                                .animation(.easeOut(duration: Double.random(in: 0.9...1.1)), value: animatingIcon)
                                .onAppear(perform: {
                                    self.animatingIcon.toggle()
                                    playSound(sound: "blink", type: "mp3")
                                })
                        }
                    }
                    
                    HStack{
                        // MARK: - FOURTH REEL
                        ZStack{
                            ReelView()
                            Image(icons[reels[3]])
                                .resizable()
                                .modifier(IconImageModifier())
                                .opacity(animatingIcon ? 1 : 0)
                                .offset(y: animatingIcon ? 0 : -50)
                                .animation(.easeOut(duration: Double.random(in: 0.7...0.9)), value: animatingIcon)
                                .onAppear(perform: {
                                    self.animatingIcon.toggle()
                                    playSound(sound: "blink", type: "mp3")
                                })
                        }
                        
                        // MARK: - FIFTH REEL
                        ZStack{
                            ReelView()
                            Image(icons[reels[4]])
                                .resizable()
                                .modifier(IconImageModifier())
                                .opacity(animatingIcon ? 1 : 0)
                                .offset(y: animatingIcon ? 0 : -50)
                                .animation(.easeOut(duration: Double.random(in: 0.7...0.9)), value: animatingIcon)
                                .onAppear(perform: {
                                    self.animatingIcon.toggle()
                                    playSound(sound: "blink", type: "mp3")
                                })
                        }
                        
                        Spacer()
                        
                        // MARK: - SIXTH REEL
                        ZStack{
                            ReelView()
                            Image(icons[reels[5]])
                                .resizable()
                                .modifier(IconImageModifier())
                                .opacity(animatingIcon ? 1 : 0)
                                .offset(y: animatingIcon ? 0 : -50)
                                .animation(.easeOut(duration: Double.random(in: 0.9...1.1)), value: animatingIcon)
                                .onAppear(perform: {
                                    self.animatingIcon.toggle()
                                    playSound(sound: "blink", type: "mp3")
                                })
                        }
                    }
                    HStack{
                        // MARK: - SIXTH REEL
                        ZStack{
                            ReelView()
                            Image(icons[reels[6]])
                                .resizable()
                                .modifier(IconImageModifier())
                                .opacity(animatingIcon ? 1 : 0)
                                .offset(y: animatingIcon ? 0 : -50)
                                .animation(.easeOut(duration: Double.random(in: 0.7...0.9)), value: animatingIcon)
                                .onAppear(perform: {
                                    self.animatingIcon.toggle()
                                    playSound(sound: "blink", type: "mp3")
                                })
                        }
                        
                        // MARK: - SEVENTH REEL
                        ZStack{
                            ReelView()
                            Image(icons[reels[7]])
                                .resizable()
                                .modifier(IconImageModifier())
                                .opacity(animatingIcon ? 1 : 0)
                                .offset(y: animatingIcon ? 0 : -50)
                                .animation(.easeOut(duration: Double.random(in: 0.7...0.9)), value: animatingIcon)
                                .onAppear(perform: {
                                    self.animatingIcon.toggle()
                                    playSound(sound: "blink", type: "mp3")
                                })
                        }
                        
                        Spacer()
                        
                        // MARK: - EIGTH REEL
                        ZStack{
                            ReelView()
                            Image(icons[reels[8]])
                                .resizable()
                                .modifier(IconImageModifier())
                                .opacity(animatingIcon ? 1 : 0)
                                .offset(y: animatingIcon ? 0 : -50)
                                .animation(.easeOut(duration: Double.random(in: 0.9...1.1)), value: animatingIcon)
                                .onAppear(perform: {
                                    self.animatingIcon.toggle()
                                    playSound(sound: "blink", type: "mp3")
                                })
                        }
                    }
                    
                    // MARK: - SPIN BUTTON
                    Button {
                        // NO ANIMATION
                        withAnimation{
                            self.animatingIcon = false
                        }
                        
                        // SPIN THE REELS
                        self.spinReels()
                        
                        // TRIGGER ANIMATION
                        withAnimation{
                            self.animatingIcon = true
                        }
                        
                        // CHECK WINNING
                        self.checkWinning()
                        
                        // GAME OVER
                        self.isGameOver()
                    } label: {
                        Image("spin-pink")
                            .resizable()
                            .modifier(ReelImageModifier())
                    }
                    
                }
                
                // MARK: - FOOTER
                
                Spacer()
                
                HStack{
                    
                    HStack{
                        
                        // MARK: - BET 20 BUTTON
                        Button {
                            self.chooseBet20()
                        } label: {
                            HStack(spacing: 30){
                                Text("20")
                                    .foregroundColor(isChooseBet20 ? Color("ColorBlueRMIT") : Color.white)
                                    .modifier(BetCapsuleModifier())
                               Image("casino-chips")
                                    .resizable()
                                    .offset(x: isChooseBet20 ? 0 : 20)
                                    .opacity(isChooseBet20 ? 1 : 0 )
                                    .modifier(CasinoChipModifier())
                                    .animation(.default, value: isChooseBet20)
                            }
                            .padding(.horizontal, 20)
                        }
                        
                        Spacer()
                        
                        // MARK: - BET 10 BUTTON
                        Button {
                            self.chooseBet10()
                        } label: {
                            HStack(spacing: 30){
                                Image("casino-chips")
                                     .resizable()
                                     .offset(x: isChooseBet10 ? 0 : -20)
                                     .opacity(isChooseBet10 ? 1 : 0 )
                                     .modifier(CasinoChipModifier())
                                     .animation(.default, value: isChooseBet20)
                                Text("10")
                                    .foregroundColor(isChooseBet10 ? Color("ColorBlueRMIT") : Color.white)
                                    .modifier(BetCapsuleModifier())
                               
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                    
                }

            }
            .overlay(
                
                // MARK: - RESET GAME BUTTON
                
                Button(action: {
                    self.resetGame()
                }) {
                  Image(systemName: "arrow.2.circlepath.circle")
                    .foregroundColor(.white)
                }
                .modifier(ButtonModifier()),
                alignment: .topLeading
              )
              .overlay(
                
                // MARK: - INFO GAME BUTTON
                
                Button(action: {
                    self.showingInfoView = true
                }) {
                  Image(systemName: "info.circle")
                    .foregroundColor(.white)
                }
                .modifier(ButtonModifier()),
                alignment: .topTrailing
              )
            .padding()
            .frame(maxWidth: 720)
            .blur(radius:  showGameOverModal ? 5 : 0 , opaque: false)
            
            
            
            // MARK: - GAMEOVER MODAL
            if showGameOverModal{
                ZStack{
                    Color("ColorBlackTransparent")
                        .edgesIgnoringSafeArea(.all)
                    VStack{
                        Text("GAME OVER")
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.heavy)
                            .foregroundColor(Color.white)
                            .padding()
                            .frame(minWidth: 280, idealWidth: 280, maxWidth: 320)
                            .background(lightPink)
                        
                        Spacer()
                        
                        VStack {
                            Image("casino-pink-logo")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 150)
                            Text("You lost all money!\nYou are not the god of gambler!\n Good luck next time!")
                                .font(.system(.body, design: .rounded))
                                .foregroundColor(Color.white)
                                .multilineTextAlignment(.center)
                            Button {
                                self.showGameOverModal = false
                                self.coins = 200
                            } label: {
                                Text("New Game".uppercased())
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color.white)
                            }
                            .padding(.vertical,10)
                            .padding(.horizontal, 20)
                            .background(
                                Capsule()
                                    .strokeBorder(lineWidth: 2)
                                    .foregroundColor(Color.white)
                            )

                        }
                        Spacer()
                    }
                    .frame(minWidth: 280, idealWidth: 280, maxWidth: 320, minHeight: 280, idealHeight: 300, maxHeight: 350, alignment: .center)
                    .background(shadowBlue)
                    .cornerRadius(20)
                }.onAppear(perform: {
                    playSound(sound: "drum-music", type: "mp3")
                  })
            }//ZStack
        }.sheet(isPresented: $showingInfoView) {
            InfoView()
          }
    }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


