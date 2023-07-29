import Foundation

@propertyWrapper
final class Observable<Value> {
    private var observer: ((Value) -> Void)?
    
    var wrappedValue: Value {
        didSet {
            observer?(wrappedValue)
        }
    }
    
    var projectedValue: Observable<Value> {
        return self
    }
    
    init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }
    
    func observe(action: @escaping (Value) -> Void) {
        self.observer = action
    }
}
