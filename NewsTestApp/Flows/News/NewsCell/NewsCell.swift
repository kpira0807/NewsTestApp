import Foundation
import UIKit
import SnapKit

final class NewsCell: UITableViewCell {
    
    static let identifier = "NewsCell"
    
    private let backView = UIView()
    private let titleLabel = UILabel()
    private let newsImage = ImageView()
    private let authorLabel = UILabel()
    private let publishedAtLabel = UILabel()
    private let sourceLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        titleLabel.attributedText = nil
        authorLabel.attributedText = nil
        publishedAtLabel.attributedText = nil
        sourceLabel.attributedText = nil
        descriptionLabel.attributedText = nil
        newsImage.image = nil
        
        super.prepareForReuse()
    }
    
    func setup(_ viewModel: NewsCellViewModel) {
        titleLabel.text = viewModel.title
        newsImage.set(urlString: viewModel.image)
        authorLabel.text = viewModel.author
        publishedAtLabel.text = viewModel.publishedAt
        sourceLabel.text = viewModel.source
        descriptionLabel.text = viewModel.description
    }
    
}

extension NewsCell {
    
    private func setupView() {
        addSubview(backView)
        backView.accessibilityIdentifier = "backView"
        backView.layer.cornerRadius = 8.0
        backView.layer.borderWidth = 1.0
        backView.layer.borderColor = Asset.borderColor.color.cgColor
        backView.backgroundColor = Asset.backgroundColor.color
        backView.snp.makeConstraints{make in
            make.top.equalToSuperview().offset(8.0)
            make.bottom.equalToSuperview().inset(8.0)
            make.leading.equalToSuperview().offset(8.0)
            make.trailing.equalToSuperview().inset(8.0)
        }
        
        backView.addSubview(titleLabel)
        titleLabel.accessibilityIdentifier = "titleLabel"
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.textColor = Asset.textTitleColor.color
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14.0)
        titleLabel.snp.makeConstraints{make in
            make.top.equalToSuperview().offset(8.0)
            make.leading.equalToSuperview().offset(8.0)
            make.trailing.equalToSuperview().inset(8.0)
        }
        
        backView.addSubview(newsImage)
        newsImage.accessibilityIdentifier = "newsImage"
        newsImage.snp.makeConstraints{make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8.0)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(180.0)
        }
        
        backView.addSubview(authorLabel)
        authorLabel.accessibilityIdentifier = "authorLabel"
        authorLabel.numberOfLines = 0
        authorLabel.textAlignment = .left
        authorLabel.textColor = Asset.textColor.color
        authorLabel.font = UIFont.boldSystemFont(ofSize: 12.0)
        authorLabel.snp.makeConstraints{make in
            make.top.equalTo(newsImage.snp.bottom).offset(8.0)
            make.leading.equalToSuperview().offset(8.0)
            make.trailing.equalToSuperview().inset(8.0)
        }
        
        backView.addSubview(publishedAtLabel)
        publishedAtLabel.accessibilityIdentifier = "publishedAtLabel"
        publishedAtLabel.numberOfLines = 0
        publishedAtLabel.textAlignment = .left
        publishedAtLabel.textColor = Asset.textColor.color
        publishedAtLabel.font = UIFont.boldSystemFont(ofSize: 12.0)
        publishedAtLabel.snp.makeConstraints{make in
            make.top.equalTo(authorLabel.snp.bottom).offset(8.0)
            make.leading.equalToSuperview().offset(8.0)
            make.trailing.equalToSuperview().inset(8.0)
        }
        
        
        backView.addSubview(sourceLabel)
        sourceLabel.accessibilityIdentifier = "sourceLabel"
        sourceLabel.numberOfLines = 0
        sourceLabel.textAlignment = .left
        sourceLabel.textColor = Asset.textColor.color
        sourceLabel.font = UIFont.boldSystemFont(ofSize: 12.0)
        sourceLabel.snp.makeConstraints{make in
            make.top.equalTo(publishedAtLabel.snp.bottom).offset(8.0)
            make.leading.equalToSuperview().offset(8.0)
            make.trailing.equalToSuperview().inset(8.0)
        }
        
        backView.addSubview(descriptionLabel)
        descriptionLabel.accessibilityIdentifier = "descriptionLabel"
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .left
        descriptionLabel.textColor = Asset.textColor.color
        descriptionLabel.font = UIFont.boldSystemFont(ofSize: 12.0)
        descriptionLabel.snp.makeConstraints{make in
            make.top.equalTo(sourceLabel.snp.bottom).offset(8.0)
            make.leading.equalToSuperview().offset(8.0)
            make.trailing.equalToSuperview().inset(8.0)
            make.bottom.equalToSuperview().inset(8.0)
        }
    }
    
}
