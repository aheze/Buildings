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
    var id = UUID()
    var pattern: Pattern
    var width: Width
}

class ViewModel: ObservableObject {
    @Published var blocks = [Block]()
    @Published var secondChoice: Block!
    @Published var thirdChoice: Block!

    init() {
        let baseBlock = generateBlock()
        blocks.append(baseBlock)
        secondChoice = generateBlock()
        thirdChoice = generateBlock()
    }

    func refreshChoices() {
        secondChoice = generateBlock()
        thirdChoice = generateBlock()
    }

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
                .foregroundColor(.brown)
                .font(.system(.title, design: .monospaced))
                .fontWeight(.semibold)
                .padding(.top, 24)

            Text("Happy Birthday Dad!")
                .foregroundColor(.brown)
                .font(.system(.title3, design: .monospaced))
                .fontWeight(.semibold)

            ScrollView {
                VStack {
                    ForEach(model.blocks) { block in
                        BlockView(block: block)
                    }

                    HStack {
                        Button {
                            withAnimation {
                                var firstBlock = model.blocks.first!
                                firstBlock.id = UUID()
                                model.blocks.append(firstBlock)
                                model.refreshChoices()
                            }
                        } label: {
                            BlockView(block: model.blocks.first!, forceSmallWidth: true)
                                .cornerRadius(6)
                                .padding(8)
                                .background(.green)
                                .cornerRadius(8)
                                .scaleEffect(x: 1, y: -1)
                        }

                        Button {
                            withAnimation {
                                model.blocks.append(model.secondChoice)
                                model.refreshChoices()
                            }
                        } label: {
                            BlockView(block: model.secondChoice, forceSmallWidth: true)
                                .cornerRadius(6)
                                .padding(8)
                                .background(.brown)
                                .cornerRadius(8)
                                .scaleEffect(x: 1, y: -1)
                        }

                        Button {
                            withAnimation {
                                model.blocks.append(model.secondChoice)
                                model.refreshChoices()
                            }
                        } label: {
                            BlockView(block: model.thirdChoice, forceSmallWidth: true)
                                .cornerRadius(6)
                                .padding(8)
                                .background(.brown)
                                .cornerRadius(8)
                                .scaleEffect(x: 1, y: -1)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(UIColor.secondarySystemBackground.color)
                    .cornerRadius(16)
                    .padding(24)
                }
            }
            .scaleEffect(x: 1, y: -1)
        }
    }
}

struct BlockView: View {
    let block: Block
    var forceSmallWidth = false
    var body: some View {
        VStack {
            switch block.pattern {
            case .concrete(let concrete):
                Color(concrete.color)
            case .glass(let glass):
                Color(glass.color)
            case .dirt(let dirt):
                Color(dirt.color)
            case .wood(let wood):
                Color(wood.color)
            case .bars(let bars):
                Color(bars.color)
            case .brick(let brick):
                Color(brick.color)
            case .column(let column):
                Color(column.color)
            }
        }
        .styled(with: block, forceSmallWidth: forceSmallWidth)
    }
}

extension View {
    func styled(with block: Block, forceSmallWidth: Bool) -> some View {
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

        if forceSmallWidth {
            return frame(width: 100, height: 100)
        } else {
            return frame(width: width, height: height)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
