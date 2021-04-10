
import Foundation
import RxSwift
import CocoaMQTT

struct MQTTLibraryLive {
  var teste: Observable<Void>
  var publish: AnyObserver<Void>
}

extension MQTTLibraryLive {
  static var live = MQTTLibraryLive(
    teste: {
      
      let publish = PublishSubject<Void>().asObserver()
      publish.onNext(())
      return Observable<(CocoaMQTT, CocoaMQTTConnState)>.create { observer in
        
        let clientID = "CocoaMQTT-" + String(ProcessInfo().processIdentifier)
        let mqtt = CocoaMQTT(clientID: clientID, host: "localhost", port: 1883)
        mqtt.username = "test"
        mqtt.password = "public"
        //      mqtt.willMessage = .init(topic: "", payload: []) //CocoaMQTTWill(topic: "/will", message: "dieout")
        mqtt.keepAlive = 60
        mqtt.delegate = nil
        
        mqtt.didChangeState = { mqtt, state in
          switch state {
          case .disconnected, .connecting, .connected:
            break
          }
        }
        
        mqtt.didDisconnect = { mqtt, error in
          if let error = error {
            observer.onError(error)
          } else {
            observer.onCompleted()
          }
        }
        
        mqtt.didReceiveMessage = { mqtt, message, id in
          print("Message received in topic \(message.topic) with payload \(message.string!)")
        }
        
        guard mqtt.connect() == false else {
          observer.onError(NSError())
          return Disposables.create()
        }
        mqtt.subscribe("")
        mqtt.publish(.init(topic: "", payload: []))
        
        return Disposables.create {
          mqtt.disconnect()
        }
      }
      .map { _ in }
    }(),
    publish: PublishSubject<Void>().asObserver()
  )
}
