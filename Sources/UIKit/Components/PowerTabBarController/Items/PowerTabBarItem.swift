import UIKit

class PowerTabBarItem: PowerTabBarContainer {

    private var iconView: UIImageView!
    private var defaultImage: UIImage!
    private var selectedImage: UIImage?

    override init (frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func append(item: UITabBarItem) {
        guard let image = item.image else {
            fatalError("TabBar item has no image set.")
        }
        self.defaultImage = image
        self.selectedImage = item.selectedImage
        let rect = CGRect(x: (self.frame.width - self.defaultImage.size.width) / 2,
                          y: (self.frame.height - self.defaultImage.size.height) / 2,
                          width: self.frame.width,
                          height: self.frame.height)
        iconView = UIImageView(frame: rect)
        iconView.image = self.defaultImage
        iconView.sizeToFit()
        self.addSubview(iconView)
    }

    func set(isSelected: Bool) {
        if isSelected {
            guard let selectedImage = self.selectedImage else {
                return
            }
            iconView.image = selectedImage
        } else {
            iconView.image = defaultImage
        }
    }
}
