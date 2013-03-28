//
//  TGUIELE_MarqueeRectIndexingTests.m
//  HotkeyEVE-Apps
//
//  Created by Tobias Sommer on 03/20/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "TGUIELE_MarqueeRectIndexingTests.h"
#import "TGUIELE_MarqueeRectIndexing.h"
#import "UIElement.h"
#import "NullUIElement.h"

#import <OCMock/OCMock.h>

@interface TGUIELE_MarqueeRectIndexingTests()  {
	@private
		TGUIELE_MarqueeRectIndexing *_indexing;
}
@end

@implementation TGUIELE_MarqueeRectIndexingTests

- (void)setUp
{
	[super setUp];
	_indexing = [TGUIELE_MarqueeRectIndexing marqueeIndexing];
}

- (void)tearDown
{
	// Tear-down code here.

	_indexing = nil;
	[super tearDown];
}

//***************************** factoryMethod ************************//
- (void) test_marqueeIndexing_allScenarios_ObjectAllocated {
	TGUIELE_MarqueeRectIndexing *indexing = [TGUIELE_MarqueeRectIndexing marqueeIndexing];

	STAssertNotNil(indexing, @"");
}


//***************************** indexUIElementsInRect ************************//
- (void) test_indexUIElementsInRect_validNSValue_returnUIElementsInRect {
	id indexingMock = [OCMockObject partialMockForObject:_indexing];
	NSArray *expectedOutput = [NSArray arrayWithObject:@"A UIElement"];

	[[[indexingMock stub] andReturn:expectedOutput] searchInSelectedRect];

	NSArray *result = [_indexing startIndexing:NULL selectedMarqueeRect:NSMakeRect(0, 0, 0, 0)];

	STAssertEqualObjects(result, expectedOutput, @"");
}

- (void) test_indexUIElementsInRect_allScenarios_setTheMarqueeRectWithInputRect {
	NSRect input = NSMakeRect(1, 0, 5, 0);
	[_indexing startIndexing:NULL selectedMarqueeRect:input];

	NSRect returnValue = _indexing->_marqueeRect;

	STAssertTrue(CGRectEqualToRect(returnValue, input), @"");
}

//***************************** searchInSelectedRect ************************//
- (void) test_searchInSelectedRect_ElementIsInSelectedRect_addThisElementToTheArray {
	UIElement *element = [[UIElement alloc] init];
	[element setElementDimension:NSMakeRect(0, 0, 0, 0)];
	NSArray *uiElements = [NSArray arrayWithObject:element];

	id indexingMock = [OCMockObject partialMockForObject:_indexing];
	bool isInRect = YES;
	[[[indexingMock stub] andReturnValue:OCMOCK_VALUE(isInRect)] isElementInSelectedRect:[element elementDimension].origin];

	[_indexing setWindowUIElements:uiElements];
	NSArray *returnValue = [_indexing searchInSelectedRect];

	STAssertTrue([returnValue containsObject:element], @"");
}

////***************************** searchInSelectedRect ************************//
//- (void) test_scanScreen_NULLUIElementOnXAndYPointFound_dontAddThisElementToArray {
//	NSRect input = NSMakeRect(50, 50, 1 ,1);
//	_indexing->_marqueeRect = input;
//
//	NSMutableArray *foundUIElements = [NSMutableArray array];
//	UIElement *uiElement = [[NullUIElement alloc] init];
//	id indexingMock = [OCMockObject partialMockForObject:_indexing];
//	[[[indexingMock stub] andReturn:uiElement] scanInPoint:50 andPoint:50];
//	[[indexingMock stub] scanInPoint:50 andPoint:51];
//	[[indexingMock stub] scanInPoint:51 andPoint:50];
//	[[indexingMock stub] scanInPoint:51 andPoint:51];
//
//	[_indexing searchInSelectedRect];
//
//	STAssertFalse([foundUIElements containsObject:uiElement], @"");
//}
//
//- (void) test_scanScreen_NothingFoundAtXAndYPointAndMaxScanPositionsNotReached_tryAgainUntilMaxScanRangesReached {
//	NSRect input = NSMakeRect(50, 50, 2 ,2);
//	_indexing->_marqueeRect = input;
//
//	id indexingMock = [OCMockObject partialMockForObject:_indexing];
//	[[[indexingMock expect] andReturn:nil] scanInPoint:50 andPoint:50];
//	[[[indexingMock expect] andReturn:nil] scanInPoint:50 andPoint:51];
//	[[[indexingMock reject] andReturn:nil] scanInPoint:50 andPoint:52];
//	[[[indexingMock expect] andReturn:nil] scanInPoint:51 andPoint:50];
//	[[[indexingMock expect] andReturn:nil] scanInPoint:51 andPoint:51];
//	[[[indexingMock reject] andReturn:nil] scanInPoint:51 andPoint:52];
//	[[[indexingMock reject] andReturn:nil] scanInPoint:52 andPoint:50];
//
//	[_indexing searchInSelectedRect];
//
//	[indexingMock verify];
//}
//
//- (void) test_scanScreen_FoundElementAtXAndYPointAndScanDirectionIsHorizontally_addWidthOfFoundElementToIndexingPosition1 {
//	NSRect input = NSMakeRect(50, 50, 6 ,2);
//	_indexing->_marqueeRect = input;
//
//	UIElement *foundThisElement = [[UIElement alloc] init];
//	NSRect elementDimension = NSMakeRect(0, 0, 4, 0);
//	[foundThisElement setElementDimension:elementDimension];
//
//	id indexingMock = [OCMockObject partialMockForObject:_indexing];
//	[[[indexingMock expect] andReturn:foundThisElement] scanInPoint:50 andPoint:50];
//	[[[indexingMock reject] andReturn:nil] scanInPoint:50 andPoint:51];
//	[[[indexingMock reject] andReturn:nil] scanInPoint:51 andPoint:50];
//	[[[indexingMock expect] andReturn:nil] scanInPoint:55 andPoint:50];
//	[[indexingMock stub] scanInPoint:55 andPoint:51];
//	[[indexingMock stub] scanInPoint:56 andPoint:50];
//	[[indexingMock stub] scanInPoint:56 andPoint:51];
//
//	[_indexing searchInSelectedRect];
//
//	[indexingMock verify];
//}
//
//- (void) test_scanScreen_FoundElementAtXAndYPointAndScanDirectionIsVertically_addHeigthOfFoundElementToIndexingPosition1 {
//	NSRect input = NSMakeRect(50, 50, 2 ,6);
//	_indexing->_marqueeRect = input;
//
//	UIElement *foundThisElement = [[UIElement alloc] init];
//	NSRect elementDimension = NSMakeRect(0, 0, 0, 4);
//	[foundThisElement setElementDimension:elementDimension];
//
//	id indexingMock = [OCMockObject partialMockForObject:_indexing];
//	[[[indexingMock expect] andReturn:foundThisElement] scanInPoint:50 andPoint:50];
//	[[[indexingMock reject] andReturn:nil] scanInPoint:50 andPoint:51];
//	[[[indexingMock reject] andReturn:nil] scanInPoint:51 andPoint:50];
//	[[[indexingMock expect] andReturn:nil] scanInPoint:55 andPoint:50];
//	[[indexingMock stub] scanInPoint:55 andPoint:51];
//	[[indexingMock stub] scanInPoint:56 andPoint:50];
//	[[indexingMock stub] scanInPoint:56 andPoint:51];
//
//
//	[_indexing searchInSelectedRect];
//
//	[indexingMock verify];
//}

@end
