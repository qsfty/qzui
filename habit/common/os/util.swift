//
// Created by 李和 on 2021/8/6.
//

import Foundation


struct FileUtil {

    //创建文件夹
    static func mkdir(dir: URL) -> Bool{
        do {
            try FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
            return true
        } catch let error as NSError {
            print(error.localizedDescription)
            return false
        }
    }

    static func touch(file: URL) -> Bool{
        do {
            return try FileManager.default.createFile(atPath: file.path, contents: nil)
        } catch let error as NSError {
            print(error.localizedDescription)
            return false
        }
    }

    static func write(file: URL, data: String) -> Bool{
        do {
            try data.write(to: file, atomically: false, encoding: .utf8)
            return true
        } catch let error as NSError {
            print(error.localizedDescription)
            return false
        }
    }

    static func append(file: URL, data: String) -> Bool{
        do {
            try data.data(using: .utf8)?.append(to: file)
            return true
        } catch let error as NSError {
            print(error.localizedDescription)
            return false
        }
    }

    static func appendLine(file: URL, data: String) -> Bool{
        append(file: file, data: data.appending("\n"))
    }


    static func listDir(dir: URL) -> [URL] {
        do {
            return try FileManager.default.contentsOfDirectory(at: dir, includingPropertiesForKeys: [.fileSizeKey])
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
        return []
    }

    static func listDir2(dir: URL) -> [String] {
        do {
            return try FileManager.default.contentsOfDirectory(atPath: dir.path)
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
        return []
    }

    static func newPath(parent: URL, path: String) -> URL{
        parent.appendingPathComponent(path)
    }

    static func deleteFile(file: URL) -> Bool {
        do {
            //判断，如果是目录，不允许删除
            var directoryExists = ObjCBool.init(false)
            if(FileManager.default.fileExists(atPath: file.path, isDirectory: &directoryExists)) {
                if(directoryExists.boolValue && !listDir2(dir: file).isEmpty){
                    print("不允许删除有内容的目录")
                    return false
                }
                try FileManager.default.removeItem(at: file)
                return true
            }
            print("文件不存在")
        }
        catch let e as NSError {
            print(e.localizedDescription)
        }
        return false
    }

    static func forceDelete(file: URL) -> Bool {
        do {
            //判断，如果是目录，不允许删除
            if(FileManager.default.fileExists(atPath: file.path)) {
                try FileManager.default.removeItem(at: file)
                return true
            }
            print("文件不存在")
        }
        catch let e as NSError {
            print(e.localizedDescription)
        }
        return false
    }

    static func getFileDetail(file: URL) -> FileMeta?{
        do {
            let attrs = try FileManager.default.attributesOfItem(atPath: file.path)
            let dict = attrs as NSDictionary
            return FileMeta(name: file.path,
                    size: dict.fileSize(),
                    type: dict.fileType() ?? "",
                    gmtCreate: dict.fileCreationDate() ?? Date(),
                    gmtModify: dict.fileModificationDate() ?? Date(),
                    ownId: dict.fileOwnerAccountName() ?? "",
                    ownGroup: dict.fileGroupOwnerAccountName() ?? "")
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}

struct FileMeta {

    var name: String
    var size: UInt64
    var type: String
    var gmtCreate: Date
    var gmtModify: Date
    var ownId: String
    var ownGroup: String

}

extension Data {
    func append(to url: URL) throws {
        if let fileHandle = try? FileHandle(forWritingTo: url) {
            defer {
                fileHandle.closeFile()
            }
            fileHandle.seekToEndOfFile()
            fileHandle.write(self)
        } else {
            try write(to: url)
        }
    }
}