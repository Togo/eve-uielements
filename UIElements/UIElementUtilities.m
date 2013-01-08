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

+ (NSString*) cleanString :(id) string {
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

+ (AXUIElementRef) getAppRefFromBundleIdentifier :bundleIdentifier {
  NSArray *runningApplications =    [NSRunningApplication runningApplicationsWithBundleIdentifier:bundleIdentifier];
  
  if ([runningApplications count] > 0)
    return (AXUIElementCreateApplication( [[runningApplications objectAtIndex:0] processIdentifier] ));
  else
    return nil;
}

+ (AXUIElementRef) getUIElementUnderMousePointer :(NSString*) bundleIdentifier {
  AXUIElementRef appRef = [self getAppRefFromBundleIdentifier:bundleIdentifier];
  NSPoint cocoaPoint = [NSEvent mouseLocation];
  CGPoint pointAsCGPoint = [UIElementUtilities_org carbonScreenPointFromCocoaScreenPoint:cocoaPoint];
  
  AXUIElementRef newElement = NULL;
  
  AXError error = AXUIElementCopyElementAtPosition( appRef, pointAsCGPoint.x, pointAsCGPoint.y, &newElement );
  
  return newElement;
}

+ (NSImage *) captureUIElement : (AXUIElementRef) ref {
  AXValueRef value;
  NSRect rect;	// dock rect
  
  // get size
  AXUIElementCopyAttributeValue(ref, kAXSizeAttribute, (CFTypeRef *) &value);
  AXValueGetValue(value, kAXValueCGSizeType, (void *) &rect.size);
  
  // get position
  AXUIElementCopyAttributeValue(ref, kAXPositionAttribute, (CFTypeRef *) &value);
  AXValueGetValue(value, kAXValueCGPointType, (void *) &rect.origin);
  
  // get the whole image
  CGDirectDisplayID displayID = CGMainDisplayID();
  
  CGImageRef image = CGDisplayCreateImageForRect(displayID, rect);
  NSImage *im = [[NSImage alloc] init];
  if (image != NULL) {
    NSBitmapImageRep *temp = [[NSBitmapImageRep alloc] initWithCGImage :image];
    
    [im addRepresentation:temp];
  }
  if (value) {
      CFRelease(value);
  }
  if (image) {
      CGImageRelease(image);
  }
  
  return im;
}

@end
