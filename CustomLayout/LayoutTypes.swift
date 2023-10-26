//
//  LayoutTypes.swift
//  CustomLayout
//
//  Created by Kasharin Mikhail on 26.10.2023.
//

import SwiftUI

struct BottomDiagonalLayout: Layout {
    func sizeThatFits(proposal: ProposedViewSize,
                      subviews: Subviews, cache: inout ()) -> CGSize
    {
        guard !subviews.isEmpty else { return .zero }
        return proposal.replacingUnspecifiedDimensions()
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize,
                       subviews: Subviews, cache: inout ())
    {
        guard !subviews.isEmpty else { return }
        let totalWidth = proposal.replacingUnspecifiedDimensions().width
        let totalHeight = proposal.replacingUnspecifiedDimensions().height

        let numbersOfViews = CGFloat(subviews.count)
        let widthOfOneView = totalHeight / numbersOfViews

        var currentY = bounds.maxY
        var currentX = bounds.minX

        for subview in subviews {
            let subviewSize = CGSize(width: widthOfOneView, height: widthOfOneView)
            let position = CGPoint(x: currentX, y: currentY)

            subview.place(at: position, anchor: .bottomLeading,
                          proposal: ProposedViewSize(subviewSize))

            currentY -= subviewSize.height
            currentX += (totalWidth - widthOfOneView) / (numbersOfViews - 1)
        }
    }
}

struct TopDiagonalLayout: Layout {
    func sizeThatFits(proposal: ProposedViewSize,
                      subviews: Subviews, cache: inout ()) -> CGSize
    {
        guard !subviews.isEmpty else { return .zero }
        return proposal.replacingUnspecifiedDimensions()
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize,
                       subviews: Subviews, cache: inout ())
    {
        guard !subviews.isEmpty else { return }
        let totalWidth = proposal.replacingUnspecifiedDimensions().width
        let totalHeight = proposal.replacingUnspecifiedDimensions().height

        let numbersOfViews = CGFloat(subviews.count)
        let widthOfOneView = totalHeight / numbersOfViews

        var currentY = bounds.minY
        var currentX = bounds.minX

        for subview in subviews {
            let subviewSize = CGSize(width: widthOfOneView, height: widthOfOneView)
            let position = CGPoint(x: currentX, y: currentY)

            subview.place(at: position, anchor: .topLeading,
                          proposal: ProposedViewSize(subviewSize))

            currentY += subviewSize.height
            currentX += (totalWidth - widthOfOneView) / (numbersOfViews - 1)
        }
    }
}

struct CustomHStackLayout: Layout {
    func sizeThatFits(proposal: ProposedViewSize,
                      subviews: Subviews, cache: inout ()) -> CGSize
    {
        guard !subviews.isEmpty else { return .zero }
        return proposal.replacingUnspecifiedDimensions()
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize,
                       subviews: Subviews, cache: inout ())
    {
        guard !subviews.isEmpty else { return }
        let totalWidth = proposal.replacingUnspecifiedDimensions().width

        let numbersOfViews = CGFloat(subviews.count)
        let totalSpacing = 8.0 * (numbersOfViews - 1)
        let widthOfOneView = (totalWidth - totalSpacing) / numbersOfViews

        let subviewSize = CGSize(width: widthOfOneView, height: widthOfOneView)

        let currentY = bounds.midY
        var currentX = bounds.minX + widthOfOneView / 2

        for subview in subviews {
            let position = CGPoint(x: currentX, y: currentY)

            subview.place(at: position, anchor: .center,
                          proposal: ProposedViewSize(subviewSize))

            currentX += widthOfOneView + totalSpacing / (numbersOfViews - 1)
        }
    }
}

struct CircleLayout: Layout {
    func sizeThatFits(proposal: ProposedViewSize, subviews:
        Subviews, cache: inout ()) -> CGSize
    {
        guard !subviews.isEmpty else { return .zero }
        return proposal.replacingUnspecifiedDimensions()
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize,
                       subviews: Subviews, cache: inout ())
    {
        guard !subviews.isEmpty else { return }
        let radius = min(bounds.size.width, bounds.size.height) / 2

        let angle = Angle.degrees(360 / Double(subviews.count)).radians

        let totalWidth = proposal.replacingUnspecifiedDimensions().width

        let oneWidth = totalWidth / CGFloat(subviews.count)
        let oneSize = CGSize(width: oneWidth, height: oneWidth)

        for (index, subview) in subviews.enumerated() {
            let xPos = cos(angle * Double(index) - .pi / 2) * (radius - oneSize.width / 2)
            let yPos = sin(angle * Double(index) - .pi / 2) * (radius - oneSize.height / 2)

            let point = CGPoint(
                x: bounds.midX + xPos - oneWidth / 2,
                y: bounds.midY + yPos)
            subview.place(at: point, anchor: .leading, proposal: ProposedViewSize(oneSize))
        }
    }
}

struct RadialLayout: Layout {
    func sizeThatFits(proposal: ProposedViewSize,
                      subviews: Subviews, cache: inout ()) -> CGSize
    {
        guard !subviews.isEmpty else { return .zero }
        return proposal.replacingUnspecifiedDimensions()
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize,
                       subviews: Subviews, cache: inout ())
    {
        guard !subviews.isEmpty else { return }
        let oneDimention = proposal.replacingUnspecifiedDimensions().width / CGFloat(subviews.count) / 2
        let subviewSize = CGSize(width: oneDimention, height: oneDimention)

        for (index, subview) in subviews.enumerated() {
            var point = CGPoint(x: 20 * index, y: 20 * index)
                .applying(CGAffineTransform(rotationAngle: CGFloat(index * 6 + 6)))

            point.x += bounds.midX
            point.y += bounds.midY

            subview.place(at: point, anchor: .center,
                          proposal: ProposedViewSize(subviewSize))
        }
    }
}
