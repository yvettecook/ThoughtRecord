import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        let splitViewController = self.window!.rootViewController as! UISplitViewController

        let leftNavController = splitViewController.viewControllers.first as! UINavigationController
        let masterViewController = leftNavController.topViewController as! RecordTableViewController

        let detailViewController = splitViewController.viewControllers[1] as! ReviewRecordViewController

        masterViewController.delegate = detailViewController

        detailViewController.navigationItem.leftItemsSupplementBackButton = true
        detailViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem()

        return true
    }

    func applicationWillResignActive(application: UIApplication) { }

    func applicationDidEnterBackground(application: UIApplication) { }

    func applicationWillEnterForeground(application: UIApplication) { }

    func applicationDidBecomeActive(application: UIApplication) { }

    func applicationWillTerminate(application: UIApplication) { }

}

