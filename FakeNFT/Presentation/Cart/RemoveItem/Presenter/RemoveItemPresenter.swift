//
//  RemoveItemPresenter.swift
//  FakeNFT
//
//  Created by Anton Vikhlyaev on 14.07.2023.
//

import Foundation
import Kingfisher

protocol RemoveItemPresenterProtocol {
    func viewIsReady()
    func didTapDeleteButton()
}

protocol RemoveItemDelegate: AnyObject {
    func didDeleteItem(_ item: Item)
}

final class RemoveItemPresenter {
    
    // MARK: - Properties
    
    private let item: Item
    
    weak var view: RemoveItemViewProtocol?
    
    private weak var delegate: RemoveItemDelegate?
    
    // MARK: - Life Cycle
    
    init(item: Item, delegate: RemoveItemDelegate) {
        self.item = item
        self.delegate = delegate
    }
    
}

// MARK: - RemoveItemPresenterProtocol

extension RemoveItemPresenter: RemoveItemPresenterProtocol {
    func viewIsReady() {
        guard
            let imageUrlString = item.images.first,
            let imageUrl = URL(string: imageUrlString)
        else { return }
        KingfisherManager.shared.retrieveImage(with: imageUrl) { [weak self] result in
            guard let image = try? result.get().image else { return }
            self?.view?.showItemImage(image)
        }
    }
    
    func didTapDeleteButton() {
        delegate?.didDeleteItem(item)
    }
}
