//
//  ContentView.swift
//  CalendarTest WatchKit Extension
//
//  Created by Jack de Haan on 1/27/22.
//

import SwiftUI

struct ContentView: View {
    
    func getDate() -> String {
        let date = Date()
        let cal = Calendar.current
        let month = cal.component(.month, from: date)
        let day = cal.component(.day, from: date)
        let year = cal.component(.year, from: date)
        return "\(cal.monthSymbols[month-1]) \(day), \(year)"
    }
    
    func getWeekday() -> String {
        // TODO
        let date = Date()
        let cal = Calendar.current
        let weekday = cal.component(.weekday, from: date)
        return "\(cal.weekdaySymbols[weekday-1])"
    }
    
    func getOrder() -> String {
        return "C-D-F-E-G"
    }
    func getCycleDay() -> Int {
        let date = Date()
        let calendar = Calendar.current
        var month = calendar.component(.month, from: date)
        var day = calendar.component(.day, from: date)
        if month >= 6 && day >= 8 {
            month = 6
            day = 8
        }
        let optionalCycle: Int? = dateToCycleDay[month-1][day]
        if let cycleDay = optionalCycle {
            return cycleDay
        } else { return 0 }
    }
    func getNextClass() -> String {
        return "Skiing"
    }
    func getClasses() -> String {
        if let classList = classes[getCycleDay()]?.joined(separator: "\n") {
            return classList
        } else { return "e" }
    }
    var dateToCycleDay: [[Int: Int]] = [
        // January
        [1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0, 16:0, 17:0, 18:0, 19:0, 20:0, 21:0, 22:0, 23:0, 24:7, 25:8, 26:1, 27:2, 28:3, 29:0, 30:0, 31:4],
        // February
        [1:5, 2:6, 3:7, 4:8, 5:0, 6:0, 7:1, 8:2, 9:3, 10:4, 11:5, 12:0, 13:0, 14:7, 15:7, 16:8, 17:1, 18:0, 19:0, 20:0, 21:0, 22:2, 23:3, 24:4, 25:5, 26:0, 27:0, 28:6],
        // March
        [1:7, 2:8, 3:1, 4:2, 5:0, 6:0, 7:3, 8:4, 9:5, 10:6, 11:7, 12:0, 13:0, 14:0, 15:0, 16:0, 17:0, 18:0, 19:0, 20:0, 21:0, 22:0, 23:0, 24:0, 25:0, 26:0, 27:0, 28:8, 29:1, 30:2, 31:3],
        // April
        [1:4, 2:0, 3:0, 4:5, 5:6, 6:7, 7:8, 8:1, 9:0, 10:0, 11:2, 12:3, 13:4, 14:5, 15:0, 16:0, 17:0, 18:6, 19:7, 20:8, 21:1, 22:2, 23:0, 24:0, 25:3, 26:4, 27:5, 28:6, 29:7, 30:0],
        // May
        [1:0, 2:8, 3:1, 4:2, 5:3, 6:4, 7:0, 8:0, 9:5, 10:6, 11:7, 12:8, 13:1, 14:0, 15:0, 16:2, 17:3, 18:4, 19:5, 20:6, 21:0, 22:0, 23:7, 24:8, 25:1, 26:2, 27:3, 28:0, 29:0, 30:0, 31:4],
        // June
        [1:5, 2:6, 3:7, 4:0, 5:0, 6:8, 7:1, 8:0]
    ]
    var order: [Int: [String]] = [
        1:["C-E-D-A-B"], 2:["F-G-H-A-B"], 3:["C-D-F-E-G"], 4:["H-A-B-C-D"], 5:["G-A-H-E-F"], 6:["B-C-D-E-F"], 7:["A-H-G-B-C"], 8:["D-E-F-G-H"]
    ]

    var classes: [Int: [String]] = [
        1: ["Comp Sci (C)", "English (E)", "Physics (D)", "Free/OPI (A)", "Public Speaking (B)"],
        2: ["Latin (F)", "Spanish (G)", "Math (H)", "Math Team (H)", "Public Speaking (B)"],
        3: ["C: Free", "Physics (D)", "Latin (F)", "English (E)", "Spanish (G)"],
        4: ["Math (H)", "Free (A)", "Public Speaking (B)", "Comp Sci (C)", "Physics (D)"],
        5: ["Spanish (G)", "Math Team (A)", "H: Free", "English (E)", "Latin (F)"],
        6: ["Public Speaking (B)", "Comp Sci (C)", "Physics (D)", "English (E)", "Latin (F)"],
        7: ["Free (A)", "Math (H)", "Spanish (G)", "Public Speaking (B)", "Comp Sci (C)"],
        8: ["Physics (D)", "English (E)", "Latin (F)", "Spanish (G)", "Math (H)"]
    ]
    var body: some View {

        VStack{
        Text("Day \(getCycleDay())")
            .font(.title)
            .fontWeight(.heavy)
            .multilineTextAlignment(.center)
            .padding()
            
            Text("\(getNextClass())")
            Text("\(getDate())")
            Text("\(getWeekday())")
                .multilineTextAlignment(.center)
            .multilineTextAlignment(.center)
            Text("\(getOrder())").multilineTextAlignment(.center)
            
            Spacer()
            Spacer()
            Spacer()
                        
            NavigationLink(destination: DayView()){
                Text("Today")
                    .fontWeight(.heavy)
                        }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
