//
//  BasePresenter.swift
//  TestInnocv
//
//  Created by CRISTIAN ESPES on 01/12/2019.
//  Copyright © 2019 Cristian Espes. All rights reserved.
//

import Foundation

protocol BasePresenter {
    func initialize()
    func update()
    func pause()
    func destroy()
}

extension BasePresenter {
    func initialize() {}
    func update() {}
    func pause() {}
    func destroy() {}
}
