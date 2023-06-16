//
//  SceneDelegate.swift
//  SearchUserInGithub
//
//  Created by 이성호 on 2023/06/14.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        if UserDefaultStorage.isLogin {
            let viewController = UINavigationController(rootViewController: SearchUserViewController())
            window?.rootViewController = viewController
        }
        else {
            let viewController = UINavigationController(rootViewController: LoginViewController())
            window?.rootViewController = viewController
            
        }
        window?.makeKeyAndVisible()
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            let code = url.absoluteString.components(separatedBy: "code=").last ?? ""
            print("url: ", url)
            print("code:", code)
            GithubOAuthManager.shared.requestAccessToken(with: code) { result in
                DispatchQueue.main.async {
                    self.pushViewController()
                }
                UserDefaultHandler.setIsLogin(isLogin: true)
            }
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }
}

extension SceneDelegate {
    private func pushViewController() {
        let viewController = SearchUserViewController()
        if let navigationController = self.window?.rootViewController as? UINavigationController {
            navigationController.pushViewController(viewController, animated: true)
        }
    }
    
    func logout() {
        self.clearUserDefaultData()
        print("UserDefaultStorage.isLogin: ", UserDefaultStorage.isLogin)
        print("UserDefaultStorage.accessToken", UserDefaultStorage.accessToken)
        window?.rootViewController = UINavigationController(rootViewController: LoginViewController())
    }
    
    private func clearUserDefaultData() {
        UserDefaultHandler.clearAllData()
    }
}
