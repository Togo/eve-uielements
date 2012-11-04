//
//  EVEShortcutTests.m
//  UIElements
//
//  Created by Tobias Sommer on 10/20/12.
//  Copyright (c) 2012 Tobias Sommer. All rights reserved.
//

#import "EVEShortcutTests.h"

@implementation EVEShortcutTests
- (void)setUp
{
  [super setUp];
  shortcut = [[EVEShortcut alloc] init];
  // Set-up code here.
}

- (void)tearDown
{
  // Tear-down code here.
  shortcut = nil;
  [super tearDown];
}

- (void)testInitWithUIElementRef
{
  STAssertEqualObjects(shortcut.cmdChar, @"", @"The Shortcut Char should not be \"\"");
  STAssertNil(shortcut.virtualKey, @"The Shortcut should not be nil");
  STAssertNil(shortcut.cmdGlyph, @"The Shortcut should not be nil");
  STAssertNil(shortcut.cmdModifiers, @"The Shortcut should not be nil");
  
  STAssertNotNil(shortcut, @"The Shortcut should not be nil");
}

- (void) testComposeShortcutString {
  // If there is no shortcut return a empty String
  NSString *shortcutString = [shortcut composeShortcutString];
  STAssertEqualObjects(shortcutString, @"", @"Shortcut String should be empty");
  
  shortcut.cmdChar = @"T";
  shortcut.cmdModifiers = [NSNumber numberWithInt:4];
  shortcutString = [shortcut composeShortcutString];
  
  STAssertEqualObjects(shortcutString, @"Command Control T", @"Shortcut String is wrong");

  shortcut.cmdChar = @"";
  shortcut.cmdModifiers = [NSNumber numberWithInt:0];
  shortcutString = [shortcut composeShortcutString];
  
  STAssertEqualObjects(shortcutString, @"", @"Shortcut should be empty");
  
  shortcut.cmdChar = @"";
  shortcut.cmdModifiers = [NSNumber numberWithInt:10];
  shortcutString = [shortcut composeShortcutString];
  
  STAssertEqualObjects(shortcutString, @"", @"Shortcut should be empty");
}

- (void) testCmdModifier {
  NSString *modifier = [shortcut cmdModifierString];
  STAssertEqualObjects(modifier, @"", @"Shortcut String should be \"\" ");
  
  // Command Char the command char should be displayed
  shortcut.cmdModifiers = [NSNumber numberWithInt:0];
  modifier = [shortcut cmdModifierString];
  STAssertEqualObjects(modifier, @"Command ", @"Wrong Command Modifier");
  
  shortcut.cmdModifiers = [NSNumber numberWithInt:1];
  modifier = [shortcut cmdModifierString];
  STAssertEqualObjects(modifier, @"Command Shift ", @"Wrong Command Modifier");
  
  shortcut.cmdModifiers = [NSNumber numberWithInt:2];
  modifier = [shortcut cmdModifierString];
  STAssertEqualObjects(modifier, @"Command Option ", @"Wrong Command Modifier");
  
  shortcut.cmdModifiers = [NSNumber numberWithInt:4];
  modifier = [shortcut cmdModifierString];
  STAssertEqualObjects(modifier, @"Command Control ", @"Wrong Command Modifier");
  
  shortcut.cmdModifiers = [NSNumber numberWithInt:6];
  modifier = [shortcut cmdModifierString];
  STAssertEqualObjects(modifier, @"Command Option Control ", @"Wrong Command Modifier");
  
  shortcut.cmdModifiers = [NSNumber numberWithInt:7];
  modifier = [shortcut cmdModifierString];
  STAssertEqualObjects(modifier, @"Command Option Control Shift ", @"Wrong Command Modifier");

  shortcut.cmdModifiers = [NSNumber numberWithInt:12];
  modifier = [shortcut cmdModifierString];
  STAssertEqualObjects(modifier, @"Control ", @"Wrong Command Modifier");
}

- (void) testCmdChar {
  NSString *cmdChar = [shortcut cmdChar];
  STAssertEqualObjects(cmdChar, @"", @"Shortcut String should be T");

  // Command Char the command char should be displayed
  shortcut.cmdChar = @"T";
  cmdChar = [shortcut cmdChar];
  STAssertEqualObjects(cmdChar, @"T", @"Shortcut String should be T");
}

- (void) testVirtualKeyString {
  NSString *virtualKey = [shortcut virtualKeyString];
  STAssertEqualObjects(virtualKey, @"", @"Virtual Key is wrong");
  
  // If there is no shortcut return a empty String
  shortcut.virtualKey = [NSNumber numberWithInt:97];
  virtualKey = [shortcut virtualKeyString];
  STAssertEqualObjects(virtualKey, @"F12", @"Virtual Key is wrong");
}

@end
