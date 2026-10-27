//
//  main.swift
//  OperationQueueThreadLab
//
//  Created by Erik Valencia Cardona on 27/10/26.
//

import Foundation

final class OperationQueueThreadLab {
    
    private let customQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.name = "com.example.operation-queue-thread-lab"
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
    private func createOperation() -> BlockOperation {
        return BlockOperation {
            print("Operation A started")
            print("Is main thread: \(Thread.isMainThread)")
            
            for _ in 0..<1000000 {
                // Nothing
            }
            
            print("OPERATION A FINISHED")
        }
    }
    
    
    
    func runTest(onMainQueue: Bool) {
        let operation = createOperation()
        
        if onMainQueue {
            print("Running on OperationQueue.main")
            OperationQueue.main.addOperation(operation)
            // Allow the main queue to execute the operation.
                    while !operation.isFinished {
                        RunLoop.main.run(
                            mode: .default,
                            before: Date(timeIntervalSinceNow: 0.1)
                        )
                    }
        } else {
            print("Running on custom OperationQueue")
            customQueue.addOperation(operation)
            operation.waitUntilFinished()

        }
        
    }
}



let lab = OperationQueueThreadLab()

lab.runTest(onMainQueue: true)
print("------------------")
lab.runTest(onMainQueue: false)
