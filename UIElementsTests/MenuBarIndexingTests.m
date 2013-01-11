//
//  MenuBarIndexingTests.m
//  UIElements
//
//  Created by Tobias Sommer on 10/24/12.
//  Copyright (c) 2012 Tobias Sommer. All rights reserved.
//

#import "MenuBarIndexingTests.h"
#import "Application.h"
#import "MenuBarIndexing.h"

@implementation MenuBarIndexingTests

- (void)setUp
{
  [super setUp];
  
  
  // Set-up code here.
}

- (void)tearDown
{
  // Tear-down code here.
  
  [super tearDown];
}

- (void) testIndexMenuBar {
  NSString *bundleIdentifier = @"com.apple.finder";
  Application *app = [[Application alloc] initWithBundleIdentifier:bundleIdentifier];
  
  
  AXUIElementRef appRef = AXUIElementCreateApplication( [[app runningApplication] processIdentifier] );
  MenuBarIndexing *indexMenuBar = [[MenuBarIndexing alloc] init];
  NSArray *elements = [indexMenuBar indexMenuBar:appRef];
  
  STAssertTrue([elements count] > 0, @"No Menu Bar Elements");
  STAssertNotNil(elements, @"No Menu Bar Elements");
  STAssertNotNil([elements objectAtIndex:3], @"Nil Object in MenuBar Array");
}

- (void) test_indexMenuBarWithBundleIdentifier_bundleIdentifierNil_throwException {
  MenuBarIndexing *menuBarIndexing = [[MenuBarIndexing alloc] init];
  STAssertThrows([menuBarIndexing indexMenuBarWithBundleIdentifier:nil], @"");
}

@end
