import UIKit

final class ResponseHeader: UITableViewHeaderFooterView {
    
    static let identifier = "ResponseCell"

    let title = UILabel()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
        setupHierarchy()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        title.numberOfLines = 0
        title.font = UIFont.systemFontOfSize(12)
    }

    private func setupHierarchy() {
        contentView.addSubview(title)
    }

    private func setupLayout() {
        title.pinToSuperview([.Left, .Right], constant: 16)
        title.pinToSuperview([.Top, .Bottom], constant: 8)
    }
    
}
