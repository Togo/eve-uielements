//
//  SearchTextField.m
//  UIElements
//
//  Created by Tobias Sommer on 11/7/12.
//  Copyright (c) 2012 Tobias Sommer. All rights reserved.
//

#import "SearchTextField.h"
#import "SearchTextFieldIdentifier.h"

@implementation SearchTextField

- (id) initWithUIElementRef :(AXUIElementRef) ref {
  self = [super initWithUIElementRef:ref];
  self.uiElementIdentifier = [[SearchTextFieldIdentifier alloc] createIdentifier:self];
  
  return self;
}

- (id) createIdentifier {
  return [[SearchTextFieldIdentifier alloc] init];
}

@end
