//
//  ToggleLayoutView.swift
//  CustomLayout
//
//  Created by Kasharin Mikhail on 26.10.2023.
//

import SwiftUI

enum LayoutKind: String, CaseIterable {
    case myHStack = "HStack"
    case bottomDiagonal = "Diagonal"
    case topDiagonal = "Diagonal (top)"
    case vStack = "simple VStack"
    case hStack = "simple HStack"
    case circle = "Circle"
    case radial = "Radial"
    
    var layout: any Layout {
        switch self {
        case .myHStack: return CustomHStackLayout()
        case .bottomDiagonal: return BottomDiagonalLayout()
        case .topDiagonal: return TopDiagonalLayout()
        case .vStack: return VStackLayout()
        case .hStack: return HStackLayout()
        case .circle: return CircleLayout()
        case .radial: return RadialLayout()
        }
    }
}

struct ToggleLayoutView: View {
    @State private var layout: LayoutKind = .myHStack
    @State private var count = 7
    
    var body: some View {
        NavigationStack {
            AnyLayout(layout.layout) {
                ForEach(0 ..< self.count, id: \.self) { _ in
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.blue)
                        .onTapGesture {
                            withAnimation {
                                layout = layout.next
                            }
                        }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("\(layout.rawValue)")
            .toolbar {
                Button("-") { if count > 2 { count -= 1 } }
                Text("\(count)")
                Button("+") { count += 1 }
            }
        }
    }
}


struct ToggleLayoutView_Previews: PreviewProvider {
    static var previews: some View {
        ToggleLayoutView()
    }
}
