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

    func generateDots(color: UIColor) -> [Dot] {
        let numberOfDots = Int.random(in: 10..<30)
        let dots: [Dot] = (0..<numberOfDots).map { _ in
            let x = CGFloat.random(in: 0..<1)
            let y = CGFloat.random(in: 0..<1)
            let colorOffset = CGFloat.random(in: 0..<0.1)
            let newColor = color.offset(by: colorOffset)
            return Dot(
                color: newColor,
                length: CGFloat.random(in: 3..<5.5),
                location: CGPoint(x: x, y: y)
            )
        }
        return dots
    }

    func generateBlock() -> Block {
        let pattern = Pattern.cases.randomElement()!
        var generatedPattern: Pattern
        switch pattern {
        case .concrete(var concrete):
            let range = 0.05
            let offset = CGFloat.random(in: -range..<range)
            let color = UIColor.gray.offset(by: offset)
            concrete.color = color
            concrete.dots = generateDots(color: color)
            generatedPattern = .concrete(concrete)
        case .glass(var glass):
            let range = 0.05
            let offset = CGFloat.random(in: -range..<range)
            let color = UIColor.systemBlue.withAlphaComponent(0.3).offset(by: offset)
            glass.color = color
            glass.dots = generateDots(color: color)
            generatedPattern = .glass(glass)
        case .dirt(var dirt):
            let range = 0.01
            let offset = CGFloat.random(in: -range..<range)
            let color = UIColor.brown.offset(by: offset)
            dirt.color = color
            dirt.dots = generateDots(color: color)
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
                ScrollViewReader { value in
                    VStack {
                        VStack(spacing: 0) {
                            ForEach(model.blocks) { block in
                                BlockView(block: block)
                                    .transition(
                                        .move(edge: .bottom)
                                            .combined(
                                                with: .scale(scale: 0.9, anchor: .bottom)
                                            )
                                            .combined(
                                                with: .opacity
                                            )
                                    )
                                    .id(block.id)
                            }
                        }

                        HStack {
                            Button {
                                withAnimation {
                                    var lastBlock = model.blocks.last!
                                    lastBlock.id = UUID()
                                    model.blocks.append(lastBlock)
                                    model.refreshChoices()
                                    value.scrollTo(0, anchor: .bottom)
                                }
                            } label: {
                                BlockView(block: model.blocks.last!, forceSmallWidth: true)
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
                                    value.scrollTo(0, anchor: .bottom)
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
                                    model.blocks.append(model.thirdChoice)
                                    model.refreshChoices()
                                    value.scrollTo(0, anchor: .bottom)
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
                    .id(0)
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
                    .overlayDots(dots: concrete.dots)
            case .glass(let glass):
                Color(glass.color)
                    .overlayDots(dots: glass.dots)
            case .dirt(let dirt):
                Color(dirt.color)
                    .overlayDots(dots: dirt.dots)
            case .wood(let wood):
                Color(wood.color)
                    .overlayLines(count: wood.numberOfLines)
            case .bars(let bars):
                Color(bars.color)
                    .overlayLines(count: bars.numberOfLines)
            case .brick(let brick):
                Color(brick.color)
                    .overlayLines(count: brick.numberOfLines)
            case .column(let column):
                Color(column.color)
                    .overlayLines(count: column.numberOfLines)
            }
        }
        .styled(with: block, forceSmallWidth: forceSmallWidth)
    }
}

extension View {
    func overlayDots(dots: [Dot]) -> some View {
        return overlay(
            GeometryReader { geometry in

                ForEach(dots) { dot in
                    dot.color.color
                        .frame(width: dot.length, height: dot.length)
                        .position(
                            x: geometry.size.width * dot.location.x,
                            y: geometry.size.height * dot.location.y
                        )
                }
            }
        )
    }

    func overlayLines(count: Int) -> some View {
        return overlay(
            GeometryReader { geometry in
                HStack {
                    ForEach(0..<count) { _ in
                        Color.white.opacity(0.5)
                            .frame(width: geometry.size.width * 0.02)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        )
    }

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
