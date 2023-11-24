//
//  MonthWidget.swift
//  MonthWidget
//
//  Created by Aneesh Sonnekar on 10/28/23.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> DayEntry {
        DayEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> DayEntry {
        DayEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<DayEntry> {
        var entries: [DayEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = DayEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct DayEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

struct BreatheEasyWidgetView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack{
            
            
            Color(UIColor.darkGray)
            let a = 80
            
            VStack{
                HStack{
                    
                    Spacer()
                
                    if(a>80){
                        
                        Image("greent")
                            .resizable()
                        .frame(width: 100, height: 100)}
                    else if(a>70){
                        
                        Image("lightgreent")
                            .resizable()
                        .frame(width: 100, height: 100)}
                    else if(a>60){
                        
                        Image("yellowt")
                            .resizable()
                        .frame(width: 100, height: 100)}
                    else if(a>50){
                        
                        Image("oranget")
                            .resizable()
                        .frame(width: 100, height: 100)}
                    else{
                        
                        Image("redt")
                            .resizable()
                        .frame(width: 100, height: 100)}
                    
                
                    
                
                    

                    
                        
                    
                    Spacer()
                }
                
                Text(String(a)+"%")
                    .font(.system(size: 35, weight: .heavy))
                    .foregroundColor(Color(UIColor.systemGray5).opacity(0.8))
                    .multilineTextAlignment(.center).position(x: 65, y: 5)
                    
                
            }
            .padding();
        }
        
    }
}

struct BreatheEasyWidget: Widget {
    let kind: String = "BreatheEasyWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            BreatheEasyWidgetView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .contentMarginsDisabled()
        //.supportedFamilies([.systemSmall])
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemSmall) {
    BreatheEasyWidget()
} timeline: {
    DayEntry(date: .now, configuration: .smiley)
    DayEntry(date: .now, configuration: .starEyes)
}
