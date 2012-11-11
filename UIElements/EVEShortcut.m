//
//  EVEShortcut.m
//  UIElements
//
//  Created by Tobias Sommer on 10/20/12.
//  Copyright (c) 2012 Tobias Sommer. All rights reserved.
//

#import "EVEShortcut.h"
#import <Carbon/Carbon.h>


@implementation EVEShortcut


@synthesize cmdChar;
@synthesize virtualKey;
@synthesize cmdModifiers;
@synthesize cmdGlyph;

- (id) initWithUIElementRef :(AXUIElementRef) elementRef {
  CFStringRef cmdCharRef;
  CFNumberRef cmdVirtualKeyRef;
  CFNumberRef cmdModifiersRef;
  CFNumberRef cmdGlyphRef;
  
  self = [super init];
  
  if(elementRef != NULL) {
    AXUIElementCopyAttributeValue(elementRef, (CFStringRef) kAXMenuItemCmdCharAttribute,  (CFTypeRef*) &cmdCharRef);
    if (cmdCharRef)
      self.cmdChar = (__bridge NSString*) cmdCharRef;
    else
      self.cmdChar = @"";
    
    AXUIElementCopyAttributeValue(elementRef, (CFStringRef) kAXMenuItemCmdVirtualKeyAttribute, (CFTypeRef*) &cmdVirtualKeyRef);
    self.virtualKey = (__bridge NSNumber*) cmdVirtualKeyRef;
    
    AXUIElementCopyAttributeValue(elementRef, (CFStringRef) kAXMenuItemCmdModifiersAttribute, (CFTypeRef*) &cmdModifiersRef);
    self.cmdModifiers = (__bridge NSNumber*) cmdModifiersRef;
    
    AXUIElementCopyAttributeValue(elementRef, (CFStringRef) kAXMenuItemCmdGlyphAttribute,  (CFTypeRef*) &cmdGlyphRef);
    self.cmdGlyph = (__bridge NSNumber*) cmdGlyphRef;
  }
  
  return self;
}

- (NSString*) composeShortcutString {
  NSMutableString *shortcutString = [NSMutableString string];
  
  [shortcutString appendString:[self cmdModifierString]];
  [shortcutString appendString:[self virtualKeyString]];
  [shortcutString appendString:[self cmdChar]];
  
  if (   [shortcutString isEqualTo:@"Command "]
      || [shortcutString isEqualTo:@"Option "]
      || [shortcutString isEqualTo:@"Command Option "]) {
    [shortcutString setString:@""];
  }
  
  return shortcutString;
}

- (NSString*) virtualKeyString {
  NSString *virtualKeyString;
  switch ([virtualKey intValue]) {
    case 0:
      virtualKeyString = @"";
      break;

    case kVK_Escape:
      virtualKeyString = @"Escape";
      break;
    case kVK_Return:
      virtualKeyString = @"Return";
      break;
    case kVK_Tab:
      virtualKeyString = @"Tab";
      break;
    case kVK_Space:
      virtualKeyString = @"Space";
      break;
    case kVK_Delete:
      virtualKeyString = @"Delete";
      break;
    case kVK_Command:
      virtualKeyString = @"Command";
      break;
    case kVK_Option:
      virtualKeyString = @"Option";
      break;
    case kVK_Control:
      virtualKeyString = @"Control";
      break;
    case kVK_Shift:
      virtualKeyString = @"Shift";
      break;
    case kVK_CapsLock:
      virtualKeyString = @"CapsLock";
      break;
    case kVK_RightShift:
      virtualKeyString = @"Right Shift";
      break;
    case kVK_RightOption:
      virtualKeyString = @" Right Option ";
      break;
    case kVK_RightControl:
      virtualKeyString = @" Right Control ";
      break;
    case kVK_Function:
      virtualKeyString = @" Function ";
      break;
    case kVK_VolumeUp:
      virtualKeyString = @" Volume Up ";
      break;
    case kVK_VolumeDown:
      virtualKeyString = @" Volume Down ";
      break;
    case kVK_Mute:
      virtualKeyString = @" Mute ";
      break;
    case kVK_Help:
      virtualKeyString = @" Help ";
      break;
    case kVK_Home:
      virtualKeyString = @" Home ";
      break;
    case kVK_PageUp:
      virtualKeyString = @" Page Up ";
      break;
    case kVK_ForwardDelete:
      virtualKeyString = @" Forward Delete ";
      break;
    case kVK_End:
      virtualKeyString = @" End ";
      break;
    case kVK_PageDown:
      virtualKeyString = @" Page Down ";
      break;
    case kVK_LeftArrow:
      virtualKeyString = @" Left Arrow ";
      break;
    case kVK_RightArrow:
      virtualKeyString = @" Right Arrow ";
      break;
    case kVK_DownArrow:
      virtualKeyString = @" Down Arrow ";
      break;
    case kVK_UpArrow:
      virtualKeyString = @" Up Arrow ";
      break;
    case kVK_F1:
      virtualKeyString = @" F1 ";
      break;
    case kVK_F2:
      virtualKeyString = @" F2 ";
      break;
    case kVK_F3:
      virtualKeyString = @" F3 ";
      break;
    case kVK_F4:
      virtualKeyString = @" F4 ";
      break;
    case kVK_F5:
      virtualKeyString = @" F5 ";
      break;
    case kVK_F6:
      virtualKeyString = @" F6 ";
      break;
    case kVK_F7:
      virtualKeyString = @" F7 ";
      break;
    case kVK_F8:
      virtualKeyString = @" F8 ";
      break;
    case kVK_F9:
      virtualKeyString = @" F9 ";
      break;
    case kVK_F10:
      virtualKeyString = @" F10 ";
      break;
    case kVK_F11:
      virtualKeyString = @" F11 ";
      break;
    case kVK_F12:
      virtualKeyString = @" F11 ";
      break;
    default:
      virtualKeyString = @"no virtual key";
      break;
  }
  
  return virtualKeyString;
}

- (NSString*) cmdModifierString {
  NSMutableString *cmdModifierString = [NSMutableString string];
  
  if (cmdModifiers != nil) {

    if ( !([cmdModifiers intValue] & kMenuNoCommandModifier) != 0 )
      [cmdModifierString appendString:@"Command "];
  
    if ( ([cmdModifiers intValue] & kMenuOptionModifier) != 0 )
      [cmdModifierString appendString:@"Option "];
    
    if ( ([cmdModifiers intValue] & kMenuControlModifier) != 0 )
      [cmdModifierString appendString:@"Control "];
    
    if ( ([cmdModifiers intValue] & kMenuShiftModifier) != 0 )
      [cmdModifierString appendString:@"Shift "];
  }
  
  return cmdModifierString;
}

- (NSString*) cmdChar {
  if (cmdChar != nil)
    return cmdChar;
  else
    return @"";
}

@end
