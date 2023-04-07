//
//  ViewAdaptable.swift
//  Test
//
//  Created by kevin on 2023/4/7.
//

import UIKit

protocol ViewAdaptable: AnyObject {}

extension ViewAdaptable {
    func configure<Adapter: ViewAdapting>(with viewAdapter: Adapter) where Adapter.View == Self {
        viewAdapter.render(self)
        viewAdapter.bind(self)
    }
}

protocol ViewAdapting: NSObject {
    associatedtype View: AnyObject
    associatedtype Model: AnyObject

    var model: Model { get set }

    func render(_ view: View)
    func bind(_ view: View)
}

extension ViewAdapting {
    func adaptView<Adapter: ViewAdapting>(with viewAdapter: Adapter) where Adapter.View == Self {
        viewAdapter.render(self)
        viewAdapter.bind(self)
    }

    static func makeAdapter(from model: Model) -> Self {
        let adapter = self.init()
        adapter.model = model
        return adapter
    }
}
