//
//  YNExpandableCellTests.swift
//  YNExpandableCellTests
//
//  Deterministic tests for cell construction and bundled asset loading. These
//  run headlessly on the simulator and, importantly, verify that the accessory
//  images resolve through the SwiftPM resource bundle (Bundle.module).
//

import XCTest
import UIKit
@testable import YNExpandableCell

@MainActor
final class YNExpandableCellTests: XCTestCase {

    func testCellInitBuildsAccessoryViews() {
        let cell = YNExpandableCell(style: .default, reuseIdentifier: "cell")

        XCTAssertNotNil(cell.normalCustomAccessoryType)
        XCTAssertNotNil(cell.selectedCustomAccessoryType)
        // The selected accessory starts hidden and selection style is cleared.
        XCTAssertTrue(cell.selectedCustomAccessoryType.isHidden)
        XCTAssertEqual(cell.selectionStyle, .none)
    }

    func testAccessoryImagesLoadFromResourceBundle() {
        let cell = YNExpandableCell(style: .default, reuseIdentifier: "cell")
        // If the asset catalog is packaged correctly, these decode to real images.
        XCTAssertNotNil(cell.normalCustomAccessoryType.image, "yn_nor should load from the resource bundle")
        XCTAssertNotNil(cell.selectedCustomAccessoryType.image, "yn_sel should load from the resource bundle")
    }

    func testTableViewReflectsDelegateCounts() {
        let tableView = YNTableView(frame: .zero, style: .plain)
        let stub = StubDelegate()
        tableView.ynDelegate = stub

        XCTAssertEqual(tableView.numberOfSections(in: tableView), 2)
        XCTAssertEqual(tableView.tableView(tableView, numberOfRowsInSection: 0), 3)
    }
}

/// Minimal YNTableViewDelegate that reports a fixed shape with no expansions.
@MainActor
private final class StubDelegate: NSObject, YNTableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int { 2 }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 3 }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }

    func tableView(_ tableView: YNTableView, expandCellAt indexPath: IndexPath) -> UITableViewCell? { nil }

    func tableView(_ tableView: YNTableView, expandCellWithHeightAt indexPath: IndexPath) -> YNTableViewCell? { nil }

    func tableView(_ tableView: YNTableView, didSelectRowAt indexPath: IndexPath, isExpandableCell: Bool, isExpandedCell: Bool) {}
}
