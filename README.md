# Requirements
* SwiftUI
* IOS 16
# Installation
```
git@github.com:wenxindiaolong-github/TopTabBarPageView.git
```
# Usage
```swift
        PageView(selection: $selection, items: [
            PageItem(title: "热点新闻") {
                // your view
                Text("热点新闻页面")
            },
            PageItem(title: "关注") {
                // your view
                Rectangle()
                    .overlay {
                        Image(systemName: "heart.fill")
                            .foregroundStyle(.red)
                    }
                    .foregroundStyle(.gray)
            },
            PageItem(title: "今日头条") {
                // your view
                Circle()
            }
        ])
        .barHorizontalPadding(20)
```

# Custom
```swift
func barHorizontalPadding(_ padding: CGFloat) -> PageView
func isShowLineRect(_ isShow: Bool) -> PageView
func lineRectWidth(_ width: CGFloat) -> PageView
func lineRectAnimation(_ animation: Animation) -> PageView
func fontStyle(_ fontStyle: Font) -> PageView
func selectedColor(_ selectedColor: Color) -> PageView
func unselectedColor(_ unselectedColor: Color) -> PageView
func lineRectColor(_ lineRectColor: Color) -> PageView
```
