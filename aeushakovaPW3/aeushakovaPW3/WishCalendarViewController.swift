import UIKit

class WishCalendarViewController: UIViewController {
    private var collectionView: UICollectionView!
    
    private struct Constants {
        static let collectionViewInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        static let cellSpacing: CGFloat = 20
        static let cellHeight: CGFloat = 130
        static let itemsInSection: Int = 10
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentEventCreationView))
    }
    
    private var events: [WishEventModel] = []

    @objc func presentEventCreationView() {
        let eventCreationView = WishEventCreationView()
        eventCreationView.onSave = { [weak self] event in
            self?.events.append(event)
            self?.collectionView.reloadData()
        }
        eventCreationView.modalPresentationStyle = .overCurrentContext
        eventCreationView.modalTransitionStyle = .crossDissolve
        present(eventCreationView, animated: true, completion: nil)
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemPink
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = Constants.collectionViewInsets
        
        // Регистрация кастомной ячейки WishEventCell
        collectionView.register(WishEventCell.self, forCellWithReuseIdentifier: WishEventCell.reuseIdentifier)
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UICollectionViewDataSource
extension WishCalendarViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WishEventCell.reuseIdentifier, for: indexPath) as! WishEventCell
        let event = events[indexPath.row]
        cell.configure(with: event)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension WishCalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Здесь мы настраиваем размер ячейки
        return CGSize(width: collectionView.bounds.width - Constants.cellSpacing, height: Constants.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Действие при нажатии на ячейку (просто чтобы видеть, что нажатие происходит удачно)
        print("Cell tapped at index \(indexPath.item)")
    }
}
