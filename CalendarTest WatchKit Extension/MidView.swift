//
//  MidView.swift
//  CalendarTest WatchKit Extension
//
//  Created by Jack de Haan on 2/6/22.
//

import SwiftUI


struct MidView: View {
    var day : Int
    var block : Int
    var datecomp : DateComponents
    
    @State var eventPick: String = ""
    //    var even : blockEvent
    
    //    func maxEvents() -> Bool{ //has reached max events (3)
    //        return numEvents[block][datecomp]! > 2 ? true : false
    //    }
    func getPeriod(blockNum: Int) -> String {
        switch blockNum {
        case 0:
            return blocks[day]![0] + " Block"
        case 1:
            return "Break/Clubs"
        case 2:
            return blocks[day]![1] + " Block"
        case 3:
            return blocks[day]![2] + " Block"
        case 4:
            return "Lunch"
        case 5:
            return blocks[day]![3] + " Block"
        case 6:
            return blocks[day]![4] + " Block"
        case 9:
            return "Office Hours / Break"
        default:
            return "e"
        }
    }
    func meetingOrAssessment() -> String {
        let date = Date()
        let cal = Calendar.current
        let weekday = cal.component(.weekday, from: date)
        switch block {
        case 0:
            return classes[day]![0].starts(with: "Free") ? "Meeting" : "Assessment"
        case 1:
            return weekday == 3 || weekday == 5 ? "Meeting" : "Event"
        case 2:
            return classes[day]![1].starts(with: "Free") ? "Meeting" : "Assessment"
        case 3:
            return classes[day]![2].starts(with: "Free") ? "Meeting" : "Assessment"
        case 4:
            return "Meeting"
        case 5:
            return classes[day]![3].starts(with: "Free") ? "Meeting" : "Assessment"
        case 6:
            return classes[day]![4].starts(with: "Free") ? "Meeting" : "Assessment"
        case 9:
            return "Meeting"
        default:
            return "e"
        }
    }
    
    func eventsThisBlock() -> [blockEvent] {
        let dayEvents = eventsList[datecomp.month! - 1][datecomp.day!]!
        var blockEvents: [blockEvent] = []
        for event in dayEvents {
            if event.block == block { blockEvents.append(event) }
        }
        return blockEvents
    }
    
    var body: some View {
        ScrollView{
            VStack {
                //            Text("Events").font(.title2).fontWeight(.bold).multilineTextAlignment(.center).padding(.bottom, 5)
                Text(getOffsetDate())
                Text("Day \(day), \(getPeriod(blockNum: block))")
                
                Divider().padding(.vertical, 5)
                //            if (eventsList[datecomp.month! - 1][datecomp.day!])?.count == 0 {
                if (eventsThisBlock()).count == 0 {
                    Text("No Events").font(.title3).fontWeight(.bold).multilineTextAlignment(.center).padding(.bottom, 5)
                } else {
                    ForEach(eventsThisBlock(), id: \.id) { item in
                        NavigationLink(destination: {EventView(ev: item)}, label: {Text(item.hasLabel ? item.label : item.label + item.meetingOrAssessment()).fontWeight(.bold)}).buttonStyle(PlainButtonStyle())
                    }
                }
                Divider().padding(.vertical, 5)
                if globalOffset < 0 || (globalOffset == 0 && nowIsAfterBlockEnds(block: (block))){
                    Text("You cannot schedule events in the past.").fontWeight(.medium).multilineTextAlignment(.center)
                } else {
                    Button(action: {
                        let n = eventsList[datecomp.month! - 1][datecomp.day!]!.filter({$0.label.contains(eventPick)}).count + 1
                        let temp = blockEvent(block, datecomp, makeId(block: block, time: datecomp, num: n), "\(eventPick) of block - \(n)", true, false)
                        (eventsList[datecomp.month! - 1][datecomp.day!])!.append(temp)
                    }, label: {
                        Text("Add Event").fontWeight(.heavy).multilineTextAlignment(.center)
                    })
                    Picker("Select Part of Block", selection: $eventPick, content: {
                        Text("first half").tag("first half")
                        Text("second half").tag("second half")
                        Text("entirety").tag("entirety")
                        Text("middle").tag("middle")
                    }).pickerStyle(.wheel).frame(width: WKInterfaceDevice.current().screenBounds.width, height: 50, alignment: .center)
                }
            }
        }
    }
}

struct MidView_Previews: PreviewProvider {
    static var previews: some View {
        Text("e")
    }
}

