//
//  WindowIndexing.m
//  UIElements
//
//  Created by Tobias Sommer on 11/26/12.
//  Copyright (c) 2012 Tobias Sommer. All rights reserved.
//

#import "WindowIndexing.h"
#import "UIElementUtilities.h"
#import <UIElements/Application.h>
#import <UIElements/UIElement.h>
#import <UIElements/NullUIElement.h>

@implementation WindowIndexing

- (NSArray*) indexingWindows :(NSString*) bundleIdentifier {
  NSMutableArray *allElements = [NSMutableArray array];

    AXUIElementRef appRef = ([UIElementUtilities getAppRefFromBundleIdentifier:bundleIdentifier]);

  if (appRef != nil) {
    
  //Get list of windows
    CFIndex windowsInApp;
    AXUIElementGetAttributeValueCount(appRef, kAXWindowsAttribute, &windowsInApp);
    CFTypeRef array;
    AXUIElementCopyAttributeValue(appRef, kAXWindowsAttribute, &array);

    NSArray *windows = CFBridgingRelease(array);
    CFTypeRef windowChildrenRef;
    for (id aWindow in windows) {
      AXUIElementCopyAttributeValue((__bridge AXUIElementRef)(aWindow), kAXChildrenAttribute, &windowChildrenRef);
      
      NSArray *windowChildren = CFBridgingRelease(windowChildrenRef);
      for (NSInteger i = 0; i < windowChildren.count; i++) {
        [self indexElements:(__bridge AXUIElementRef)(windowChildren[i]) :allElements];
      }
    }
  }
  return allElements;
}

- (void) indexElements :(AXUIElementRef) ref :(NSMutableArray*) allElements {
  CFArrayRef childrenArrayRef;
  AXUIElementCopyAttributeValue(ref, kAXChildrenAttribute, (CFTypeRef*) &childrenArrayRef);
  NSArray *childrenArray = CFBridgingRelease(childrenArrayRef);
  
  if (childrenArray.count > 0) {
    for (id oneChildren in childrenArray) {
      [self indexElements :(__bridge AXUIElementRef) oneChildren :allElements];
    }
  }
  else {
    UIElement *element = [UIElement createUIElement:ref];
    
    if([element class] != NullUIElement.class) {
      NSString *title = [element title];
      NSString *elementDescription = [element elementDescription];
      NSString *elementHelp = [element help];
      NSString *textFieldValue = [element textFieldValue];
      
//      NSLog(@"***********************");
//      NSLog(@"Description: %@", [element elementDescription]);
//      NSLog(@"Title: %@", [element title]);
//      NSLog(@"Help: %@", [element help]);
//      NSLog(@"roleDescription: %@", [element roleDescription]);
//      NSLog(@"identifier: %@", [element uiElementIdentifier]);
//      NSLog(@"TextFieldValue: %@", [element textFieldValue]);
//      NSLog(@"***********************");
      
      if(   [title length] > 0
         || [elementDescription length] > 0
         || [elementHelp length] > 0
         || ( ([textFieldValue isKindOfClass:[NSString class]]) && [textFieldValue length] > 0) ) {

        [element setElementImage:[UIElementUtilities captureUIElement :ref]];
        
        [allElements addObject:element];
      }
    }
  }
}

@end
