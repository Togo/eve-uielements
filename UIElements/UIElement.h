//
//  UIElements.h
//  UIElements
//
//  Created by Tobias Sommer on 10/20/12.
//  Copyright (c) 2012 Tobias Sommer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EVEShortcut.h"
#import "EVEIdentifierCreator.h"
#import "UIElementUtilities.h"
#import "Application.h"

@class EVEIdentifierCreator;

@interface UIElement : NSObject {
  EVEIdentifierCreator *uiElementIdentifier;
  EVEShortcut *shortcut;
  Application *owner;
  
  NSString *role;
  NSString *roleDescription;
  NSString *title;
  NSString *parentTitle;
  NSString *elementDescription;
  NSString *help;
  NSString *subrole;
  
  Boolean disabled;
}

@property (strong, nonatomic) EVEShortcut *shortcut;
@property (strong, nonatomic) Application *owner;
@property (strong, nonatomic) EVEIdentifierCreator *uiElementIdentifier;

@property (unsafe_unretained) AXUIElementRef itemRef;

@property (strong, nonatomic) NSString *role;
@property (strong, nonatomic) NSString *roleDescription;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *parentTitle;
@property (strong, nonatomic) NSString *elementDescription;
@property (strong, nonatomic) NSString *help;
@property (strong, nonatomic) NSString *subrole;

@property (unsafe_unretained) Boolean disabled;

+ (id) createUIElement :(AXUIElementRef) ref;
- (id) initWithUIElementRef :(AXUIElementRef) elementRef;
- (id) createIdentifier;

@end