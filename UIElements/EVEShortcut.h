//
//  EVEShortcut.h
//  UIElements
//
//  Created by Tobias Sommer on 10/20/12.
//  Copyright (c) 2012 Tobias Sommer. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Shortcut.h"

@interface EVEShortcut : NSObject <Shortcut>

- (NSString*) cmdModifierString;
- (NSString*) virtualKeyString;

@end
