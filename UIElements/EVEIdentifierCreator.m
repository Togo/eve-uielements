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
@synthesize cocoaIdentifierString;

- (NSString*) createCocoaIdentifier :(UIElement*) element {
  NSMutableString *temp = [NSMutableString stringWithString:@""];
  if ([[element cocoaIdentifierAttribute] length] > 0) {
    @synchronized(self) {
      [element role] ? [temp appendString:[element role]] : [temp appendString:@""];
      [element roleDescription] ? [temp appendString:[element roleDescription]] : [temp appendString:@""];
      [element title] ? [temp appendString:[element title]] : [temp appendString:@""];
      [element elementDescription] ? [temp appendString:[element elementDescription]] : [temp appendString:@""];

      [element cocoaIdentifierAttribute] ? [temp appendString:[element cocoaIdentifierAttribute]] : [temp appendString:@""];
      
    }
  } else {
    self.cocoaIdentifierString = @"";
  }
  
  self.cocoaIdentifierString = [[[NSString stringWithString:temp] stringByReplacingOccurrencesOfString:@" " withString:@""] lowercaseString];
  
  return self.cocoaIdentifierString;
}

- (NSString*) createIdentifier :(UIElement*) element {
  NSMutableString *temp = [NSMutableString stringWithString:@""];
  @synchronized(self) {
    if ([self withRole]) {
       [element role] ? [temp appendString:[element role]] : [temp appendString:@""];
    }

    if ([self withRoleDescription]) {
        [element roleDescription] ? [temp appendString:[element roleDescription]] : [temp appendString:@""];
    }
    
    if ([self withAppName]) {
        [[element owner] appName] ? [temp appendString:[[element owner] appName]] : [temp appendString:@""];
    }
    
    if ([self withDescription]) {
      [element elementDescription] ? [temp appendString:[element elementDescription]] : [temp appendString:@""];
    }
    
    if ([self withHelp]) {
      [element help] ? [temp appendString:[element help]] : [temp appendString:@""];
    }
    
    if ([self withTitle]) {
        [element title] ? [temp appendString:[self cleanString:[element title]]] : [temp appendString:@""];
    }
    
    if ([self withSubrole]) {
        [element subrole] ? [temp appendString:[element subrole]] : [temp appendString:@""];
    }
    
    if ([self withParentTitle]) {
        [temp appendFormat:@"$$"];
        [element parentTitle] ? [temp appendString:[element parentTitle]] : [temp appendString:@""];
    }
    
    if ([self withValue]
        && [element textFieldValue]) {
      NSRange range;
      if ([[element textFieldValue] length] > 50) {
        range = NSMakeRange(0, 50);
      } else {
        range = NSMakeRange(0, [[element textFieldValue] length]);
      }
      [element textFieldValue] ? [temp appendString:[self cleanString:[[element textFieldValue] substringWithRange:range]]] : [temp appendString:@""];
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
