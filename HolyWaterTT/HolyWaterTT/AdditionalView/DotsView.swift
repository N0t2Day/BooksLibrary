//
//  DotsView.swift
//  HolyWaterTT
//
//  Created by Artem Kedrov on 22.02.2024.
//

import SwiftUI

struct DotsView: View {
    
    let dotsCount: Int
    let size: CGFloat = 10
    let ratio: CGFloat = 0.7
    let spacing: CGFloat = 10
    let maxVisibleDots: Int = 5
    @Binding var currentIndex: Int
    @State private var oldItemIndex: Int = .zero
    @State private var offsetMultiplier: Int = .zero
    @State private var targets: [TargetModel] = []
    private var movingOffset: Int {
        visibleDots - 1
    }
    
    private var visibleDots: Int {
        dotsCount >= maxVisibleDots ? maxVisibleDots : dotsCount
    }
    
    private var smallDotSize: CGFloat {
        size * ratio
    }
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                ForEach(0..<dotsCount, id: \.self) { index in
                    Circle().foregroundColor(index == currentIndex ? Colors.pinkMain : Color.white)
                        .frame(width: dotSize(at: index, with: proxy), height: dotSize(at: index, with: proxy))
                        .frame(width: size, height: size)
                        .anchorPreference(key: TargetPreferenceKey.self, value: .bounds) { anchor in
                          [TargetModel(id: index, anchor: anchor)]
                        }
                        .position(x: xOffset(with: proxy, for: index), y: proxy.size.height / 2)
                }
                .mask {
                    Color.white
                        .frame(width: CGFloat(visibleDots) * size + CGFloat(visibleDots + 1) * spacing , height: 32)
                        .position(x: proxy.size.width / 2, y: proxy.size.height / 2)
                        .blendMode(.destinationOver)
                }
            }.onChange(of: currentIndex) { oldValue, newValue in
                    if newValue > oldItemIndex {
                        offsetMultiplier += offsetMultiplier < dotsCount - visibleDots && currentIndex >= movingOffset && currentIndex >= movingOffset  ? 1 : 0
                        
                        
                    } else {
                        offsetMultiplier -= offsetMultiplier > 0 && currentIndex < dotsCount - movingOffset ? 1 : 0
                    }
                oldItemIndex = newValue
            }
            .animation(.linear(duration: 0.5), value: offsetMultiplier)
            .onPreferenceChange(TargetPreferenceKey.self) { value in
              targets = value
            }
        }
    }
    
    private func xOffset(with proxy: GeometryProxy, for index: Int) -> CGFloat {
        let itemOffset = (index.cgFloat - offsetMultiplier.cgFloat) * (size + spacing) + proxy.size.width / 2.cgFloat - (visibleDots.cgFloat / 2.cgFloat * (spacing + size)) + (spacing + size) / 2
        return itemOffset
    }
    
    private func offsetUntilFirst(with proxy: GeometryProxy) -> CGFloat {
        proxy.size.width / 2 - (visibleDots.cgFloat / 2 * (spacing + size)) + (size + spacing)
    }
    
    private func offsetTillLast(with proxy: GeometryProxy) -> CGFloat {
        proxy.size.width / 2 + (visibleDots.cgFloat / 2 * (spacing + size)) - (size + spacing)
    }
    
    private func dotSize(at index: Int, with proxy: GeometryProxy) -> CGFloat {
        guard let target = targets.first(where: { $0.id == index }), index != currentIndex else { return size }
        return proxy[target.anchor].midX < offsetUntilFirst(with: proxy) || proxy[target.anchor].midX > offsetTillLast(with: proxy) ? smallDotSize : size
    }
}

extension Int {
    var cgFloat: CGFloat {
        CGFloat(self)
    }
}

struct TargetModel: Equatable, Identifiable {
    let id: Int
    let anchor: Anchor<CGRect>
}

// 1.
struct TargetPreferenceKey: PreferenceKey {
    // 2.
    static var defaultValue: [TargetModel] = []
    // 3.
    static func reduce(
        value: inout [TargetModel],
        nextValue: () -> [TargetModel]
    ) {
        value.append(contentsOf: nextValue())
    }
}
