//
//  UIElementUtilities.m
//  UIElements
//
//  Created by Tobias Sommer on 10/21/12.
//  Copyright (c) 2012 Tobias Sommer. All rights reserved.
//

#import "UIElementUtilities.h"
#import "UIElementUtilities_org.h"

@implementation UIElementUtilities

+ (NSString*) readkAXAttributeString:(AXUIElementRef)element :(CFStringRef) kAXAttribute {
  CFStringRef stringRef;
  
  if (AXUIElementCopyAttributeValue( element, (CFStringRef) kAXAttribute, (CFTypeRef*) &stringRef ) == kAXErrorSuccess) {
    NSString *returnValue = (__bridge NSString *) stringRef;
    CFRelease(stringRef);
    return returnValue;
  } else {
    return @"";
  }
}

+ (AXUIElementRef) secondParent :(AXUIElementRef) elementRef {
  AXUIElementRef parentRef = elementRef;
  if (parentRef) {
    parentRef = [UIElementUtilities_org parentOfUIElement:parentRef];
    if (parentRef) {
      parentRef = [UIElementUtilities_org parentOfUIElement:parentRef];
    }
  }
  return parentRef;
}

@end
