//
//  DefaultFeedCell.swift
//  Eoljuga
//
//  Created by youtak on 2022/11/16.
//

import Combine
import UIKit

import SnapKit

final class NormalFeedCell: UICollectionViewCell {

    private lazy var userInfoView = DefaultUserInfoView()
    private lazy var mainView = NormalFeedCellMain()
    lazy var footerView = NormalFeedCellFooter()

    var indexPath: IndexPath?
    let stateIndexPublisher = PassthroughSubject<StateIndexPath, Never>()
    var cancelBag = Set<AnyCancellable>()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureUI()
        bind()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        cancelBag.removeAll()
    }

    private func configureUI() {
        addSubViews([userInfoView, mainView, footerView])
        configureCell()
        configureHeaderStackView()
        configureMainStackView()
        configureFooterStackView()
    }

    private func configureCell() {
        backgroundColor = .clear
    }

    private func configureHeaderStackView() {
        userInfoView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Constant.Cell.normalTopMargin)
            $0.leading.equalToSuperview()
            $0.height.equalTo(Constant.Cell.normalHeaderHeight)
        }
    }

    private func configureMainStackView() {
        mainView.snp.makeConstraints {
            $0.top.equalTo(userInfoView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(Constant.Cell.normalMainHeight)
        }
    }

    private func configureFooterStackView() {
        footerView.snp.makeConstraints {
            $0.top.equalTo(mainView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(Constant.Cell.normalFooterHeight)
        }
    }

    private func bind() {
        footerView
            .scrapButton
            .statePublisher
            .sink { state in
                let stateIndexPath = StateIndexPath(state: state, indexPath: self.indexPath)
                self.stateIndexPublisher.send(stateIndexPath)
            }
            .store(in: &cancelBag)
    }
}

extension NormalFeedCell {
    func updateFeedCell(with feed: Feed) {
        userInfoView.updateView(feedWriter: feed.writer)
        mainView.updateView(feed: feed)
        footerView.updateView(feed: feed)
    }
}
