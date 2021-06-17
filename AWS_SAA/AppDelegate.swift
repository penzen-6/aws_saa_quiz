import UIKit
import CoreData

extension NSPersistentCloudKitContainer {
    
    func saveContext() {
        saveContext(context: viewContext)
    }
    
    func saveContext(context: NSManagedObjectContext) {
        guard context.hasChanges else {
            return
        }
        
        do {
            try context.save()
        }
        
        catch let error as NSError {
            print("Error: \(error), \(error.userInfo)")
        }
    }
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AWS_SAA")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print(error.userInfo)
            }
        })
        return container
    }()
    
    // using CoreData defined functions
    
    func addNewToDoItem(userName: String, password: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newItem = Entity(context: context)
        newItem.userName = userName
        newItem.password = password
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getAllPlannerDays() -> [Entity] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let savedPlaceFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "AWS_SAA")
        do {
            let result = try context.fetch(savedPlaceFetch)
            if let convertedResult = result as? [Entity] {
                return convertedResult
            }
        } catch {
            return []
        }
        return []
    }
    
    func modifyObject(_ object: Entity, temporaly: String) {
        object.password = temporaly
        //save
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteObject(_ object: NSManagedObject) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        context.delete(object)
        //save
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    

    

    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

