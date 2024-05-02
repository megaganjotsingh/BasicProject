//
//  Commom.swift
//  BasicProject
//
//  Created by Gaganjot Singh on 02/05/24.
//

import Foundation

func onMainThread(after: TimeInterval = 0, _ workItem: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + after, execute: workItem)
}
