//
//  Shortcut.h
//  UIElements
//
//  Created by Tobias Sommer on 10/20/12.
//  Copyright (c) 2012 Tobias Sommer. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Shortcut <NSObject>

@property (strong, nonatomic) NSString *cmdChar;
@property (strong, nonatomic) NSNumber *virtualKey;
@property (strong, nonatomic) NSNumber *cmdModifiers;
@property (strong, nonatomic) NSNumber *cmdGlyph;

- (NSString*) composeShortcutString;
- (id) initWithUIElementRef :(AXUIElementRef) elementRef;
- (NSString*) virtualKeyString;

@end
