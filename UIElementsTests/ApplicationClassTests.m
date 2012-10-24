//
//  ApplicationClassTests.m
//  UIElements
//
//  Created by Tobias Sommer on 10/23/12.
//  Copyright (c) 2012 Tobias Sommer. All rights reserved.
//

#import "ApplicationClassTests.h"
#import "Application.h"

@implementation ApplicationClassTests

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

- (void) testInitWithBundleIdentifier {
  NSString *bundleIdentifier = @"com.apple.finder";
  Application *app = [[Application alloc] initWithBundleIdentifier:bundleIdentifier];
  
  STAssertEqualObjects(app.bundleIdentifier, @"com.apple.finder", @"No bundle Identifier");
  STAssertEqualObjects(app.appName, @"Finder", @"Wrong app Name");
  STAssertNotNil(app.runningApplication, @"No Running App Object");
}

- (void) testCreateApplicationName {
  NSString *bundleIdentifier = @"com.apple.finder";
  Application *app = [[Application alloc] initWithBundleIdentifier:bundleIdentifier];
  
  NSString *appName = [app createApplicationName];
  STAssertEqualObjects(appName, @"Finder", @"Wrong App Name");
}

- (void) testGetOSXRunningApplication {
  NSString *bundleIdentifier = @"com.apple.finder";
  Application *app = [[Application alloc] initWithBundleIdentifier:bundleIdentifier];

  STAssertNotNil([app getOSXRunningApplicationObject], @"Running Application should not be nil");
}

- (void) testGetAppRef {
  NSString *bundleIdentifier = @"com.apple.finder";
  Application *app = [[Application alloc] initWithBundleIdentifier:bundleIdentifier];

  
  AXUIElementRef appRef = [app getAppRef];
  STAssertNotNil((__bridge id)appRef, @"App REf ist nil");
}

@end
