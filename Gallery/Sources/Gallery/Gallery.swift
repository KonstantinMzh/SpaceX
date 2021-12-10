import UIKit


public class Gallery: UIView {
    
    public var images: [String] = [] {
        didSet {
            collectionView.reloadData()
            if images.count > 0 {
                collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: false)
            }
        }
    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 150, height: 100)
        layout.estimatedItemSize = CGSize(width: 200, height: 150)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(GalleryCell.self, forCellWithReuseIdentifier: GalleryCell.cellID)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    public init() {
        super.init(frame: .zero)
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setView() {
        collectionView.dataSource = self
        
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }
    
}



extension Gallery: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCell.cellID,
                                                            for: indexPath) as? GalleryCell else { return UICollectionViewCell() }
        cell.prepareCell(imageURL: images[indexPath.row])
        return cell
    }
    
}
