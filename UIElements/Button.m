//
//  Button.m
//  UIElements
//
//  Created by Tobias Sommer on 10/21/12.
//  Copyright (c) 2012 Tobias Sommer. All rights reserved.
//

#import "Button.h"
#import "ButtonIdentifier.h"
#import "Identifier.h"

@implementation Button

- (id) initWithUIElementRef :(AXUIElementRef) ref {
  self = [super initWithUIElementRef:ref];
  self.uiElementIdentifier = [[ButtonIdentifier alloc] init];
  
  return self;
}

- (id) createIdentifier {
  return [[ButtonIdentifier alloc] init];
}

@end
