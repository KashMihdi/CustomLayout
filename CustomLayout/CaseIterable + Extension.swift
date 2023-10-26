//
//  CaseIterable + Extension.swift
//  CustomLayout
//
//  Created by Kasharin Mikhail on 26.10.2023.
//

import Foundation

extension CaseIterable where Self: Equatable {
    private var allCases: AllCases {
        Self.allCases
    }
    public var next: Self {
        let index = allCases.index(after: allCases.firstIndex(of:self)!)
        guard index != allCases.endIndex else { return allCases.first!}
        return allCases[index]
    }
}
