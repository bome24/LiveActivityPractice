//
//  DynamicIslandWidgetLiveActivity.swift
//  DynamicIslandWidget
//
//  Created by BoMin Lee on 10/19/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct DynamicIslandWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var value: Int
        var isConnected: Bool
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct DynamicIslandWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: DynamicIslandWidgetAttributes.self) { context in
            let color: Color = context.state.isConnected ? .green : .red
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello")
            }
            .foregroundStyle(color)
            .activityBackgroundTint(Color.clear)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            let color: Color = context.state.isConnected ? .green : .red
            
            return DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading").foregroundStyle(color)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing").foregroundStyle(color)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom").foregroundStyle(color)
                    // more content
                }
            } compactLeading: {
                Text("L").foregroundStyle(color)
            } compactTrailing: {
                Text("T").foregroundStyle(color)
            } minimal: {
                Text("Min").foregroundStyle(color)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

//extension DynamicIslandWidgetAttributes {
//    fileprivate static var preview: DynamicIslandWidgetAttributes {
//        DynamicIslandWidgetAttributes(name: "World")
//    }
//}
//
//extension DynamicIslandWidgetAttributes.ContentState {
//    fileprivate static var smiley: DynamicIslandWidgetAttributes.ContentState {
//        DynamicIslandWidgetAttributes.ContentState(emoji: "😀")
//     }
//     
//     fileprivate static var starEyes: DynamicIslandWidgetAttributes.ContentState {
//         DynamicIslandWidgetAttributes.ContentState(emoji: "🤩")
//     }
//}
//
//#Preview("Notification", as: .content, using: DynamicIslandWidgetAttributes.preview) {
//   DynamicIslandWidgetLiveActivity()
//} contentStates: {
//    DynamicIslandWidgetAttributes.ContentState.smiley
//    DynamicIslandWidgetAttributes.ContentState.starEyes
//}
