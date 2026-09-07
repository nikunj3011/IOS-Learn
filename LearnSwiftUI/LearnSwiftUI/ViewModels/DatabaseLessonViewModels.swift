import Combine
import CoreData
import Foundation

@MainActor
final class CoreDataLessonViewModel: ObservableObject {
    @Published private(set) var itemCount = 0
    @Published private(set) var status = "In-memory Core Data store is ready"
    private let context: NSManagedObjectContext
    private let entityName = "LearningItem"

    init() {
        let model = NSManagedObjectModel()
        let entity = NSEntityDescription()
        entity.name = entityName
        entity.managedObjectClassName = NSStringFromClass(NSManagedObject.self)
        let title = NSAttributeDescription()
        title.name = "title"
        title.attributeType = .stringAttributeType
        entity.properties = [title]
        model.entities = [entity]

        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        try? coordinator.addPersistentStore(
            type: .inMemory,
            configuration: nil,
            at: URL(fileURLWithPath: "/dev/null")
        )
        context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = coordinator
    }

    func insert() {
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) else { return }
        let object = NSManagedObject(entity: entity, insertInto: context)
        object.setValue("Core Data item \(itemCount + 1)", forKey: "title")
        do {
            try context.save()
            itemCount = try context.count(for: NSFetchRequest(entityName: entityName))
            status = "Context saved successfully"
        } catch { status = error.localizedDescription }
    }
}

@MainActor
final class SQLiteLessonViewModel: ObservableObject {
    @Published private(set) var titles: [String] = []
    @Published private(set) var status = "In-memory SQLite database is ready"
    private var store: SQLiteStore?

    init() { store = try? SQLiteStore() }

    func insert() {
        do {
            try store?.insert(title: "SQL row \(titles.count + 1)")
            titles = try store?.titles() ?? []
            status = "INSERT and SELECT completed"
        } catch { status = error.localizedDescription }
    }
}
