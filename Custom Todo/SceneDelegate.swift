//
//  SceneDelegate.swift
//  Custom Todo
//
//  Created by Pierpaolo Mariani on 18/07/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var savedShortCutItem : UIApplicationShortcutItem?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        if let shortcutItem = connectionOptions.shortcutItem { // get the shortCutItem here
                   savedShortCutItem = shortcutItem
               }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
//  perform  quick action even if the app is not loaded yet
        if savedShortCutItem != nil {
                  _ = handleShortcutItem(shortcutItem: savedShortCutItem!)
              }
    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
        }
    
    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem,
        completionHandler: @escaping (Bool) -> Void) {
        //  perform quick action if the app is already running
                let board : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                if shortcutItem.type == "addTodo" {
                let add : UIViewController
                let vc : UIViewController
                let navController : UINavigationController
                navController = board.instantiateViewController(withIdentifier: "Nav") as! UINavigationController
                 add = board.instantiateViewController(withIdentifier: "addTodo") as! AddToDoViewController
                 vc = board.instantiateViewController(withIdentifier: "root") as! ViewController
                window?.rootViewController? = navController
                vc.present(add, animated: true)
                navController.pushViewController(add, animated: true)
    }
        
}
    func handleShortcutItem(shortcutItem : UIApplicationShortcutItem) {
                let board : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                if shortcutItem.type == "addTodo" {
                let add : UIViewController
                let vc : UIViewController
                let navController : UINavigationController
                navController = board.instantiateViewController(withIdentifier: "Nav") as! UINavigationController
                 add = board.instantiateViewController(withIdentifier: "addTodo") as! AddToDoViewController
                 vc = board.instantiateViewController(withIdentifier: "root") as! ViewController
                window?.rootViewController? = navController
                vc.present(add, animated: true)
                navController.pushViewController(add, animated: true)
    }
    }
    
 
    


}
