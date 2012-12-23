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

- (NSArray*) indexingWindows :(AXUIElementRef) appRef {
  
  //Get list of apps
  NSMutableArray *allElements = [NSMutableArray array];
  
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
      NSMutableDictionary *tableRow = [NSMutableDictionary dictionary];
      NSString *title = [element title];
      NSString *elementDescription = [element elementDescription];
      NSString *elementHelp = [element help];
      NSString *roleDescription = [element roleDescription];
      NSString *role = [element role];
      NSString *textFieldValue = [element textFieldValue];
      if([title length] > 0
         || [elementDescription length] > 0
         || [elementHelp length] > 0
         || [textFieldValue length] > 0) {

      [tableRow setValue:textFieldValue forKey:@"text_value"];
      [tableRow setValue:title forKey:@"element_title"];
      [tableRow setValue:elementDescription forKey:@"element_description"];
      [tableRow setValue:elementHelp forKey:@"element_help"];
      [tableRow setValue:roleDescription forKey:@"role_description"];
      [tableRow setValue:role forKey:@"role"];
      [tableRow setValue:element forKey:@"element"];
      NSLog(@"***********************");
      NSLog(@"Description: %@", [element elementDescription]);
      NSLog(@"Title: %@", [element title]);
      NSLog(@"Help: %@", [element help]);
      NSLog(@"roleDescription: %@", [element roleDescription]);
      NSLog(@"identifier: %@", [element uiElementIdentifier]);
      NSLog(@"***********************");
      [allElements addObject:tableRow];
      }
    }
  }
}

@end
