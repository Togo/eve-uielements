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
  self = [super initWithUIElementRef:ref];
  
  StaticTextFieldIdentifier *identCreator = [[StaticTextFieldIdentifier alloc] init];
  self.uiElementIdentifier = [identCreator createIdentifier:self];
  self.cocoaIdentifierString = [identCreator createCocoaIdentifier:self];

  return self;
}

- (id) createIdentifier {
  return [[StaticTextFieldIdentifier alloc] init];
}
@end
