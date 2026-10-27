# Swift Operation Queue Thread Lab

A Swift learning exercise exploring `BlockOperation`, `OperationQueue`, and the differences between executing operations on the main queue and a custom operation queue.

## 🎯 Objective

Create a block-based operation and investigate which thread executes it when added to:

1. `OperationQueue.main`
2. A custom instance of `OperationQueue`

The goal is to understand how operation queues manage execution and how to verify thread behavior using Xcode's debugger.

## 🧠 Concepts Covered

- **`BlockOperation`** — Encapsulates a closure as an operation.
- **`OperationQueue`** — Manages and schedules the execution of operations.
- **`OperationQueue.main`** — Schedules operations on the main thread.
- **Custom `OperationQueue`** — Manages operations independently of the main operation queue.
- **`Thread.isMainThread`** — Checks whether the current code is executing on the main thread.
- **`waitUntilFinished()`** — Blocks the calling thread until an operation completes.
- **Xcode breakpoints** — Inspect execution and identify the current thread during debugging.

## ⚙️ Implementation

The project defines a `BlockOperation` that prints a start message, performs one million loop iterations, checks whether it is running on the main thread, and prints a completion message.

The operation can be submitted to either the main operation queue or a custom queue.

### Main operation queue

```swift
OperationQueue.main.addOperation(operation)
```

The operation executes on the main thread.

### Custom operation queue

```swift
customQueue.addOperation(operation)
```

The operation is scheduled by a separate queue. In this exercise, it executes on a background thread.

The custom queue is configured with:

```swift
queue.maxConcurrentOperationCount = 1
```

This limits the queue to one operation executing at a time.

## 🔬 Verification

The project uses `Thread.isMainThread` to help verify the execution context.

| Queue | Expected `Thread.isMainThread` | Execution context |
|---|---|---|
| `OperationQueue.main` | `true` | Main thread |
| Custom `OperationQueue` | `false` | Background thread in this exercise |

Breakpoints can also be placed inside the operation to inspect the current thread in Xcode's Debug navigator.

## 🛠️ Technologies

- Swift
- Foundation
- Xcode
- `BlockOperation`
- `OperationQueue`

## 🚀 How to Run

1. Clone or download this repository.
2. Open the Xcode project.
3. Run `lab.runTest(onMainQueue: true)` to test the main operation queue.
4. Run `lab.runTest(onMainQueue: false)` to test the custom operation queue.
5. Observe the console output and inspect the execution thread using breakpoints.

The two scenarios should be tested separately.

## 📂 Project Structure

```text
swift-operation-queue-thread-lab/
├── OperationQueueThreadLab/
│   └── main.swift
├── OperationQueueThreadLab.xcodeproj/
└── README.md
```

## 📚 Key Takeaway

`OperationQueue` provides a higher-level abstraction for managing operations, while the main operation queue is associated with the main thread. A custom operation queue allows the system to schedule operations independently of the main queue.

The actual execution thread of a custom operation is managed by the system and should not be assumed to be a specific thread without verification.

---

**Project type:** Swift learning exercise  
**Focus:** `BlockOperation`, `OperationQueue`, and thread inspection
