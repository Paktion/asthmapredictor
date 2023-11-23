//
//  Breathe_Easy_WidgetLiveActivity.swift
//  Breathe Easy Widget
//
//  Created by Amogh Kuppa on 10/28/23.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct BreatheEasyWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct BreatheEasyLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: BreatheEasyWidgetAttributes.self) { context in
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

extension BreatheEasyWidgetAttributes {
    fileprivate static var preview: BreatheEasyWidgetAttributes {
        BreatheEasyWidgetAttributes(name: "World")
    }
}

extension BreatheEasyWidgetAttributes.ContentState {
    fileprivate static var smiley: BreatheEasyWidgetAttributes.ContentState {
        BreatheEasyWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: BreatheEasyWidgetAttributes.ContentState {
         BreatheEasyWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: BreatheEasyWidgetAttributes.preview) {
   BreatheEasyLiveActivity()
} contentStates: {
    BreatheEasyWidgetAttributes.ContentState.smiley
    BreatheEasyWidgetAttributes.ContentState.starEyes
}
