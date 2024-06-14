//
//  SwiftUIView.swift
//  
//
//  Created by huangwenlong on 2024/6/13.
//

import SwiftUI

public struct PageItem: Pageable {
    public let title: String
    let content: AnyView
    
    public init(title: String, @ViewBuilder content: () -> any View) {
        self.title = title
        self.content = AnyView(content())
    }
    
    public var body: some View {
        content
    }
}
