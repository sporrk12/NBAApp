//
//  CalendarView.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 28/01/25.
//

import SwiftUI

struct CalendarView: View {
    let nPanels = 15
    let panelSize: CGFloat = 100
    let gapSize: CGFloat = 10
    let baseDate = Date.now
    let dayOfMonthFormatter = DateFormatter()
    let monthNameFormatter = DateFormatter()
    
    @Binding var selectedDate: Date
    @State private var snappedDayOffset = 0
    @State private var draggedDayOffset = Double.zero
    
    init(selectedDate: Binding<Date>) {
        self._selectedDate = selectedDate
        dayOfMonthFormatter.dateFormat = "d"
        monthNameFormatter.dateFormat = "MMMM"
    }
    
    private var positionWidth: CGFloat {
        CGFloat(panelSize + gapSize)
    }
    
    private func xOffsetForIndex(index: Int) -> Double {
        let midIndex = Double(nPanels / 2)
        var dIndex = (Double(index) - draggedDayOffset - midIndex).truncatingRemainder(dividingBy: Double(nPanels))
        if dIndex < -midIndex {
            dIndex += Double(nPanels)
        } else if dIndex > midIndex {
            dIndex -= Double(nPanels)
        }
        return dIndex * positionWidth
    }
    
    private func dayAdjustmentForIndex(index: Int) -> Int {
        let midIndex = nPanels / 2
        var dIndex = (index - snappedDayOffset - midIndex) % nPanels
        if dIndex < -midIndex {
            dIndex += nPanels
        } else if dIndex > midIndex {
            dIndex -= nPanels
        }
        return dIndex + snappedDayOffset
    }
    
    private func dateView(index: Int, halfFullWidth: CGFloat) -> some View {
        let xOffset = xOffsetForIndex(index: index)
        let dayAdjustment = dayAdjustmentForIndex(index: index)
        let dateToDisplay = Calendar.current.date(byAdding: .day, value: dayAdjustment, to: baseDate) ?? baseDate
        let isToday = Calendar.current.isDate(dateToDisplay, inSameDayAs: Date())
        return ZStack {
            Color.teal
                .cornerRadius(10)
            VStack {
                if isToday {
                    Text("Today") // ✅ Mostrar "Today" si es la fecha actual
                        .font(.headline)
                } else {
                    Text(dayOfMonthFormatter.string(from: dateToDisplay)) // Día del mes
                        .font(.title)
                    Text(monthNameFormatter.string(from: dateToDisplay)) // Mes
                        .font(.caption)
                }
            }
            .foregroundStyle(.white)
        }
        .frame(width: panelSize, height: panelSize)
        .offset(x: xOffset)
        .opacity(xOffset + positionWidth < -halfFullWidth || xOffset - positionWidth > halfFullWidth ? 0 : 1)
    }
    
    private var dragged: some Gesture {
        DragGesture()
            .onChanged { val in
                draggedDayOffset = Double(snappedDayOffset) - (val.translation.width / positionWidth)
            }
            .onEnded { val in
                snappedDayOffset = Int(Double(snappedDayOffset) - (val.predictedEndTranslation.width / positionWidth).rounded())
                
                withAnimation(.easeInOut(duration: 0.15)) {
                    draggedDayOffset = Double(snappedDayOffset)
                }
                
                // Actualizar la fecha seleccionada
                if let newDate = Calendar.current.date(byAdding: .day, value: snappedDayOffset, to: baseDate) {
                    selectedDate = newDate
                }
            }
    }
    
    var body: some View {
        GeometryReader { proxy in
            let halfFullWidth = proxy.size.width / 2
            ZStack {
                ForEach(0..<nPanels, id: \.self) { index in
                    dateView(index: index, halfFullWidth: halfFullWidth)
                }
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 3)
                    .opacity(0.7)
                    .frame(width: positionWidth, height: positionWidth)
            }
            .gesture(dragged)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    CalendarView(selectedDate: .constant(Date()))
}
