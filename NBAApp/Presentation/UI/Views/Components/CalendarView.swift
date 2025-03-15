//
//  CalendarView.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 13/03/25.
//

import SwiftUI

import SwiftUI

struct CalendarView: View {
    let nPanels = 15
    let panelSize: CGFloat = 80
    let gapSize: CGFloat = 10
    
    @Binding var selectedDate: Date
    @State private var snappedDayOffset = 0
    @State private var draggedDayOffset = Double.zero
    
    init(selectedDate: Binding<Date>) {
        self._selectedDate = selectedDate
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
        return index - snappedDayOffset
    }

    private func dateView(index: Int, halfFullWidth: CGFloat) -> some View {
        let xOffset = xOffsetForIndex(index: index)
        let dayAdjustment = dayAdjustmentForIndex(index: index)
        let dateToDisplay = Calendar.current.date(byAdding: .day, value: dayAdjustment, to: selectedDate) ?? selectedDate

        return ZStack {
            Color.black.cornerRadius(10)
            VStack {
                Text(dateToDisplay.toFormat(format: "d"))
                    .font(.title)
                Text(dateToDisplay.toFormat(format: "MMMM"))
                    .font(.caption)
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

                // Actualizar la fecha seleccionada sin afectar la referencia base
                if let newDate = Calendar.current.date(byAdding: .day, value: snappedDayOffset, to: selectedDate) {
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
            .onAppear {
                // Sincronizar el offset con la fecha seleccionada
                snappedDayOffset = Calendar.current.dateComponents([.day], from: Date(), to: selectedDate).day ?? 0
                draggedDayOffset = Double(snappedDayOffset)
            }
            .onChange(of: selectedDate) { newDate in
                snappedDayOffset = Calendar.current.dateComponents([.day], from: Date(), to: newDate).day ?? 0
                draggedDayOffset = Double(snappedDayOffset)
            }
        }
    }
}

#Preview {
    CalendarView(selectedDate: .constant(Date()))
}
