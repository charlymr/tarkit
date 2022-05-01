//
//  File.swift
//  
//
//  Created by Denis Martin-Bruillot on 01/05/2022.
//

@testable import DCTar
import XCTest

class DCTarTests: XCTestCase {
    
    
    override class func setUp() {
        /**
         * @method +setUp
         * Suite-level setup method called before the class begins to run any of its test methods or their associated
         * per-instance setUp methods.
         */
    }
    
    override class func tearDown() {
        /**
         * @method +tearDown
         * Suite-level teardown method called after the class has finished running all of its test methods and their
         * associated per-instance tearDown methods and teardown blocks.
         */
    }
    
    func testCompressDecompressTARGZ() throws {
        let tmpDir = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        let destinationTar = tmpDir.appendingPathComponent("LICENSE.tar.gz")
        let container = tmpDir.appendingPathComponent("LICENSE")
        let result = tmpDir.appendingPathComponent("LICENSE-Result")
        try FileManager.default.createDirectory(at: container, withIntermediateDirectories: true)
        
        print(container)
        print(destinationTar)
        
        guard let fileURL = Bundle.module.url(forResource: "LICENSE", withExtension: nil) else {
            XCTFail("Couldn't load resource")
            return
        }
        let filename = fileURL.lastPathComponent
        try FileManager.default.copyItem(at: fileURL, to: container.appendingPathComponent(filename))
        
        try DCTar.compressFile(atPath: container.path, toPath: destinationTar.path)
        let compressed = try Data(contentsOf: destinationTar)
        XCTAssertNotNil(compressed)

//        try DCTar.decompressData(compressed, toPath: result.path)
        try DCTar.decompressFile(atPath: destinationTar.path, toPath: result.path)
        let decompressed = try Data(contentsOf: result.appendingPathComponent(filename))
        XCTAssertNotNil(decompressed)

        /// We have all our Steps
        let data = try Data(contentsOf: fileURL)
        XCTAssertEqual(decompressed, data)
        
    }
    
    func testDecompressTARGZ() async throws {
        let tmpDir = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        let container = tmpDir.appendingPathComponent("RESULT")
        try FileManager.default.createDirectory(at: tmpDir, withIntermediateDirectories: true)
        print(container)
        guard let fileURL = Bundle.module.url(forResource: "LICENSE.tar", withExtension: "gz") else {
            XCTFail("Couldn't load resource")
            return
        }
        
        
        try DCTar.decompressFile(atPath: fileURL.path, toPath: container.path)
        
        guard let fileURL = Bundle.module.url(forResource: "LICENSE", withExtension: nil) else {
            XCTFail("Couldn't load resource")
            return
        }
        let bundleData = try Data(contentsOf: fileURL)
        let extractedData = try Data(contentsOf: container.appendingPathComponent("LICENSE"))
        XCTAssertEqual(bundleData, extractedData)
    }
}
