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
  @synchronized(self) {
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
        [temp appendString:[self cleanString:[element title]]];
    }
    
    if ([self withSubrole]) {
        [temp appendString:[element subrole]];
    }
    
    if ([self withParentTitle]) {
        [temp appendFormat:@"$$"];
        [temp appendString:[element parentTitle]];
    }
    
    if ([self withValue]) {
      NSRange range;
      if ([[element textFieldValue] length] > 50) {
        range = NSMakeRange(0, 50);
      } else {
        range = NSMakeRange(0, [[element textFieldValue] length]);
      }
      [temp appendString:[self cleanString:[[element textFieldValue] substringWithRange:range]]];
  }
  
  self.identifierString = [[[NSString stringWithString:temp] stringByReplacingOccurrencesOfString:@" " withString:@""] lowercaseString];

    return identifierString;
  }
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


- (NSString*) cleanString :(id) string {
  // Check if this is a number
  if([string isKindOfClass:NSString.class])  {
    NSMutableString *cleanedTitle = [NSMutableString stringWithString:string];
    
    // remove Text between „”
    NSCharacterSet *rangeFileNameSet = [NSCharacterSet characterSetWithCharactersInString:@"„”“"];
    NSRange startIndex = [cleanedTitle rangeOfCharacterFromSet:rangeFileNameSet options:0];
    NSRange endIndex = [cleanedTitle rangeOfCharacterFromSet:rangeFileNameSet options:NSBackwardsSearch];
    if (startIndex.length != NSNotFound
        && startIndex.location != endIndex.location) {
      NSRange rangeToRemove = NSMakeRange((startIndex.location), (endIndex.location - startIndex.location) + 1);
      
      [cleanedTitle deleteCharactersInRange:rangeToRemove];
    }
    
    // remove Text between ()
    rangeFileNameSet = [NSCharacterSet characterSetWithCharactersInString:@"()"];
    startIndex = [cleanedTitle rangeOfCharacterFromSet:rangeFileNameSet options:0];
    endIndex = [cleanedTitle rangeOfCharacterFromSet:rangeFileNameSet options:NSBackwardsSearch];
    if (startIndex.length != NSNotFound
        && startIndex.location != endIndex.location) {
      NSRange rangeToRemove = NSMakeRange((startIndex.location), (endIndex.location - startIndex.location) + 1);
      
      [cleanedTitle deleteCharactersInRange:rangeToRemove];
    }

    
    NSCharacterSet *engCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@"„…&”“."];
   return [[cleanedTitle componentsSeparatedByCharactersInSet: engCharacterSet] componentsJoinedByString: @""];
  } else {
    return string;
  }
  
}

@end
