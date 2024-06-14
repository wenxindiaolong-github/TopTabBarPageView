//
//  SwiftUIView.swift
//  
//
//  Created by huangwenlong on 2024/6/13.
//

import SwiftUI

struct Example: View {
    @State private var selection: Int = 0
    
    var body: some View {
        PageView(selected: $selection, items: [
            PageItem(title: "热点新闻") {
                Text("热点新闻页面")
            },
            PageItem(title: "关注") {
                Image("heart.fill")
            },
            PageItem(title: "今日头条") {
                Rectangle()
            },
            PageItem(title: "游戏") {
                Text("游戏页面")
            }
        ])
    }
}

#Preview {
    Example()
}
