//
//  ContentView.swift
//  Memorize
//
//  Created by Antonio Ossian Buitrago Ekvall on 8/2/24.
//

import SwiftUI

struct ContentView: View {
    let emojis = [["👻","🎃","🕷️","😈", "💀", "🕸️", "🧙🏻", "🙀", "🦁", "😱", "☠️","🍭"],
                  ["🚗","🚕","🚌","🚎", "🏎️", "🚓", "🚑", "🚒", "🏍️", "🛵", "🛴","🚲"],
                  ["🐶","🐱","🦊","🐼", "🐨", "🐮", "🐷", "🐵", "🐔", "🐧", "🐙","🦋"],
                  ["🥨","🍐","🍊","🍋", "🍌", "🥕", "🍇", "🍓", "🌽", "🍒", "🍔","🧀"]]
    
    @State var currentEmojiList: [String] = []

    var body: some View {
        VStack {
            title
            ScrollView {
                cards
            }
            Spacer()
            themeAdjusters
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))]) {
            if currentEmojiList.count > 0 {
                ForEach(0..<currentEmojiList.count, id: \.self) { index in
                    CardView(content: currentEmojiList[index])
                        .aspectRatio(2/3, contentMode: .fit)
                }
            }
        }
        .foregroundColor(.orange)
    }
    
    func changeEmojiList(theme: Int) {
        currentEmojiList = emojis[theme] + emojis[theme]
        currentEmojiList.shuffle()
    }
    
    var title: some View {
        Text("Memorize!").font(.largeTitle)
    }
    
    var themeAdjusters: some View {
        HStack(alignment: .lastTextBaseline, content: {
            halloweenSelector
            Spacer()
            animalSelector
            Spacer()
            fruitSelector
        })
        .padding(.horizontal, 40)
    }
    
    func themeSelector(by offset: Int, themeTitle: String, symbol: String) -> some View {
        Button(
            action: {
                changeEmojiList(theme: offset)
            },
            label: {
                VStack() {
                    Image(systemName: symbol).font(.title)
                    Text(themeTitle)
                        .font(.caption)
            }
        })
    }
    
    var halloweenSelector: some View {
        themeSelector(by: 1, themeTitle: "Vehicles", symbol: "car") // symbol is an SF Symbol
    }
    
    var animalSelector: some View {
        themeSelector(by: 2, themeTitle: "Animals", symbol: "cat") // symbol is an SF Symbol
    }
    
    var fruitSelector: some View {
        themeSelector(by: 3, themeTitle: "Food", symbol: "carrot") // symbol is an SF Symbol
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = false
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content)
                    .font(.largeTitle)
            }.opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}















#Preview {
    ContentView()
}
