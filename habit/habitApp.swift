//
//  habitApp.swift
//  habit
//
//  Created by 李和 on 2021/8/2.
//

import SwiftUI

@main
struct habitApp: App {
    var body: some Scene {
        WindowGroup{
            ContentView().environmentObject(AppStore()).edgesIgnoringSafeArea(.all)
            .onAppear{

                let downloadsDirectory = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first!
                print(downloadsDirectory.absoluteString)
                let downloadsDirectoryWithFolder = downloadsDirectory.appendingPathComponent("FolderToCreate")
                FileUtil.mkdir(dir: downloadsDirectoryWithFolder)

                let file = FileUtil.newPath(parent: downloadsDirectoryWithFolder, path: "hello.txt")

                print(FileUtil.touch(file: file))
                print(FileUtil.appendLine(file: file, data: "hello world"))
                print(FileUtil.appendLine(file: file, data: "hello java"))
                print(FileUtil.appendLine(file: file, data: "hello 123"))

                let files = FileUtil.listDir2(dir: downloadsDirectory)

                files.forEach{one in
                    let file = FileUtil.newPath(parent: downloadsDirectory, path: one)
                    print(FileUtil.getFileDetail(file: file))
                }

                print(FileUtil.deleteFile(file: downloadsDirectoryWithFolder))
                print(FileUtil.forceDelete(file: downloadsDirectoryWithFolder))
            }
        }
        .windowToolbarStyle(UnifiedCompactWindowToolbarStyle(showsTitle: false))
        .windowStyle(HiddenTitleBarWindowStyle())
    }
}
