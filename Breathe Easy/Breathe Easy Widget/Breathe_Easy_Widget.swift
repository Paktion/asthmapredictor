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
            let a = 94
            VStack{
                HStack{
                    
                    Spacer()
                
                    if(a>80){
                        
                        Image("greenlungs")
                            .resizable()
                        .frame(width: 100, height: 100)}
                    else if(a>70){
                        
                        Image("lightgreenlungs")
                            .resizable()
                        .frame(width: 100, height: 100)}
                    else if(a>60){
                        
                        Image("yellowlungs")
                            .resizable()
                        .frame(width: 100, height: 100)}
                    else if(a>50){
                        
                        Image("orangelungs")
                            .resizable()
                        .frame(width: 100, height: 100)}
                    else{
                        
                        Image("redlungs")
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

struct Breathe_Easy_Widget: Widget {
    let kind: String = "BreatheEasyWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            BreatheEasyWidgetView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .contentMarginsDisabled()
        .supportedFamilies([.systemSmall])
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
    Breathe_Easy_Widget()
} timeline: {
    DayEntry(date: .now, configuration: .smiley)
    DayEntry(date: .now, configuration: .starEyes)
}
