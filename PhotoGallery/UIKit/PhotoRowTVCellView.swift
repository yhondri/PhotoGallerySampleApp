import UIKit

protocol DownloadImageDelegate {
    func downloadImage(photo: PhotoData, completion: (() -> Void)?)
}

class PhotoRowTVCellView: UITableViewCell {
    static let cellIdentifier = "ElectricityPriceTVCell"
    
    private let photoImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let photoDescriptionLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    var delegate: DownloadImageDelegate? = nil
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.addSubview(photoImageView)
        contentView.addSubview(photoDescriptionLabel)
        
        let photoImageBottomConstraint = photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        photoImageBottomConstraint.priority =  UILayoutPriority(rawValue: 700)
        NSLayoutConstraint.activate([
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            photoImageBottomConstraint,
            photoImageView.widthAnchor.constraint(equalToConstant: 150),
            photoImageView.heightAnchor.constraint(equalToConstant: 150)
        ])
        NSLayoutConstraint.activate([
            photoDescriptionLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 8),
            photoDescriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            photoDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            photoDescriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    func configureCell(photoData: PhotoData) {
        photoDescriptionLabel.text = photoData.photo.photoDescription
        
        if photoData.photoState == .missing {
            delegate?.downloadImage(photo: photoData, completion: nil)
        }
        
        if let image = photoData.photoCache?.image.renderToUIImage() {
            photoImageView.image = image
        } else {
            photoImageView.image = UIImage(systemName: "arrow.down.circle.dotted")
        }
    }
}
