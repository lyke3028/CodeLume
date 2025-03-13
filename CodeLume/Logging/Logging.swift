//
//  Logging.swift
//  CodeLume
//
//  Created by Lyke on 2025/3/13.
//

import SwiftyBeaver
import Foundation

final class Logger {
    static let shared = Logger()
    
    private let logger = SwiftyBeaver.self
    private let console = ConsoleDestination()
    private let file = FileDestination()
    
    private init() {
        setupLogger()
    }
    
    struct Config {
        // 使用当前日期时间作为日志文件名
        static let logFileName: String = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd_HH-mm-ss"
            return "CodeLume_\(formatter.string(from: Date())).log"
        }()
        
        static let logDirectoryName = "Logs"
        static let consoleFormat = "[$Dyyyy-MM-dd HH:mm:ss.SSS] [$L] $N.$F.$l: $M"
        static let fileFormat = "[$Dyyyy-MM-dd HH:mm:ss.SSS] [$L] $N.$F.$l: $M"
        static let maxLogFileSize: UInt64 = 1 * 1024 * 1024 // 1MB
        static let maxLogFiles = 5
    }
    
    func setLogLevel(_ level: SwiftyBeaver.Level) {
        console.minLevel = level
        file.minLevel = level
    }
    
    func verbose(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        logger.verbose(message, file: file, function: function, line: line)
    }
    
    func debug(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        logger.debug(message, file: file, function: function, line: line)
    }
    
    func info(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        logger.info(message, file: file, function: function, line: line)
    }
    
    func warning(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        logger.warning(message, file: file, function: function, line: line)
    }
    
    func error(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        logger.error(message, file: file, function: function, line: line)
    }
    
    private func setupLogger() {
        logger.addDestination(console)
        let fileManager = FileManager.default
        
        if let documentsDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first {
            let logDirectory = documentsDirectory.appendingPathComponent(Config.logDirectoryName)
            let logFileURL = logDirectory.appendingPathComponent(Config.logFileName)
            
            do {
                try fileManager.createDirectory(at: logDirectory, withIntermediateDirectories: true, attributes: nil)
                
                if fileManager.fileExists(atPath: logFileURL.path) {
                    let attributes = try fileManager.attributesOfItem(atPath: logFileURL.path)
                    if let fileSize = attributes[.size] as? UInt64, fileSize >= Config.maxLogFileSize {
                        try rotateLogFiles(at: logFileURL)
                    }
                }
                
                file.logFileURL = logFileURL
            } catch {
                print("Error handling log file: \(error)")
            }
        }
        
        logger.addDestination(file)
        console.format = Config.consoleFormat
        file.format = Config.fileFormat
        
        logger.info("Logger initialized successfully. path: \(file.logFileURL?.path ?? "unknown")")
    }
    
    private func rotateLogFiles(at url: URL, fileManager: FileManager = .default) throws {
        logger.info("Rotating log files at \(url.path)")
        let directory = url.deletingLastPathComponent()
        let fileName = url.lastPathComponent
        let fileExtension = url.pathExtension
        let baseName = fileName.replacingOccurrences(of: ".\(fileExtension)", with: "")
        
        // 删除最旧的日志文件
        let oldestFile = directory.appendingPathComponent("\(baseName).\(Config.maxLogFiles).\(fileExtension)")
        if fileManager.fileExists(atPath: oldestFile.path) {
            try fileManager.removeItem(at: oldestFile)
        }
        
        // 重命名现有日志文件
        for i in (1..<Config.maxLogFiles).reversed() {
            let source = directory.appendingPathComponent("\(baseName).\(i).\(fileExtension)")
            if fileManager.fileExists(atPath: source.path) {
                let destination = directory.appendingPathComponent("\(baseName).\(i+1).\(fileExtension)")
                try fileManager.moveItem(at: source, to: destination)
            }
        }
        
        // 重命名当前日志文件
        let firstBackup = directory.appendingPathComponent("\(baseName).1.\(fileExtension)")
        if fileManager.fileExists(atPath: url.path) {
            try fileManager.moveItem(at: url, to: firstBackup)
        }
        logger.info("Log files rotated successfully")
    }
}

// 添加日志方法别名
extension Logger {
    static func verbose(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        shared.verbose(message, file: file, function: function, line: line)
    }
    
    static func debug(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        shared.debug(message, file: file, function: function, line: line)
    }
    
    static func info(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        shared.info(message, file: file, function: function, line: line)
    }
    
    static func wearning(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        shared.warning(message, file: file, function: function, line: line)
    }
    
    static func error(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        shared.error(message, file: file, function: function, line: line)
    }
}
