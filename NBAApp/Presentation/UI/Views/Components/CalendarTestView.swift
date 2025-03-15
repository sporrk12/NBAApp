//
//  CalendarTestView.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 13/03/25.
//

import SwiftUI

struct WeekCalendarView: View {
    @Binding var selectedDate: Date
    @State private var showMonthPicker = false
    var showCalendar: Bool = false
    private let calendar = Calendar.current
    private let dateFormatter: DateFormatter
    
    init(selectedDate: Binding<Date>) {
        self._selectedDate = selectedDate
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateFormat = "E d MMM"
    }
    
    private var weekDays: [Date] {
        return (-15...15).compactMap { calendar.date(byAdding: .day, value: $0, to: selectedDate) }
    }
    
    var body: some View {
        VStack {
            
            
            GeometryReader { geometry in
                ScrollViewReader { scrollProxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(weekDays, id: \.self) { date in
                                Text(dateFormatter.string(from: date))
                                    .padding()
                                    .background(self.isSelected(date) ? Color.white : Color.clear)
                                    .foregroundColor(self.isSelected(date) ? .black : .white)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .onTapGesture {
                                        withAnimation {
                                            selectedDate = date
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                                scrollProxy.scrollTo(date, anchor: .center)
                                            }
                                        }
                                    }
                                    .id(date)
                            }
                        }
                    }
                    .onAppear {
                        DispatchQueue.main.async {
                            scrollProxy.scrollTo(selectedDate, anchor: .center)
                        }
                    }
                    .onChange(of: selectedDate) { oldValue, newDate in
                        withAnimation {
                            scrollProxy.scrollTo(newDate, anchor: .center)
                        }
                    }
                }
            }
            if showCalendar{
                HStack {
                    Button(action: { showMonthPicker.toggle() }) {
                        HStack{
                            Image(systemName: "calendar")
                                .foregroundColor(.white)
                            Spacer()
                        }
                    }
                    Spacer()
                }
            }
        }
        .sheet(isPresented: $showMonthPicker) {
            MonthPickerView(selectedDate: $selectedDate)
        }
    }
    
    private func isSelected(_ date: Date) -> Bool {
        calendar.isDate(selectedDate, inSameDayAs: date)
    }
}

struct MonthPickerView: View {
    @Binding var selectedDate: Date
    @Environment(\.presentationMode) var presentationMode
    private let calendar = Calendar.current
    
    var body: some View {
        DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
            .datePickerStyle(GraphicalDatePickerStyle())
            .padding()
            .onChange(of: selectedDate) {
                presentationMode.wrappedValue.dismiss()
            }
    }
}

struct WeekCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        WeekCalendarView(selectedDate: .constant(Date()))
    }
}
