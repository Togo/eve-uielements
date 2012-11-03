//
//  EVEShortcut.m
//  UIElements
//
//  Created by Tobias Sommer on 10/20/12.
//  Copyright (c) 2012 Tobias Sommer. All rights reserved.
//

#import "EVEShortcut.h"


@implementation EVEShortcut

const char * const virtualKeyNames[virtualKeysCount] = {
                            "kVK_ANSI_A",
                            "kVK_ANSI_S",
                            "kVK_ANSI_D",
                            "kVK_ANSI_F",
                            "kVK_ANSI_H",
                            "kVK_ANSI_G",
                            "kVK_ANSI_Z",
                            "kVK_ANSI_X",
                            "kVK_ANSI_C",
                            "kVK_ANSI_V",
                            "kVK_ANSI_B",
                            "kVK_ANSI_Q",
                            "kVK_ANSI_W",
                            "kVK_ANSI_E",
                            "kVK_ANSI_R",
                            "kVK_ANSI_Y",
                            "kVK_ANSI_T",
                            "kVK_ANSI_1",
                            "kVK_ANSI_2",
                            "kVK_ANSI_3",
                            "kVK_ANSI_4",
                            "kVK_ANSI_6",
                            "kVK_ANSI_5",
                            "kVK_ANSI_E,",
                            "kVK_ANSI_9 ",
                            "kVK_ANSI_7 ",
                            "kVK_ANSI_Mi,",
                            "kVK_ANSI_8  ",
                            "kVK_ANSI_0  ",
                            "kVK_ANSI_Rig,",
                            "kVK_ANSI_O   ",
                            "kVK_ANSI_U   ",
                            "kVK_ANSI_Left,",
                            "kVK_ANSI_I    ",
                            "kVK_ANSI_P    ",
                            "kVK_ANSI_L    ",
                            "kVK_ANSI_J    ",
                            "kVK_ANSI_Quote",
                            "kVK_ANSI_K    ",
                            "kVK_ANSI_Semic",
                            "kVK_ANSI_Backs",
                            "kVK_ANSI_Comma  ",
                            "kVK_ANSI_Slash  ",
                            "kVK_ANSI_N      ",
                            "kVK_ANSI_M      ",
                            "kVK_ANSI_Period ",
                            "kVK_ANSI_Grave  ",
                            "kVK_ANSI_KeypadD",
                            "kVK_ANSI_KeypadM",
                            "kVK_ANSI_KeypadPlu",
                            "kVK_ANSI_KeypadCle",
                            "kVK_ANSI_KeypadDiviB",
                            "kVK_ANSI_KeypadEnter",
                            "kVK_ANSI_KeypadMinus",
                            "kVK_ANSI_KeypadEqual",
                            "kVK_ANSI_Keypad0    ",
                            "kVK_ANSI_Keypad1    ",
                            "kVK_ANSI_Keypad2    ",
                            "kVK_ANSI_Keypad3    ",
                            "kVK_ANSI_Keypad4    ",
                            "kVK_ANSI_Keypad5    ",
                            "kVK_ANSI_Keypad6    ",
                            "kVK_ANSI_Keypad7    ",
                            "kVK_ANSI_Keypad8    ",
                            "kVK_ANSI_Keypad9    ",
                            "kVK_Return          ",
                            "kVK_Tab             ",
                            "kVK_Space           ",
                            "kVK_Delete          ",
                            "kVK_Escape          ",
                            "kVK_Command         ",
                            "kVK_Shift           ",
                            "kVK_CapsLock        ",
                            "kVK_Option          ",
                            "kVK_Control         ",
                            "kVK_RightShift      ",
                            "kVK_RightOption     ",
                            "kVK_RightControl    ",
                            "kVK_Function        ",
                            "kVK_F17             ",
                            "kVK_VolumeUp        ",
                            "kVK_VolumeDown      ",
                            "kVK_Mute            ",
                            "kVK_F18             ",
                            "kVK_F19             ",
                            "kVK_F20             ",
                            "kVK_F5              ",
                            "kVK_F6              ",
                            "kVK_F7              ",
                            "kVK_F3              ",
                            "kVK_F8              ",
                            "kVK_F9              ",
                            "kVK_F11             ",
                            "kVK_F13             ",
                            "kVK_F16             ",
                            "kVK_F14             ",
                            "kVK_F10             ",
                            "kVK_F12             ",
                            "kVK_F15             ",
                            "kVK_Help            ",
                            "kVK_Home            ",
                            "kVK_PageUp          ",
                            "kVK_ForwardDelete   ",
                            "kVK_F4              ",
                            "kVK_End             ",
                            "kVK_F2              ",
                            "kVK_PageDown        ",
                            "kVK_F1              ",
                            "kVK_LeftArrow       ",
                            "kVK_RightArrow      ",
                            "kVK_DownArrow       ",
                            "kVK_UpArrow         ",
                            nil
};

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
  [shortcutString appendString:[self cmdChar]];
  
  return shortcutString;
}

- (NSString*) virtualKeyString {
  NSMutableString *virtualKeyString = [NSMutableString string];
  
  if (virtualKey != nil) {
    for (int i = 0; i < virtualKeysCount; ++i) {
      if (i == [virtualKey intValue]) {
        NSString *keyName = [NSString stringWithFormat:@"%s",virtualKeyNames[i]];
        [virtualKeyString appendString:[[[keyName componentsSeparatedByString:@"_"] lastObject] stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]]];
        break;
      }
    }
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
