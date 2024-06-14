//
//  SwiftUIView.swift
//  
//
//  Created by huangwenlong on 2024/6/13.
//

import SwiftUI

// 分页联动顶部标题和下划线
public struct PageView<Content: Pageable>: View {
    @State private var items: [Content]
    
    public init(selection: Binding<Int>, items: [Content]) {
        self._selection = selection
        self.items = items
    }
    // 可修改样式
    private var barHorizontalPadding: CGFloat = 5       // tabbar距离页面的水平边距
    private var isShowLineRect: Bool = true             // 是否显示下滑线
    private var lineRectWidth: CGFloat = 24             // 下划线宽度
    private var lineRectAnimation: Animation = .spring(duration: 0.2)                                   // 是否展示下划线过渡动画
    private var fontStyle: Font = .system(size: 16, weight: .regular)                                   // 标题字体样式
    private var selectedColor: Color = Color(red: 51 / 255, green: 51 / 255, blue: 51 / 255)            // 标题被选中时的颜色
    private var unselectedColor: Color = Color(red: 136 / 255, green: 136 / 255, blue: 136 / 255)       // 标题未被选中时的颜色
    private var lineRectColor: Color = Color(red: 247 / 255, green: 115 / 255, blue: 38 / 255)          // 下滑线颜色
    
    @Binding private var selection: Int
    @State private var textsWidth: [Int: CGFloat] = [:]
    @State private var xOffset: CGFloat = 0
    @State private var padding: CGFloat = 0
    
    public var body: some View {
        VStack(spacing: 10) {
            HStack {
                ForEach(0..<items.count, id: \.self) { index in
                    let text = Text(items[index].title)
                        .font(fontStyle)
                        .bold(selection == index)
                        .foregroundStyle(selection == index ? selectedColor : unselectedColor)
                    text
                        .overlay {
                            GeometryReader { geometry in
                                Text("")
                                    .onAppear {
                                        textsWidth[index] = geometry.size.width
                                    }
                            }
                        }
                        .onTapGesture {
                            selection = index
                        }
                    if index < items.count - 1 {
                        Spacer()
                    }
                }
            }
            .padding(.horizontal, barHorizontalPadding)
            
            // 下划线
            HStack {
                RoundedRectangle(cornerRadius: 100)
                    .frame(height: 6)
                    .foregroundStyle(.clear)
                    .overlay {
                        if isShowLineRect && !items.isEmpty {
                            GeometryReader { geometry in
                                if textsWidth.keys.count == items.count {
                                    RoundedRectangle(cornerRadius: 100)
                                        .frame(width: lineRectWidth, height: 6)
                                        .foregroundStyle(lineRectColor)
                                        .animation(.spring, value: selection)
                                        .offset(CGSize(width: xOffset, height: 0))
                                        .animation(lineRectAnimation, value: xOffset)
                                        .task(id: selection) {
                                            if padding <= 0 {
                                                let baseWidth = geometry.size.width
                                                var sumWidth: CGFloat = 0
                                                for index in 0..<textsWidth.count {
                                                    sumWidth += textsWidth[index] ?? 0
                                                }
                                                padding = (baseWidth - sumWidth) / CGFloat(textsWidth.count - 1)
                                            }
                                            xOffset = 0
                                            for index in 0..<selection {
                                                xOffset += textsWidth[index] ?? 00
                                            }
                                            xOffset += CGFloat(selection) * padding + (textsWidth[selection] ?? 0) / 2.0 - CGFloat(lineRectWidth / 2.0)
                                        }
                                }
                            }
                        }
                    }
                    .frame(height: 6)
                    .padding(.horizontal, barHorizontalPadding)
            }
            
            // 分页
            TabView(selection: $selection) {
                ForEach(0..<items.count, id: \.self) { index in
                    items[index]
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .animation(.linear, value: selection)
        }
    }
}

extension PageView {
    public func barHorizontalPadding(_ padding: CGFloat) -> PageView {
        var view = self
        view.barHorizontalPadding = padding
        return view
    }
    
    public func isShowLineRect(_ isShow: Bool) -> PageView {
        var view = self
        view.isShowLineRect = isShow
        return view
    }
    
    public func lineRectWidth(_ width: CGFloat) -> PageView {
        var view = self
        view.lineRectWidth = width
        return view
    }
    
    public func lineRectAnimation(_ animation: Animation) -> PageView {
        var view = self
        view.lineRectAnimation = animation
        return view
    }
    
    public func fontStyle(_ fontStyle: Font) -> PageView {
        var view = self
        view.fontStyle = fontStyle
        return view
    }
    
    public func selectedColor(_ selectedColor: Color) -> PageView {
        var view = self
        view.selectedColor = selectedColor
        return view
    }
    
    public func unselectedColor(_ unselectedColor: Color) -> PageView {
        var view = self
        view.unselectedColor = unselectedColor
        return view
    }
    
    public func lineRectColor(_ lineRectColor: Color) -> PageView {
        var view = self
        view.lineRectColor = lineRectColor
        return view
    }
}

public protocol Pageable: View {
    var title: String { get }
}
