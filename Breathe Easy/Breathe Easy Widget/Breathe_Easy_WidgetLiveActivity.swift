//
//  Breathe_Easy_WidgetLiveActivity.swift
//  Breathe Easy Widget
//
//  Created by Amogh Kuppa on 10/28/23.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct Breathe_Easy_WidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct Breathe_Easy_WidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: Breathe_Easy_WidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension Breathe_Easy_WidgetAttributes {
    fileprivate static var preview: Breathe_Easy_WidgetAttributes {
        Breathe_Easy_WidgetAttributes(name: "World")
    }
}

extension Breathe_Easy_WidgetAttributes.ContentState {
    fileprivate static var smiley: Breathe_Easy_WidgetAttributes.ContentState {
        Breathe_Easy_WidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: Breathe_Easy_WidgetAttributes.ContentState {
         Breathe_Easy_WidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: Breathe_Easy_WidgetAttributes.preview) {
   Breathe_Easy_WidgetLiveActivity()
} contentStates: {
    Breathe_Easy_WidgetAttributes.ContentState.smiley
    Breathe_Easy_WidgetAttributes.ContentState.starEyes
}
