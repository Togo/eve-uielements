//
//  UIElementsTests.m
//  UIElementsTests
//
//  Created by Tobias Sommer on 10/20/12.
//  Copyright (c) 2012 Tobias Sommer. All rights reserved.
//

#import "UIElementsTests.h"
#import "UIElement.h"
#import "Button.h"
#import "MenuItem.h"
#import "TextField.h"
#import "ButtonIdentifier.h"
#import "MenuItemIdentifier.h"
#import "TextFieldIdentifier.h"
#import "MenuBarIndexing.h"

@implementation UIElementsTests

- (void)setUp
{
    [super setUp];
    NSString *bundleIdentifier = @"com.apple.finder";
    Application *app = [[Application alloc] initWithBundleIdentifier:bundleIdentifier];
    AXUIElementRef appRef = AXUIElementCreateApplication( [[app runningApplication] processIdentifier] );
    MenuBarIndexing *indexMenuBar = [[MenuBarIndexing alloc] init];
    elements = [indexMenuBar indexMenuBar:appRef];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void) testinitWithAXUIElementRef {
//  for (id aRef in elements) {
//    UIElement *element = [UIElement createUIElement:(AXUIElementRef) [aRef itemRef]];
//    if (element != nil) {
//      STAssertNotNil(element, @"Create UIElement ist nil");
//      STAssertEquals(element.class, MenuItem.class, @"Wrong Class!!");
//    }
//  }
}

- (void) testCreateUIElement {
  
}

- (void)testCreateIdentifier
{
  UIElement *element = [[UIElement alloc] init];
  STAssertThrows([element createIdentifier], @"Should throw NSInternalInconsistencyException");
}

- (void)testCreateButtonIdentifier
{
  Button *element = [[Button alloc] init];
  STAssertNoThrow([element createIdentifier], @"Should throw NSInternalInconsistencyException");
  
  EVEIdentifierCreator *identifier = [element createIdentifier];
  ButtonIdentifier *buttonIdentifer = [[ButtonIdentifier alloc] init];
  STAssertEquals(identifier.class, buttonIdentifer.class, @"Not the correct identifier");
}

- (void)testCreateMenuItemIdentifier
{
  MenuItem *element = [[MenuItem alloc] init];
  STAssertNoThrow([element createIdentifier], @"Should throw NSInternalInconsistencyException");
  
  EVEIdentifierCreator *identifier = [element createIdentifier];
  MenuItemIdentifier *identifer2 = [[MenuItemIdentifier alloc] init];
  STAssertEquals(identifier.class, identifer2.class, @"Not the correct identifier");
}

- (void)testCreateTextFieldIdentifier
{
  TextField *element = [[TextField alloc] init];
  STAssertNoThrow([element createIdentifier], @"Should throw NSInternalInconsistencyException");
  
  EVEIdentifierCreator *identifier = [element createIdentifier];
  TextFieldIdentifier *identifer2 = [[TextFieldIdentifier alloc] init];
  STAssertEquals(identifier.class, identifer2.class, @"Not the correct identifier");
}


@end
