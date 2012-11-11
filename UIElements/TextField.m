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
  
  TextFieldIdentifier *identCreator = [[TextFieldIdentifier alloc] init];
  self.uiElementIdentifier = [identCreator createIdentifier:self];
  self.cocoaIdentifierString = [identCreator createCocoaIdentifier:self];
  
  return self;
}

- (id) createIdentifier {
  return [[TextFieldIdentifier alloc] init];
}


@end
