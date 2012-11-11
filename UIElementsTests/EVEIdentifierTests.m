//
//  EVEShortcutTests.m
//  UIElements
//
//  Created by Tobias Sommer on 10/20/12.
//  Copyright (c) 2012 Tobias Sommer. All rights reserved.
//

#import "EVEIdentifierTests.h"
#import "MenuItemIdentifier.h"
#import "TextFieldIdentifier.h"

@implementation EVEIdentifierTests

- (void)setUp
{
  [super setUp];
  identifier = [[EVEIdentifierCreator alloc] init];
  element = [[UIElement alloc] init];
  [element setRole:@"Role"];
  [element setRoleDescription:@"Role Description"];
  [element setElementDescription:@"Description"];
  [element setHelp:@"Help"];
  [element setTitle:@"Title"];
  [element setParentTitle:@"ParentTitle"];
  [element setSubrole:@"Subrole"];
  [element setCocoaIdentifierAttribute:@"_NS:173"];

  // Set-up code here.
}

- (void)tearDown
{
  // Tear-down code here.
  identifier = nil;
  [super tearDown];
}

- (void) testCreateIdentifier {
  NSString *identifierString = [identifier createIdentifier:element];
  STAssertEqualObjects(identifierString, @"roleroledescription", @"Wrong identifier String");
}

- (void) testButtonIdentifier {
  ButtonIdentifier *buttonIdentifier = [[ButtonIdentifier alloc] init];
  
  buttonIdentifier.identifierString = [buttonIdentifier createIdentifier:element];
  STAssertEqualObjects(buttonIdentifier.identifierString, @"roleroledescriptiondescriptionhelptitle", @"Identifier is wrong");
  
  STAssertTrue([buttonIdentifier withTitle], @"Must return title true");
  STAssertFalse([buttonIdentifier withSubrole], @"Must return title false");
  STAssertFalse([buttonIdentifier withParentTitle], @"");
  STAssertTrue([buttonIdentifier withDescription], @"Must return title true");
  STAssertTrue([buttonIdentifier withHelp], @"Must return title true");
}

- (void) testMenuItemIdentifier {
  MenuItemIdentifier *menuIdentifier = [[MenuItemIdentifier alloc] init];
  
  menuIdentifier.identifierString = [menuIdentifier createIdentifier:element];
  STAssertEqualObjects(menuIdentifier.identifierString, @"roleroledescriptiontitle$$parenttitle", @"Identifier is wrong");
  
  STAssertTrue([menuIdentifier withTitle], @"Must return title true");
  STAssertTrue([menuIdentifier withParentTitle], @"");
  STAssertFalse([menuIdentifier withDescription], @"Must return title False");
  STAssertFalse([menuIdentifier withHelp], @"Must return false");
  STAssertFalse([menuIdentifier withSubrole], @"Must return false");
}


- (void) testTextFieldIdentifier {
  TextFieldIdentifier *textFieldIdentifier = [[TextFieldIdentifier alloc] init];
  
  textFieldIdentifier.identifierString = [textFieldIdentifier createIdentifier:element];
  STAssertEqualObjects(textFieldIdentifier.identifierString, @"roleroledescriptiondescriptionsubrole", @"Identifier is wrong");
  
  STAssertFalse([textFieldIdentifier withTitle], @"");
  STAssertFalse([textFieldIdentifier withParentTitle], @"");
  STAssertTrue([textFieldIdentifier withDescription], @"");
  STAssertFalse([textFieldIdentifier withHelp], @"");
  STAssertTrue([textFieldIdentifier withSubrole], @"");
}

- (void) testCocoaIdentifier {
  EVEIdentifierCreator *creator = [[EVEIdentifierCreator alloc] init];
  
  creator.identifierString = [creator createCocoaIdentifier:element];
  STAssertEqualObjects(creator.identifierString, @"roleroledescriptiontitledescription_ns:173", @"Identifier is wrong");
}


@end
