import Foundation
import Capacitor
import SSZipArchive

@objc(ZipperPlugin)
public class ZipperPlugin: CAPPlugin, CAPBridgedPlugin {
    public let identifier = "ZipperPlugin"
    public let jsName = "Zipper"
    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "zip", returnType: .callback),
        CAPPluginMethod(name: "unZip", returnType: .callback)
    ]

    @objc func zip(_ call: CAPPluginCall) {
        var source = call.getString("source") ?? ""
        var destination = call.getString("destination") ?? ""
        let keepParent = call.getBool("overwrite") ?? true
        let password = call.getString("password")

        source = source.replacingOccurrences(of: "_capacitor_", with: "file://")
            .replacingOccurrences(of: "file://", with: "")
        destination = destination.replacingOccurrences(of: "file://", with: "")

        var progress = 0
        let completed = SSZipArchive.createZipFile(atPath: destination, withContentsOfDirectory: source, keepParentDirectory: keepParent, compressionLevel: -1, password: password, aes: true, progressHandler: { (entryNumber, entriesTotal) in
            if entriesTotal > 0 {
                let percent = entryNumber * 100 / entriesTotal
                if percent != progress {
                    progress = percent
                    call.resolve([
                        "status": "progressing",
                        "progress": progress,
                        "completed": false
                    ])
                }
            }
        })

        if completed {
            call.resolve([
                "status": "completed",
                "progress": 100,
                "completed": true
            ])
        } else {
            call.reject("Error creating zip file.")
        }
    }

    @objc func unZip(_ call: CAPPluginCall) {
        var source = call.getString("source") ?? ""
        var destination = call.getString("destination") ?? ""
        let overwrite = call.getBool("overwrite") ?? true
        let password = call.getString("password")

        source = source.replacingOccurrences(of: "_capacitor_", with: "file://")
            .replacingOccurrences(of: "file://", with: "")
        destination = destination.replacingOccurrences(of: "file://", with: "")

        var progress = 0
        SSZipArchive.unzipFile(atPath: source, toDestination: destination, overwrite: overwrite, password: password, progressHandler: { (_, _, entryNumber, entriesTotal) in
            if entriesTotal > 0 {
                let percent = entryNumber * 100 / entriesTotal
                if percent != progress {
                    progress = percent
                    call.resolve([
                        "status": "progressing",
                        "progress": progress,
                        "completed": false
                    ])
                }
            }
        }, completionHandler: { (_, succeeded, error) in
            if succeeded {
                call.resolve([
                    "status": "completed",
                    "progress": 100,
                    "completed": true,
                    "path": destination
                ])
            } else {
                call.reject(error?.localizedDescription ?? "Unknown error")
            }
        })
    }
}