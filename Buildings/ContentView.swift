//
//  ContentView.swift
//  Buildings
//
//  Created by A. Zheng (github.com/aheze) on 3/28/22.
//  Copyright © 2022 A. Zheng. All rights reserved.
//

import SwiftUI

enum Width: CaseIterable {
    case small
    case medium
    case large
}

enum Pattern {
    case concrete(Concrete)
    case glass(Glass)
    case dirt(Dirt)
    case wood(Wood)
    case bars(Bars)
    case brick(Brick)
    case column(Column)

    static var cases: [Pattern] = [
        .concrete(.init()),
        .glass(.init()),
        .dirt(.init()),
        .wood(.init()),
        .bars(.init()),
        .brick(.init()),
        .column(.init())
    ]
}

struct Block: Identifiable {
    let id = UUID()
    var pattern: Pattern
    var width: Width
}

class ViewModel: ObservableObject {
    @Published var blocks = [Block]()
//    @Published var currentBlocks =

    func generateBlock() -> Block {
        let pattern = Pattern.cases.randomElement()!
        var generatedPattern: Pattern
        switch pattern {
        case .concrete(var concrete):
            let range = 0.05
            let offset = CGFloat.random(in: -range..<range)
            concrete.color = UIColor.gray.offset(by: offset)
            generatedPattern = .concrete(concrete)
        case .glass(var glass):
            let range = 0.05
            let offset = CGFloat.random(in: -range..<range)
            glass.color = UIColor.systemBlue.withAlphaComponent(0.3).offset(by: offset)
            generatedPattern = .glass(glass)
        case .dirt(var dirt):
            let range = 0.01
            let offset = CGFloat.random(in: -range..<range)
            dirt.color = UIColor.brown.offset(by: offset)
            generatedPattern = .dirt(dirt)
        case .wood(var wood):
            let range = 0.01
            let offset = CGFloat.random(in: -range..<range)
            wood.color = UIColor.brown.offset(by: offset)
            wood.numberOfLines = Int.random(in: 3..<10)
            generatedPattern = .wood(wood)
        case .bars(var bars):
            let range = 0.01
            let offset = CGFloat.random(in: -range..<range)
            bars.color = UIColor.gray.offset(by: offset)
            bars.numberOfLines = Int.random(in: 6..<20)
            generatedPattern = .bars(bars)
        case .brick(var brick):
            let range = 0.01
            let offset = CGFloat.random(in: -range..<range)
            brick.color = UIColor.red.offset(by: offset)
            brick.numberOfLines = Int.random(in: 3..<10)
            generatedPattern = .brick(brick)
        case .column(var column):
            let range = 0.01
            let offset = CGFloat.random(in: -range..<range)
            column.color = UIColor.systemGray.offset(by: offset)
            column.numberOfLines = Int.random(in: 3..<10)
            generatedPattern = .column(column)
        }

        return Block(pattern: generatedPattern, width: Width.allCases.randomElement()!)
    }
}

struct ContentView: View {
    @StateObject var model = ViewModel()
    var body: some View {
        VStack {
            Text("Building Blocks")
                .font(.system(.title, design: .monospaced))
                .fontWeight(.semibold)

            ScrollView {
                VStack {
                    HStack {
                        
                    }
                    .padding()
                    .background(<#T##Background#>)
                    
                    ForEach(model.blocks) { block in
                        switch block.pattern {
                        case .concrete(let concrete):
                            Color(concrete.color)
                                .styled(with: block)
                        case .glass(let glass):
                            Color(glass.color)
                                .styled(with: block)
                        case .dirt(let dirt):
                            Color(dirt.color)
                                .styled(with: block)
                        case .wood(let wood):
                            Color(wood.color)
                                .styled(with: block)
                        case .bars(let bars):
                            Color(bars.color)
                                .styled(with: block)
                        case .brick(let brick):
                            Color(brick.color)
                                .styled(with: block)
                        case .column(let column):
                            Color(column.color)
                                .styled(with: block)
                        }
                    }
                }
            }
            .scaleEffect(x: 1, y: -1)
        }
    }
}

extension View {
    func styled(with block: Block) -> some View {
        let width: CGFloat
        let height: CGFloat
        switch block.width {
        case .small:
            width = 100
            height = 100
        case .medium:
            width = 180
            height = 100
        case .large:
            width = 300
            height = 50
        }

        return self
            .frame(width: width, height: height)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
