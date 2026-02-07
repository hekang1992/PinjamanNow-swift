//
//  StorageInfoProvider.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/7.
//

import Foundation

final class StorageInfoProvider {

    static func availableDiskSpace() -> Int64 {
        let url = URL(fileURLWithPath: NSHomeDirectory())
        let values = try? url.resourceValues(forKeys: [.volumeAvailableCapacityForImportantUsageKey])
        return Int64(values?.volumeAvailableCapacityForImportantUsage ?? 0)
    }

    static func totalDiskSpace() -> Int64 {
        let values = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory())
        return (values?[.systemSize] as? NSNumber)?.int64Value ?? 0
    }

    static func totalMemory() -> Int64 {
        return Int64(ProcessInfo.processInfo.physicalMemory)
    }

    static func availableMemory() -> Int64 {
        var stats = vm_statistics64()
        var size = mach_msg_type_number_t(MemoryLayout<vm_statistics64>.stride / MemoryLayout<integer_t>.stride)

        let hostPort = mach_host_self()
        let result = withUnsafeMutablePointer(to: &stats) {
            $0.withMemoryRebound(to: integer_t.self, capacity: Int(size)) {
                host_statistics64(hostPort, HOST_VM_INFO64, $0, &size)
            }
        }

        if result == KERN_SUCCESS {
            let free = Int64(stats.free_count + stats.inactive_count)
            return free * Int64(vm_page_size)
        }
        return 0
    }
}
