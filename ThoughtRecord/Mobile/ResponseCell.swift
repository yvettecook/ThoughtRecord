import UIKit

class ResponseCell: UITableViewCell {

    static let identifier = "ResponseCell"

    let response = UILabel()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupHierarchy()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        response.numberOfLines = 0
        response.font = UIFont.systemFontOfSize(12)
    }

    private func setupHierarchy() {
        contentView.addSubview(response)
    }

    private func setupLayout() {
        response.pinToSuperviewEdges(withInset: 18)
    }

}
