//
//  MenuItem.m
//  UIElements
//
//  Created by Tobias Sommer on 10/21/12.
//  Copyright (c) 2012 Tobias Sommer. All rights reserved.
//

#import "MenuItem.h"
#import "MenuItemIdentifier.h"

@implementation MenuItem

- (id) initWithUIElementRef :(AXUIElementRef) ref {
  
  self = [super initWithUIElementRef:ref];
  self.uiElementIdentifier = [[MenuItemIdentifier alloc] createIdentifier:self];
  
  return self;
}

- (id) createIdentifier {
  return [[MenuItemIdentifier alloc] init];
}


@end
