//
//  BaseViewController.swift
//  Movies Demo
//
//  Created by Rain on 2024.02.24.
//

import UIKit
import SPIndicator
class BaseViewController: UIViewController {
    weak var coordinator: MainCoordinator?
    var navigationBar: NavigationView!
    var scrollView: UIScrollView!
    enum DropAlertType:String{
        case successful
        case unsuccessful
        case info
        case text
    }
    enum PlaceHolderType:String{
        case search
        case noResult
        case notFavorited
        case hide
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(hex: "FFFFFF", alpha: 1)
        var safeArea = 0.0 as CGFloat
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let windows = windowScene.windows
            safeArea = (windows.first?.safeAreaInsets.top)!
            // Use 'windows' as needed
        }
        
        scrollView = UIScrollView(frame: self.view.bounds)
        scrollView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)
        
        navigationBar = NavigationView(frame: CGRectMake(0, 0, self.view.bounds.width, Configs.navigationBarHeight + (UIApplication.shared.windows.first?.safeAreaInsets.top)!))
        self.view.addSubview(navigationBar)
        navigationBar.backButton.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    func showNavigation(_ show:Bool){
        navigationBar.isHidden = !show
    }
    @objc func dismiss(sender: UIButton!){
        if(self.isModal){
            print("isModal")
            self.dismiss(animated: true, completion: nil)
        }else{
            print("!isModal")
            self.navigationController?.popViewController(animated: true)
        }
    }
    public func showDropAlert(title:String?, message:String?, type:DropAlertType, completion: (() -> Void)? = nil){
        let indicatorView = SPIndicatorView(title: title ?? "", message: message)
        indicatorView.dismissByDrag = true
        indicatorView.subtitleLabel?.numberOfLines = 0
        DispatchQueue.main.async {
            switch type {
            case .successful:
                indicatorView.present(haptic: .success) {
                    (completion ?? {})()
                }
            case .unsuccessful:
                indicatorView.present(haptic: .error) {
                    (completion ?? {})()
                }
            case .info:
                indicatorView.present(haptic: .warning) {
                    (completion ?? {})()
                }
            case .text:
                indicatorView.present(haptic: .none) {
                    (completion ?? {})()
                }
            }
            
        }
    }
    
   
//    override func viewWillAppear() {
//        showNavbar(navBarIsShown)
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat) {
        var hexValue = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexValue.hasPrefix("#") {
            hexValue.remove(at: hexValue.startIndex)
        }

        var rgbValue: UInt64 = 0
        Scanner(string: hexValue).scanHexInt64(&rgbValue)

        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
extension UILabel{
    func font(_ name:Fonts, size:CGFloat){
        self.font =  UIFont(name: name.rawValue, size: size)!
    }
}
extension BaseViewController {
    var isModal: Bool {
        let presentingIsModal = presentingViewController != nil
        let presentingIsNavigation = navigationController?.presentingViewController?.presentedViewController == navigationController
        let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController
        return presentingIsModal || presentingIsNavigation || presentingIsTabBar
    }
}
