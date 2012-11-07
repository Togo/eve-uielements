//
//  ButtonIdentifier.m
//  UIElements
//
//  Created by Tobias Sommer on 10/21/12.
//  Copyright (c) 2012 Tobias Sommer. All rights reserved.
//

#import "TextFieldIdentifier.h"

@implementation TextFieldIdentifier

- (BOOL) withDescription {
  return false;
}

- (BOOL) withSubrole {
  return true;
}

- (BOOL) withValue {
  return true;
}

@end
