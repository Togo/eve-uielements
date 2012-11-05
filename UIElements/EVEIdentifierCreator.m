//
//  EVEIdentifier.m
//  UIElements
//
//  Created by Tobias Sommer on 10/21/12.
//  Copyright (c) 2012 Tobias Sommer. All rights reserved.
//

#import "EVEIdentifierCreator.h"

@implementation EVEIdentifierCreator

@synthesize identifierString;

- (NSString*) createIdentifier :(UIElement*) element {
  NSMutableString *temp = [NSMutableString stringWithString:@""];
  
  if ([self withRole]) {
    [temp appendString:[element role]];
  }

  if ([self withRoleDescription]) {
      [temp appendString:[element roleDescription]];
  }
  
  if ([self withAppName]) {
      [temp appendString:[[element owner] appName]];
  }
  
  if ([self withDescription]) {
    [temp appendString:[element elementDescription]];
  }
  
  if ([self withHelp]) {
    [temp appendString:[element help]];
  }
  
  if ([self withTitle]) {
      [temp appendString:[element title]];
  }
  
  if ([self withSubrole]) {
      [temp appendString:[element subrole]];
  }
  
  if ([self withParentTitle]) {
      [temp appendString:[element parentTitle]];
  }
  
  if ([self withValue]) {
    [temp appendString:[element textFieldValue]];
  }
  
  self.identifierString = [[[NSString stringWithString:temp] stringByReplacingOccurrencesOfString:@" " withString:@""] lowercaseString];
  
  return identifierString;
}

- (BOOL) withRole {
  return true;
}

- (BOOL) withRoleDescription {
  return true;
}

- (BOOL) withAppName {
  return true;
}

- (BOOL) withDescription {
  return false;
}

- (BOOL) withHelp {
  return false;
}

- (BOOL) withTitle {
  return false;
}

- (BOOL) withSubrole {
  return false;
}

- (BOOL) withParentTitle {
  return false;
}

- (BOOL) withValue {
  return false;
}

@end
