//
//  HomePageUITests.swift
//  VaultUITests
//
//  Created by hut on 2024/12/19.
//

import XCTest

final class HomePageUITests: XCTestCase {

    override class func setUp() {
        super.setUp()
        
    }
    
    override class func tearDown() {
        super.tearDown()
        
    }
    
    override func setUpWithError() throws {
        // 遇到测试不通过的用例，也不停，继续跑
        continueAfterFailure = true
        
    }

    override func tearDownWithError() throws {
        
    }
    
    func testAssertionsExamples() throws {
        let app = XCUIApplication()
        app.launch()
        
        let table = app.tables.firstMatch
        let valueIcon = app.images["vault120"]
        let searchField = app.textFields["输入关键字"]
        
        XCTAssertNil(valueIcon, "测试应该不通过，因为实际上vault120是存在的")
        XCTAssertNotNil(valueIcon, "测试应该通过，因为实际上vault120是存在的")
        
        XCTAssert(valueIcon.isHittable == false, "测试应该不通过，因为实际上vault120是可点击的")
        XCTAssertFalse(valueIcon.isHittable, "测试应该不通过，因为实际上vault120是可点击的")
        XCTAssertTrue(valueIcon.isHittable, "测试应该通过，因为实际上vault120不可点击的")
        
        XCTAssertEqual(valueIcon.frame.size.width, 60.0, "测试应该通过，因为vault120的宽度就为60.0")
        XCTAssertNotEqual(valueIcon.frame.size.width, 60.0, "测试应该不通过，因为vault120的宽度就为60.0")
        XCTAssertIdentical(valueIcon, searchField, "测试应该不通过，因为valueIcon和searchField不是同一个对象")
        XCTAssertIdentical(valueIcon, valueIcon, "测试应该通过，因为valueIcon和valueIcon是同一个对象")
        
        
        XCTAssertGreaterThan(searchField.frame.size.width, 100, "测试一般会通过，因为searchField的宽度一般会大于100")
        XCTAssertGreaterThanOrEqual(searchField.frame.size.width, 100, "测试一般会通过，因为searchField的宽度一般会大于100")
        XCTAssertLessThanOrEqual(valueIcon.frame.size.width, 60, "测试一般会通过，因为valueIcon的宽度就是60")
        XCTAssertLessThan(valueIcon.frame.size.width, 40, "测试应该不通过，因为valueIcon的宽度就是60")
        
        // 上拉动作
        table.swipeUp()
        XCTAssertNotNil(table, "table不为空！")
    }
    
    func testSearchMovie() throws {

        // 启动app
        let app = XCUIApplication()
        app.launch()
        
        let table = app.tables.firstMatch
        let searchField = app.textFields["输入关键字"]
        
        /** 以下是搜索流程的测试用例 */
        
        // 点击搜索框
        searchField.tap()

        // 等待键盘出现
        let _ = app.keyboards.firstMatch.waitForExistence(timeout: 2.0)
        XCTAssert(app.keyboards.count > 0, "输入键盘出现")
        XCTAssert(app.keyboards.buttons["search"].exists, "输入键盘出现，并且有search按钮")
        
        sleep(4)    // 为了观看测试，停留处理
        
        // 输入要搜索的关键字Paper Moon
        searchField.typeText("Paper Moon")

        // 点击搜索按钮-开始搜索
        app.buttons.element(matching: .button, identifier: "Search").firstMatch.tap()
        
        // 等待键盘消失
        app.keyboards.firstMatch.waitForNonExistence(timeout: 2.0)
        XCTAssert(app.keyboards.count == 0, "输入键盘消失")
        
        sleep(6)    // 为了观看测试，停留处理
        
        XCTAssertGreaterThanOrEqual(table.cells.count, 3, "至少会搜索到一个结果")   // 2个一个头部，搜索结果为2+n
        XCTAssertNotNil(table.cells.element(matching: .staticText, identifier: "Paper Moon"), "有一个cell的标题应该包含Paper Moon字样")

        // 下拉动作
        table.swipeDown()
        
        sleep(8)    // 为了观看测试，停留处理
        
        // 等待一个并不存在的元素，用来设置等待时间, 类似sleep(5)的效果
//        let _ = app.staticTexts["NotExistElementOnlyForDelay"].waitForExistence(timeout: 10)
    }

}

