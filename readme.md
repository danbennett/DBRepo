# DBRepo

A core library to create, update, delete and fetch model objects.

The goal is to create an abstraction from the CoreData/Realm/Other using Swift protocols and protocol extensions. 
By creating an abstraction through protocols the persistence strategy can be changed at compile time.

# Repostiry protocols
There are several protocols that are used throughout DBRepo for model object management. These can be used as mixins on concrete classes or protocol extensions.
#### RepoQueryType
    func fetch<T : EntityType>(type : T.Type, predicate : NSPredicate?) throws -> [T]
Given an argument of an `EntityType` type `fetch` shall return an array of that type. An optional `NSPredicate` can be provided to filter the query.

---

#### RepoSavingType
    func beginWrite()
    func endWrite() throws
Any changes which should be commited to the store should be wrapped in `beginWrite` and `endWrite` calls (examples below).

---

#### EntityType
    static var className : String { get }
This protocol should be used by all model objects. `className` will return the name of the final class for the model object (e.g. `"User"`).

---

#### RepoLifetimeType
    func addEntity<T : EntityType>(type : T.Type) throws -> T
    func removeEntity(entity : EntityType)
The `addEntity` method will create an object of the given `EntityType` type. The object will be added to the store and returned to the caller.

Calling `removeEntity` will delete the given object from the store.

# Examples
## Fetching
    let repo : RepoQueryType

    // Fetch all users
    let allUsers = try! repo.fetch(User.self, predicate: nil)
    
    // Fetch all active users
    let predicate = NSPredicate (format: "isActive == true")
    let activeUsers = try! repo.fetch(User.self, predicate: predicate)
    
## Saving
    let repo : protocol<RepoSavingType, RepoQueryType>
    
    if let user = try! repo.fetch(User.self, predicate: nil).first {
        repo.beginWrite()
        user.username = "mrdanb"
        try! repo.endWrite()
    }
    
## Creating
    let repo : RepoLifetimeType

    let user = try! repo.addEntity(User)

## Deleting
    let repo : protocol<RepoLifetimeType, RepoQueryType, RepoSavingType>

    if let user = try! repo.fetch(User.self, predicate: nil).first {
        repo.beginWrite()
        repo.removeEntity(user)
        try! repo.endWrite()
    }

# CoreData
The CoreData implmentation extends the NSManagedObjectContext to implement the repository protocols from the core library.

## Setup
    // .. CoreData setup...
    let moc: NSManagedObjectContext = self.managedObjectContext

    if let user = try! moc.fetch(User.self, predicate: nil).first {
        moc.beginWrite()
        moc.removeEntity(user)
        try! moc.endWrite()
    }

# Theading
It should be noted that an `NSManagedObjectContext` is not thread safe. When using CoreData `NSManagedObjectContext`s cannot be used accross threads.
As `DBRepo` uses `NSManagedObjectContext` in it's implmenetation the `repo` property should be treated as such.

# Errors
    // TODO: Include exampes.