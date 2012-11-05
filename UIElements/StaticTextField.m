//
//  StaticTextField.m
//  UIElements
//
//  Created by Tobias Sommer on 11/5/12.
//  Copyright (c) 2012 Tobias Sommer. All rights reserved.
//

#import "StaticTextField.h"
#import "StaticTextFieldIdentifier.h"

@implementation StaticTextField

- (id) initWithUIElementRef :(AXUIElementRef) ref {
  // kaxValue
  NSString *attribute = [UIElementUtilities readkAXAttributeString:ref :kAXValueAttribute];
  self.textFieldValue = attribute ? attribute : @"";
  
  self = [super initWithUIElementRef:ref];
  self.uiElementIdentifier = [[StaticTextFieldIdentifier alloc] createIdentifier:self];

  
  return self;
}

- (id) createIdentifier {
  return [[StaticTextFieldIdentifier alloc] init];
}
@end
