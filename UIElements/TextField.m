//
//  TextField.m
//  UIElements
//
//  Created by Tobias Sommer on 10/21/12.
//  Copyright (c) 2012 Tobias Sommer. All rights reserved.
//

#import "TextField.h"
#import "TextFieldIdentifier.h"

@implementation TextField

- (id) initWithUIElementRef :(AXUIElementRef) ref {
  self = [super initWithUIElementRef:ref];
  self.uiElementIdentifier = [[TextFieldIdentifier alloc] createIdentifier:self];
  
  return self;
}

- (id) createIdentifier {
  return [[TextFieldIdentifier alloc] init];
}


@end
