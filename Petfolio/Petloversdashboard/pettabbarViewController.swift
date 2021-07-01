//
//  pettabbarViewController.swift
//  Petfolio
//


//
//  SHCircleBarController.swift
//  SHCircleBar
//
//  Created by Adrian Perțe on 19/02/2019.
//  Copyright © 2019 softhaus. All rights reserved.
//

import UIKit

class SHCircleBarControll: UITabBarController {

    fileprivate var shouldSelectOnTabBar = true
    private var circleView : UIView!
    private var circleImageView: UIImageView!
    open override var selectedViewController: UIViewController? {
        willSet {
            guard shouldSelectOnTabBar, let newValue = newValue else {
                shouldSelectOnTabBar = true
                return
            }
            guard let tabBar = tabBar as? SHCircleBar, let index = viewControllers?.index(of: newValue) else {return}
            tabBar.select(itemAt: index, animated: true)
        }
    }
    
    open override var selectedIndex: Int {
        willSet {
            guard shouldSelectOnTabBar else {
                shouldSelectOnTabBar = true
                return
            }
            guard let tabBar = tabBar as? SHCircleBar else {
                return
            }
            tabBar.select(itemAt: selectedIndex, animated: true)
        }
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        let tabBar = SHCircleBar()
        self.setValue(tabBar, forKey: "tabBar")
        
        self.circleView = UIView(frame: .zero)
        circleView.layer.cornerRadius = 30
        circleView.backgroundColor = .white
        circleView.isUserInteractionEnabled = false
        
        self.circleImageView = UIImageView(frame: .zero)
        circleImageView.layer.cornerRadius = 30
        circleImageView.isUserInteractionEnabled = false
        circleImageView.contentMode = .center
        circleView.addSubview(circleImageView)
        self.view.addSubview(circleView)
        let tabWidth = self.view.bounds.width / CGFloat(self.tabBar.items?.count ?? 4)

        circleView.frame = CGRect(x: tabWidth / 2 - 30, y: self.tabBar.frame.origin.y - 30, width: 60, height: 60)
        circleImageView.frame = self.circleView.bounds
        circleView.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
    }
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let tabBar = tabBar as? SHCircleBar else {
                    return
                }
        tabBar.select(itemAt: Servicefile.shared.tabbar_selectedindex, animated: true)
        print("selected image",self.tabBar.selectedItem?.image as Any)
       
       //
       
            let tabWidth = self.view.bounds.width / CGFloat(5)
            UIView.animate(withDuration: 0.3) {
                self.circleView.frame = CGRect(x: (tabWidth * CGFloat(Servicefile.shared.tabbar_selectedindex) + tabWidth / 2 - 30), y: self.tabBar.frame.origin.y - 30 , width: 60, height: 60)
            }
            UIView.animate(withDuration: 0.15, animations: {
                self.circleImageView.alpha = 0
            }) { (_) in
                self.circleImageView.image = self.image(with: UIImage(named: "nhome"), scaledTo: CGSize(width: 30, height: 30))
                UIView.animate(withDuration: 0.15, animations: {
                    self.circleImageView.alpha = 1
                })
            }
          
        
        //
        
        if self.tabBar.selectedItem?.image == nil {
            circleImageView.image = image(with: self.tabBar.items?.first?.image , scaledTo: CGSize(width: 30, height: 30))
        }else{
            circleImageView.image = image(with: self.tabBar.selectedItem?.image , scaledTo: CGSize(width: 30, height: 30))
        }
        
    }
    
   
    
    
    private var _barHeight: CGFloat = 54
    open var barHeight: CGFloat {
        get {
            if #available(iOS 11.0, *) {
                return _barHeight + view.safeAreaInsets.bottom
            } else {
                return _barHeight
            }
        }
        set {
            _barHeight = newValue
            updateTabBarFrame()
        }
    }
    
    private func updateTabBarFrame() {
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = barHeight
        tabFrame.origin.y = self.view.frame.size.height - barHeight
        self.tabBar.frame = tabFrame
        tabBar.setNeedsLayout()
    }
    
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateTabBarFrame()
    }
    
    open override func viewSafeAreaInsetsDidChange() {
        if #available(iOS 11.0, *) {
            super.viewSafeAreaInsetsDidChange()
        }
        updateTabBarFrame()
    }
    
    open override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let idx = tabBar.items?.index(of: item) else { return }
        if  idx != selectedIndex, let controller = viewControllers?[idx] {
            shouldSelectOnTabBar = false
            selectedIndex = idx
            let tabWidth = self.view.bounds.width / CGFloat(self.tabBar.items!.count)
            UIView.animate(withDuration: 0.3) {
                self.circleView.frame = CGRect(x: (tabWidth * CGFloat(idx) + tabWidth / 2 - 30), y: self.tabBar.frame.origin.y - 15, width: 60, height: 60)
            }
            UIView.animate(withDuration: 0.15, animations: {
                self.circleImageView.alpha = 0
            }) { (_) in
                self.circleImageView.image = self.image(with: item.image, scaledTo: CGSize(width: 30, height: 30))
                UIView.animate(withDuration: 0.15, animations: {
                    self.circleImageView.alpha = 1
                })
            }
            delegate?.tabBarController?(self, didSelect: controller)
        }
    }
    private func image(with image: UIImage?, scaledTo newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, _: false, _: 0.0)
        image?.draw(in: CGRect(x: 0, y: 0, width: 30, height: 30))
        let newImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
}


//
//  SHCircleBar.swift
//  SHCircleBar
//
//  Created by Adrian Perțe on 19/02/2019.
//  Copyright © 2019 softhaus. All rights reserved.
//

import UIKit

@IBDesignable class SHCircleBar: UITabBar {
    var tabWidth: CGFloat = 0
    var index: CGFloat = 0 {
        willSet{
            self.previousIndex = index
        }
    }
    private var animated = false
    private var selectedImage: UIImage?
    private var previousIndex: CGFloat = 0
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
        
    }
    override func draw(_ rect: CGRect) {
        let fillColor: UIColor = .white
        tabWidth = self.bounds.width / CGFloat(self.items!.count)
        let bezPath = drawPath(for: index)
        
        bezPath.close()
        fillColor.setFill()
        bezPath.fill()
        let mask = CAShapeLayer()
        mask.fillRule = .evenOdd
        mask.fillColor = UIColor.white.cgColor
        mask.path = bezPath.cgPath
        if (self.animated) {
            let bezAnimation = CABasicAnimation(keyPath: "path")
            let bezPathFrom = drawPath(for: previousIndex)
            bezAnimation.toValue = bezPath.cgPath
            bezAnimation.fromValue = bezPathFrom.cgPath
            bezAnimation.duration = 0.3
            bezAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            mask.add(bezAnimation, forKey: nil)
        }
        self.layer.mask = mask

    }
    
    func select(itemAt: Int, animated: Bool) {
        self.index = CGFloat(itemAt)
        self.animated = animated
        self.selectedImage = self.selectedItem?.selectedImage
        self.selectedItem?.selectedImage = nil
        self.setNeedsDisplay()
    }
    
    func customInit(){
        self.tintColor = .white
        self.barTintColor = .white
        self.backgroundColor = .white
    }
    private func drawPath(for index: CGFloat) -> UIBezierPath {
        let bezPath = UIBezierPath()

        let firstPoint = CGPoint(x: (index * tabWidth) - 25, y: 0)
        let firstPointFirstCurve = CGPoint(x: ((tabWidth * index) + tabWidth / 4), y: 0)
        let firstPointSecondCurve = CGPoint(x: ((index * tabWidth) - 25) + tabWidth / 8, y: 52)

        let middlePoint = CGPoint(x: (tabWidth * index) + tabWidth / 2, y: 55)
        let middlePointFirstCurve = CGPoint(x: (((tabWidth * index) + tabWidth) - tabWidth / 8) + 25, y: 52)
        let middlePointSecondCurve = CGPoint(x: (((tabWidth * index) + tabWidth) - tabWidth / 4), y: 0)

        let lastPoint = CGPoint(x: (tabWidth * index) + tabWidth + 25, y: 0)
        bezPath.move(to: firstPoint)
        bezPath.addCurve(to: middlePoint, controlPoint1: firstPointFirstCurve, controlPoint2: firstPointSecondCurve)
        bezPath.addCurve(to: lastPoint, controlPoint1: middlePointFirstCurve, controlPoint2: middlePointSecondCurve)
        bezPath.append(UIBezierPath(rect: self.bounds))
        return bezPath
    }
    

}
