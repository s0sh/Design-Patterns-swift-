import Foundation
import UIKit

// MARK: - Factory method (один объект)
enum ClotheType {
    case head
    case shues
    case pants
}

protocol Clothes {
    var title: String { get }
    var type: ClotheType { get }
    var color: String { get }
    
    func putOn()
}

class Hat: Clothes {
    var title: String = "Hat"
    var type: ClotheType = .head
    var color: String = "Red"
    
    func putOn() {
        print ("\(title) put on with color \(color)")
    }
}

class Shoe: Clothes {
    var title: String = "Shues"
    var type: ClotheType = .shues
    var color: String = "white"
    
    func putOn() {
        print ("\(title) put on with color \(color)")
    }
}

class Jeans: Clothes {
    var title: String = "Jeans"
    var type: ClotheType = .pants
    var color: String = "blue"
    
    func putOn() {
        print ("\(title) put on with color \(color)")
    }
}

struct ClothesFactory {
    func createClothes(type: ClotheType) -> Clothes {
        switch type {
        case .shues:
            return Shoe()
        case .head:
            return Hat()
        case .pants:
            return Jeans()
        }
    }
}

let hat = ClothesFactory().createClothes(type: .head)
let shues = ClothesFactory().createClothes(type: .shues)
let pants = ClothesFactory().createClothes(type: .pants)

let clothes = [hat, shues, pants]

for clothes in clothes {
    clothes.putOn()
}
//-------------------------


// MARK: - Abstract factory (группа объектов)
protocol Top {
    var title: String { get }
    func putOn()
}

protocol Pants {
    var title: String { get }
    var color: String { get }
    func putOn()
}

class Jacket: Top {
    var title: String = "Jacket"
    
    func putOn() {
        print("Put on \(title)")
    }
    
}

class WindStopper: Top {
    var title: String = "WindStopper"
    func putOn() {
        print("Put on \(title)")
    }
}

class Trousers: Pants {
    var title: String = "Trousers"
    var color: String = "Blue"
    
    func putOn() {
        print("Put on \(title) color \(color)")
    }
    
}

class Triko: Pants {
    var title: String = "Triko"
    var color: String = "Black"
    
    func putOn() {
        print("Put on \(title) color \(color)")
    }
    
}

protocol AbstractFactory {
    func createTop() -> Top
    func createPants() -> Pants
}

class CasualFactory: AbstractFactory {
    func createTop() -> Top {
        return Jacket()
    }
    
    func createPants() -> Pants {
        return Trousers()
    }
}

class Sportsfactory: AbstractFactory {
    func createTop() -> Top {
        return WindStopper()
    }
    
    func createPants() -> Pants {
        return Triko()
    }
}

enum ActionType {
    case meeting
    case sport
}

var pantsAf: Pants?
var topAf: Top?
var factory: AbstractFactory?


var action: ActionType = .sport

switch action {
case .meeting:
    factory = CasualFactory()
case .sport:
    factory = Sportsfactory()
}

pantsAf = factory?.createPants()
topAf = factory?.createTop()
pantsAf?.putOn()
topAf?.putOn()

//------------------

// MARK: - Prototype

class Phone {
    var title: String
    var price: Double
    
    init(title: String, price: Double) {
        self.title = title
        self.price = price
    }
    // MARK: - Функция прототипирования
    func clone() -> Phone {
        let phone =  Phone(title: self.title, price: self.price)
        return phone
    }
}

let phone1 = Phone(title: "iPhone SE", price: 123.45)
let phone2 = phone1.clone()
phone2.title = "iPhone 14 Pro Max"
phone1.title
phone2.title

//-------------
// MARK: - Builder + Director

class Car {
    var title: String?
    var engineVolume: Double?
    var type: String?
    var maxLifting: Int?
    var color: String?
}

protocol CarBuilder {
    func reset()
    func setTitle()
    func setEngineVolume()
    func setType()
    func setLifting()
    func setColor()
    
    func getObject() -> Car
}

class BmwBuilder:  CarBuilder {
    
    private var bmw = Car()
    
    func reset() {
        self.bmw = Car()
    }
    
    func setTitle() {
        self.bmw.title = "BMW"
    }
    
    func setEngineVolume() {
        self.bmw.engineVolume = 2.5
    }
    
    func setType() {
        self.bmw.type = "Lighweight"
    }
    
    func setLifting() {
        self.bmw.maxLifting = 700
    }
    
    func setColor() {
        self.bmw.color = "Black"
    }
    
    func getObject() -> Car {
        return self.bmw
    }
    
}

class PlimuthBuilder:  CarBuilder {
    
    private var plimuth = Car()
    
    func reset() {
        self.plimuth = Car()
    }
    
    func setTitle() {
        self.plimuth.title = "Plimuth"
    }
    
    func setEngineVolume() {
        self.plimuth.engineVolume = 2.5
    }
    
    func setType() {
        self.plimuth.type = "Lighweight"
    }
    
    func setLifting() {
        self.plimuth.maxLifting = 480
    }
    
    func setColor() {
        self.plimuth.color = "Red"
    }
    
    func getObject() -> Car {
        return self.plimuth
    }
    
}

class Director {
    private var builder: CarBuilder
    
    init(builder: CarBuilder) {
        self.builder = builder
    }
    
    func setBuilder(builder: CarBuilder) {
        self.builder = builder
    }
    
    func createCar() -> Car {
        builder.reset()
        builder.setTitle()
        builder.setColor()
        builder.setLifting()
        builder.setType()
        builder.setEngineVolume()
        
        return builder.getObject()
    }
    
}

let bmwBuilder = BmwBuilder()
let plimuthBuilder = PlimuthBuilder()

let director = Director(builder: bmwBuilder)
let bmw = director.createCar()
director.setBuilder(builder: plimuthBuilder)
let plimuth = director.createCar()

bmw.title
plimuth.title

//---------------

// MARK: -  Chain of responsibility

protocol AccountType {
    var successor: AccountType? { get }
    var ballancce: Int { get }
    
    func setSuccessor(next: AccountType)
    func pay(ammount: Int)
    func canPay(ammount: Int) -> Bool
}

class Account: AccountType {
    var successor: AccountType?
    var title: String
    var ballancce: Int
    
    init(ballancce: Int, title: String) {
        self.title = title
        self.ballancce = ballancce
    }
    
    func setSuccessor(next: AccountType) {
        self.successor = next
    }
    
    func pay(ammount: Int) {
        if canPay(ammount: ammount) {
            self.ballancce -= ammount
            print("Good with cost of \(ammount) was bought.\nBallance: \(ballancce)\nAccount: \(title)")
        } else if let successor = successor {
            // Нет денег - передаем следующему счету обработать покупку (Chain works here)
            successor.pay(ammount: ammount)
        } else {
            print("I have no money :(")
        }
    }
    
    func canPay(ammount: Int) -> Bool {
        return self.ballancce >= ammount
    }
}

let cash = Account(ballancce: 10000, title: "Cash")
let debet = Account(ballancce: 15000, title: "Debet card")
let credit = Account(ballancce: 20000, title: "Credit card")

cash.setSuccessor(next: debet)
debet.setSuccessor(next: credit)
cash.pay(ammount: 5000)
cash.pay(ammount: 6000)
cash.pay(ammount: 13000)

cash.ballancce
debet.ballancce
credit.ballancce

//------------------------------
// MARK: - Command (смысл: упаковка действий в объекты.
// За каждую комманду отвечает определенный класс/объект)
/* Entities
 - Client - Send command (Отдает комманду)
 - Invoker - Dispatcher (decides who should commit a command)
   решает, кто будет исполнять комманду (один/многие)
 - Reciever - Command executor (Исполнитель комманды)
 - Command - command itself (собственно комманда)
 */

protocol Command {
    func execute()
}

class Officiant {
    func submit(command: Command) {
        command.execute()
    }
}

class Coocker {
    func makeSoup() {
        print("Soup has been made")
    }
    
    func makePotatoFree() {
        print("Potato Free has been made")
    }
}

class Barista {
    func makeCoffee() {
        print("Coffee has been made")
    }
    
    func makeCapuccino() {
        print("Capuccino has been made")
    }
}


class Client {
    
    var officiant: Officiant?
    
    func order(command: Command) {
        guard let officiant = officiant else {
            print("Officiant is unavailable")
            return
        }
        
        officiant.submit(command: command)
    }
}

class PrepareSoup: Command {
    let cooker = Coocker()
    func execute() {
        cooker.makeSoup()
    }
}

class PrepareCoffee: Command {
    let barista = Barista()
    func execute() {
        barista.makeCoffee()
    }
}

class PrepareCapuccino: Command {
    let barista = Barista()
    func execute() {
        barista.makeCapuccino()
    }
}

let client = Client()
let officiant = Officiant()

client.officiant = officiant
client.order(command: PrepareSoup())
client.order(command: PrepareCoffee())
client.officiant = nil
client.order(command: PrepareSoup())

//-----------------

// MARK: - Mediator

class User {
    private let name: String
    var mediator: ChatRoomType?

    init(name: String) {
        self.name = name
    }
    
    func getName() -> String {
        return self.name
    }
    
    func sendMessage(message: String) {
        guard let mediator = mediator else {
            print("Off chat")
            return
            
        }
        mediator.sendMessage(user: self, message: message)
    }
}

// Mediator protocol
protocol ChatRoomType {
    func sendMessage(user: User, message: String)
}

// Mediator implementation
class ChatRoom: ChatRoomType {
    func sendMessage(user: User, message: String) {
        let date = Date()
        let sender = user.getName()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyy hh:mm"
        let dateString = formatter.string(from: date)
        print("\(dateString)\n\(sender):\n\(message)\n------------")
    }
    
}
// Mediator implementation 2
class Respond: ChatRoomType {
    func sendMessage(user: User, message: String) {
        let date = Date()
        let sender = user.getName()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyy hh:mm"
        let dateString = formatter.string(from: date)
        print("\(dateString)\n\(sender):\n>>>>>>> \(message)\n------------")
    }
    
}

let mediator = ChatRoom()
let respondMediator = Respond()
let roman = User(name: "Roman")
let masha = User(name: "Masha")
roman.mediator = mediator
masha.mediator = respondMediator
roman.sendMessage(message: "Hi Mary!")
masha.sendMessage(message: "Hi yourself! How are you?")

// ---------------------

// MARK: - Visitor

protocol Attraction {
    func visitResult(age: Int?)
}

protocol Visitor {
    func visitSauna(_ sauna: Sauna)
    func visitSwimmingPool(_ swimmingPool: SwimmingPool)
    func visitWaterSlide(_ waterSLlide: WaterSLlide)
}

class Sauna: Attraction {
    var temp: Int
    let type: String
    
    init(temp: Int, type: String) {
        self.type = type
        self.temp = temp
    }
    
    func visitResult(age: Int?) {
        print("Sitting in \(self.type) sauna with temp \(self.temp)°С")
    }
}

class SwimmingPool: Attraction {
    func visitResult(age: Int?) {
        print("Swimming...")
    }
}

class WaterSLlide: Attraction {
    let minAge: Int
    let height: Int
    
    init(minAge: Int, height: Int) {
        self.minAge = minAge
        self.height = height
    }
    
    func visitResult(age: Int?) {
        guard let age = age, age >= minAge else {
            print("Your age is not allowed")
            return
        }
        print("Sliding...")
    }
}

class AttractionClient: Visitor {
    let age: Int
    
    init(age: Int) {
        self.age = age
    }
    
    func visitSauna(_ sauna: Sauna) {
        sauna.visitResult(age: age)
    }
    
    func visitSwimmingPool(_ swimmingPool: SwimmingPool) {
        swimmingPool.visitResult(age: age)
    }
    
    func visitWaterSlide(_ waterSLlide: WaterSLlide) {
        waterSLlide.visitResult(age: age)
    }
}

let sauna = Sauna(temp: 90, type: "Fineland")
let waterSLlide = WaterSLlide(minAge: 12, height: 145)
let pool = SwimmingPool()

let attractionClient = AttractionClient(age: 13)
attractionClient.visitSauna(sauna)
attractionClient.visitWaterSlide(waterSLlide)

// ----------------------

// MARK: - State

protocol NetworkState {
    func payment(ammount: Int) -> Bool
}

struct Connected: NetworkState {
    func payment(ammount: Int) -> Bool {
        print("Processing")
        return true
    }
}

struct Disconnected: NetworkState {
    func payment(ammount: Int) -> Bool {
        print("Network is not available. Try again later")
        return false
    }
}

struct Cart {
    private var state: NetworkState = Disconnected()
    var ballance = 5000
    
   mutating func setState(_ newState: NetworkState) {
        self.state = newState
    }
    
    mutating func pay(amount: Int) {
        guard ballance >= amount else {
            print("Not enouph money")
            return
        }
        guard self.state.payment(ammount: amount) else {
            print("Payment failed")
            return
        }
        
        self.ballance -= amount
        print("Payment success. Ballance \(self.ballance)")
    }
}

var cart =  Cart()
cart.pay(amount: 2000)
cart.setState(Connected())
cart.pay(amount: 2000)
cart.pay(amount: 6000)

// ------------------------

// MARK: - Strategy

protocol Strategy {
    func getData() -> Data?
    func sendData(data: DataModel) -> Bool
}

class Networking: Strategy {
    func sendData(data: DataModel) -> Bool {
        print("Send data to network")
        return true
    }
    
    func getData() -> Data? {
        print("Loading data from network")
        return nil
    }
}

class LocalStorage: Strategy {
    func getData() -> Data? {
        print("Loading data from local storage")
        return nil
    }
    
    func sendData(data: DataModel) -> Bool {
        print("Send data to local")
        return true
    }
}

class DataHandler: Strategy {
    private var strategy: Strategy
    
    init(strategy: Strategy) {
        self.strategy = strategy
    }
    
    func change(strategy: Strategy) {
        self.strategy = strategy
    }
    
    func getData() -> Data? {
        return strategy.getData()
    }
    
    func sendData(data: DataModel) -> Bool {
        strategy.sendData(data: data)
        return true
    }
    
}

struct DataModel {}

enum ServerError: Error {
    case dataCorrupted
}

protocol ViewModelProtocol {
    init(dataHandler: DataHandler)
    func loadData() -> Data?
    func sendData(data: DataModel) -> Bool
    func change(strategy: Strategy)
}

class ViewModel: ViewModelProtocol {
    private var dataHandler: DataHandler
    required init(dataHandler: DataHandler) {
        self.dataHandler = dataHandler
    }
    
    func loadData() -> Data? {
        return dataHandler.getData()
    }
    
    func change(strategy: Strategy) {
        dataHandler.change(strategy: strategy)
    }
    
    func sendData(data: DataModel) -> Bool {
        dataHandler.sendData(data: data)
    }
}

class MainView {
    
    var viewModel: ViewModelProtocol
    
    init(viewModel: ViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    func send(data: DataModel) {
        viewModel.sendData(data: data)
    }
    
    func changeStrategy(_ strategy: Strategy) {
        viewModel.change(strategy: strategy)
    }
}

let dataHandler = DataHandler(strategy: LocalStorage())
let viewModel = ViewModel(dataHandler: dataHandler)
let mainView = MainView(viewModel: viewModel)

mainView.send(data: DataModel())
mainView.changeStrategy(Networking())
mainView.send(data: DataModel())

// -------------


// MARK: - Adapter
protocol BMRImperialCalculation {
    func bmr(heigth: Double, weight: Double, age: Int) -> Int
}

struct BMRImperialCalculator: BMRImperialCalculation {
    func bmr(heigth: Double, weight: Double, age: Int) -> Int {
        return Int(66 + (6.2 * weight) + (12.7 * heigth) - (6.76 * Double(age)))
    }
}

protocol BMRMetricCalculation {
    func bmr(heigth: Double, weight: Double, age: Int) -> String
}

struct BMRCalculatorAdapter: BMRMetricCalculation {
    
    private var adaptee: BMRImperialCalculation
    
    init(adaptee: BMRImperialCalculation) {
        self.adaptee = adaptee
    }
    
    func bmr(heigth: Double, weight: Double, age: Int) -> String {
        let iHeight = heigth * 3.20004
        let iWeight = weight * 2.0462
        let result = adaptee.bmr(heigth: iHeight, weight: iWeight, age: age)
        return "BMR is \(result). \(result > 1000 ? "Hight" : "Low")"
    }
    
}

struct Person {
    func checkBMR(calculator: BMRMetricCalculation) {
        print(calculator.bmr(heigth: 1.84, weight: 68, age: 33))
    }
}

let persone = Person()
persone.checkBMR(calculator: BMRCalculatorAdapter(adaptee: BMRImperialCalculator()))


// MARK: - FACADE
final class Machine {
    enum State {
        case notRunning
        case ready
        case running
    }
    
    private(set) var state: State = .ready
    
    func startMachine() {
        print("Process starting...")
        state = .ready
        state = .running
        print("MACHINE IS RUNNING...")
    }
    
    func stopMachine() {
        print("Process stopping...")
        state = .notRunning
        print("MACHINE STOPED...")
    }
}

final class RequestManager {
    var isConnected = false
    
    func connectToTerminal() {
        print("Connecting...")
        isConnected = true
        print("Connected")
    }
    
    func disconnectFromTerminal() {
        print("Disconnecting...")
        isConnected = false
        print("Disconnected")
    }
    
    func getStatusRequest(machine: Machine) -> Machine.State {
        print("State requesting...")
        return machine.state
    }
    
    func sendStartRequest(for machine: Machine) {
        print("Sending request for starting machine... ")
        machine.startMachine()
    }
    
    func sendStopRequest(for machine: Machine) {
        print("Sending request for stop machine... ")
        machine.stopMachine()
    }
}

// Approach Without FACADE. Tight coupling.
let machine = Machine()
let manager = RequestManager()

if !manager.isConnected {
    manager.connectToTerminal()
}

if manager.getStatusRequest(machine: machine) == .ready {
    print("MACHINE IS READY")
    manager.sendStartRequest(for: machine)
}
// FACADE HERE
protocol Facade {
    func startMachine()
}

final class ConcrateFacade: Facade {
    func startMachine() {
        let machine = Machine()
        let manager = RequestManager()

        if !manager.isConnected {
            manager.connectToTerminal()
        }

        if manager.getStatusRequest(machine: machine) == .ready {
            print("MACHINE IS READY")
            manager.sendStartRequest(for: machine)
        }
    }
}
// Нам больше не нужно знать ничего о том что происходит внутри/под капотом
// Есть простой интерфейс к сложной системе
// Результат тот-же что и без фасада
let simpleInterface = ConcrateFacade()
simpleInterface.startMachine()

//------------------

// MARK: - Decorator

protocol Coffee {
    func cost() -> Double
    func ingredients() -> String
}

final class Espresso: Coffee {
    func cost() -> Double {
        return 35.0
    }
    
    func ingredients() -> String {
        return "Espresso"
    }
}

class CoffeeDecorator: Coffee {

    private var coffee: Coffee
    
    init(coffee: Coffee) {
        self.coffee = coffee
    }
    
    func cost() -> Double {
        coffee.cost()
    }
    
    func ingredients() -> String {
        coffee.ingredients()
    }
}

final class Milk: CoffeeDecorator {
    override func cost() -> Double {
        return super.cost() + 10
    }
    
    override func ingredients() -> String {
        return super.ingredients() + ", Milk"
    }
}

final class Whip: CoffeeDecorator {
    override func cost() -> Double {
        return super.cost() + 30
    }
    
    override func ingredients() -> String {
        return super.ingredients() + ", Whip"
    }
}

final class Chocolate: CoffeeDecorator {
    override func cost() -> Double {
        return super.cost() + 35
    }
    
    override func ingredients() -> String {
        return super.ingredients() + ", Chocolate"
    }
}

let espresso = Espresso()
let cappuccino = Whip(coffee: Milk(coffee: espresso))
let cappuccinoWithChocolate = Chocolate(coffee: cappuccino)

print(espresso.ingredients())
print(espresso.cost())

print(cappuccino.ingredients())
print(cappuccino.cost())

print(cappuccinoWithChocolate.ingredients())
print(cappuccinoWithChocolate.cost())

//----------- View decorator ------------//

protocol Element {
    var view: UIView { get }
    var description: String { get }
}

class SimpleView: Element {
    var view: UIView
    var description: String
    init(view: UIView) {
        self.view = view
        self.description = "Simple view"
    }
}

class Decorator: Element {
    var view: UIView
    var description: String
    
    init(element: Element) {
        self.view = element.view
        self.description = element.description
        self.view.clipsToBounds = true
    }
}

class UpgradeBorder: Decorator {
    override init(element: Element) {
        super.init(element: element)
        self.view.layer.borderWidth = 5
        self.view.layer.borderColor = UIColor.blue.cgColor
        self.description = element.description + " Added border"
        
    }
    
    convenience init(element: Element, width: CGFloat, color: CGColor) {
        self.init(element: element)
        self.view.layer.borderWidth = width
        self.view.layer.borderColor = color
    }
}

class UpgradeBackground: Decorator {
    override init(element: Element) {
        super.init(element: element)
        self.view.layer.backgroundColor = UIColor.red.cgColor
        self.description = element.description + " Added background"
    }
}

// Example usage //
weak var decoratedView: UIView!

 func deecorateView() {
    var element: Element = SimpleView(view: decoratedView)
    element = UpgradeBorder(element: element)
    element = UpgradeBackground(element: element)
    print(element.description)
}
