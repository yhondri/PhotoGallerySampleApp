import XCTest

final class PhotoGalleryUITests: XCTestCase {
    private var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
    }
    
    override func tearDown() {
        app = nil
    }

    private func givenAppLaunched() {
        app.launch()
    }
    
    func testNavigationBarTitleIsDisplayed() {
        givenAppLaunched()
        
        let element = app.navigationBars["Photo Gallery List"].staticTexts["Photo Gallery List"]
        let exist = element.waitForExistence(timeout: 5)
        
        XCTAssertTrue(exist)
    }
   
    func testViewLoadFirstPageWith10Photos() {
        givenAppLaunched()
        XCTAssertTrue(app.collectionViews.cells.count > 0, "There should be photos")
    }
   
    func testLoadMorePhotos() {
        givenAppLaunched()
        
        let tableViewsQuery = app.collectionViews
        whenSwipeToTheEndOfTheList(collectionViewsQuery: tableViewsQuery)
        let loadMoreButton = tableViewsQuery.buttons["Load More"]
        
        XCTAssert(loadMoreButton.exists)
        
        tapLoadMoreButton(tableViewsQuery: tableViewsQuery)
        whenSwipeToTheEndOfTheList(collectionViewsQuery: tableViewsQuery)
        tapLoadMoreButton(tableViewsQuery: tableViewsQuery)
    }
    
    /// There are 3 pages and 10 items per page.
    func testLoadMoreButtonIsNotShownWhenAllAvailablePagesHasBeenLoaded() {
        givenAppLaunched()
        
        let tableViewsQuery = app.collectionViews
        whenSwipeToTheEndOfTheList(collectionViewsQuery: tableViewsQuery)
        tapLoadMoreButton(tableViewsQuery: tableViewsQuery)
        whenSwipeToTheEndOfTheList(collectionViewsQuery: tableViewsQuery)
        tapLoadMoreButton(tableViewsQuery: tableViewsQuery)
        whenSwipeToTheEndOfTheList(collectionViewsQuery: tableViewsQuery)
        
        let loadMoreButton = tableViewsQuery.buttons["Load More"]
        XCTAssertFalse(loadMoreButton.exists)
    }
    
    private func whenSwipeToTheEndOfTheList(collectionViewsQuery: XCUIElementQuery) {
        for _ in 0..<3 {
            collectionViewsQuery.children(matching: .cell).element(boundBy: 2).swipeUp()
        }
    }
    
    private func tapLoadMoreButton(tableViewsQuery: XCUIElementQuery) {
        tableViewsQuery/*@START_MENU_TOKEN@*/.buttons["Load More"]/*[[".cells.buttons[\"Load More\"]",".buttons[\"Load More\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
}
