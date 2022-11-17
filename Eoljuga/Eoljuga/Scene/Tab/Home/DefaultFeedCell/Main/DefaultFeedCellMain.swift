//
//  DefaultFeedCellMain.swift
//  Eoljuga
//
//  Created by youtak on 2022/11/17.
//

import UIKit

import SnapKit

class DefaultFeedCellMain: UIView {

    lazy var titleLabel = UILabel().then {
        $0.textAlignment = .left
        $0.textColor = UIColor.black
        $0.font = UIFont.bold14
        print(UIFont.bold14.pointSize)
        $0.text = """
        [Swift 5.7+][Concurrency] AsyncStream, AsyncThrowingStream 알아보기 - Continuation vs unfoldin
        g [Swift 5.7+][Concurrency
        """
        $0.lineHeight160()
        $0.lineBreakMode = .byWordWrapping
        $0.lineBreakStrategy = .hangulWordPriority
        $0.numberOfLines = 3
    }

    lazy var thumbnailImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = Constant.Image.thumbnailCornerRadius.cgFloat
        $0.backgroundColor = UIColor.systemGray2
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        configureThumbnailImageView()
        configureTitleLabel()
    }

    private func configureThumbnailImageView() {
        addSubview(thumbnailImageView)
        thumbnailImageView.snp.makeConstraints {
            $0.height.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.width.equalTo(Constant.Image.thumbnailWidth)
        }
    }

    private func configureTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(thumbnailImageView.snp.leading).offset(-Constant.space8)
        }
    }
}
