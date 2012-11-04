//
//  NullUIElement.m
//  UIElements
//
//  Created by Tobias Sommer on 11/4/12.
//  Copyright (c) 2012 Tobias Sommer. All rights reserved.
//

#import "NullUIElement.h"
#import "NUllIdentifier.h"

@implementation NullUIElement
  //test
- (id) initWithUIElementRef :(AXUIElementRef) ref {
    
    self = [super initWithUIElementRef:ref];
    self.roleDescription = @"Not Implemented";
    self.uiElementIdentifier = [[NUllIdentifier alloc] createIdentifier:self];
    
    return self;
  }
  
- (id) createIdentifier {
  return [[NUllIdentifier alloc] init];
}

@end
