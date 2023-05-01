//
//  SceneDelegate.swift
//  SOPT_TVING
//
//  Created by 김인영 on 2023/04/14.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        

        guard let windowScene = (scene as? UIWindowScene) else { return }

        self.window = UIWindow(windowScene: windowScene)
         let navigationController = UINavigationController(rootViewController: LoginVC())
        self.window?.rootViewController = navigationController
         navigationController.setNavigationBarHidden(true, animated: false)
        self.window?.makeKeyAndVisible()
    }
    
    func changeRootVC(_ vc:UIViewController, animated: Bool) {
        guard let window = self.window else { return }
        window.rootViewController = UINavigationController(rootViewController: vc)
        vc.navigationController?.navigationBar.isHidden = true
    }
}
