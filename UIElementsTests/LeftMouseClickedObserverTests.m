//
//  LeftMouseClickedObserverTests.m
//  UIElements
//
//  Created by Tobias Sommer on 10/24/12.
//  Copyright (c) 2012 Tobias Sommer. All rights reserved.
//

#import "LeftMouseClickedObserverTests.h"
#import "ClickOnUIElementSubject.h"

@implementation LeftMouseClickedObserverTests

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

- (void) testInit {
  
}

- (void) testIndexMenuBar {
  ClickOnUIElementSubject *mouseClickedSubject = [[ClickOnUIElementSubject alloc] init];
  STAssertNotNil(mouseClickedSubject, @"");
  STAssertNotNil(mouseClickedSubject.globalMouseListener, @"");
  STAssertNotNil(mouseClickedSubject.systemWideElement, @"");
  
}

- (void) testRegisterMouseListener {
  ClickOnUIElementSubject *mouseClickedSubject = [[ClickOnUIElementSubject alloc] init];
  id listener = [mouseClickedSubject registerListener];
  STAssertNotNil(listener, @"Nothing returned");
}

- (void) testUpdateCurrentUIElement {
  
  
}

@end
