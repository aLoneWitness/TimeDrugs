// Copyright (c) 2022. Isaak Hanimann.
// This file is part of PsychonautWiki Journal.
//
// PsychonautWiki Journal is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public Licence as published by
// the Free Software Foundation, either version 3 of the License, or (at
// your option) any later version.
//
// PsychonautWiki Journal is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with PsychonautWiki Journal. If not, see https://www.gnu.org/licenses/gpl-3.0.en.html.

import SwiftUI

struct IngestionDrawable {
    let color: SubstanceColor
    let ingestionTime: Date
    let roaDuration: RoaDuration?
    let onsetDelayInHours: Double
    let horizontalWeight: Double
    let distanceFromStart: TimeInterval
    let timelineDrawable: TimelineDrawable
    var insetTimes = 0

    init(
        startGraph: Date,
        color: SubstanceColor,
        ingestionTime: Date,
        roaDuration: RoaDuration?,
        onsetDelayInHours: Double,
        verticalWeight: Double = 1,
        horizontalWeight: Double = 0.5
    ) {
        self.distanceFromStart = ingestionTime.timeIntervalSinceReferenceDate - startGraph.timeIntervalSinceReferenceDate
        self.color = color
        self.ingestionTime = ingestionTime
        self.roaDuration = roaDuration
        self.horizontalWeight = horizontalWeight
        if let full = roaDuration?.toFullTimeline(
            peakAndOffsetWeight: horizontalWeight,
            verticalWeight: verticalWeight,
            onsetDelayInHours: onsetDelayInHours
        ) {
            self.timelineDrawable = full
        } else if let onsetComeupPeakTotal = roaDuration?.toOnsetComeupPeakTotalTimeline(
            peakAndTotalWeight: horizontalWeight,
            verticalWeight: verticalWeight,
            onsetDelayInHours: onsetDelayInHours
        ) {
            self.timelineDrawable = onsetComeupPeakTotal
        } else if let onsetComeupTotal = roaDuration?.toOnsetComeupTotalTimeline(
            totalWeight: horizontalWeight,
            verticalWeight: verticalWeight,
            onsetDelayInHours: onsetDelayInHours
        ) {
            self.timelineDrawable = onsetComeupTotal
        } else if let onsetTotal = roaDuration?.toOnsetTotalTimeline(
            totalWeight: horizontalWeight,
            verticalWeight: verticalWeight,
            onsetDelayInHours: onsetDelayInHours
        ) {
            self.timelineDrawable = onsetTotal
        } else if let total = roaDuration?.toTotalTimeline(
            totalWeight: horizontalWeight,
            verticalWeight: verticalWeight,
            onsetDelayInHours: onsetDelayInHours
        ) {
            self.timelineDrawable = total
        } else if let onsetComeupPeak = roaDuration?.toOnsetComeupPeakTimeline(
            peakWeight: horizontalWeight,
            verticalWeight: verticalWeight,
            onsetDelayInHours: onsetDelayInHours
        ) {
            self.timelineDrawable = onsetComeupPeak
        } else if let onsetComeup = roaDuration?.toOnsetComeupTimeline(
            verticalWeight: verticalWeight,
            onsetDelayInHours: onsetDelayInHours
        ) {
            self.timelineDrawable = onsetComeup
        } else if let onset = roaDuration?.toOnsetTimeline(onsetDelayInHours: onsetDelayInHours) {
            self.timelineDrawable = onset
        } else {
            self.timelineDrawable = NoTimeline(onsetDelayInHours: onsetDelayInHours)
        }
        self.onsetDelayInHours = onsetDelayInHours
    }
}
