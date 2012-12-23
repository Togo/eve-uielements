//
//  MenuBarIndexing.m
//  UIElements
//
//  Created by Tobias Sommer on 10/23/12.
//  Copyright (c) 2012 Tobias Sommer. All rights reserved.
//

#import "MenuBarIndexing.h"
#import "MenuItem.h"

@implementation MenuBarIndexing

@synthesize elements;

- (NSArray*) indexMenuBar :(AXUIElementRef) appRef {
  elements = [NSMutableArray array];
  CFTypeRef menuBarRef;
  
  AXUIElementCopyAttributeValue(appRef, kAXMenuBarAttribute, (CFTypeRef*)&menuBarRef);
  
  if (menuBarRef != nil) {
    
    CFArrayRef menuBarArrayRef;
    AXUIElementCopyAttributeValue(menuBarRef, kAXChildrenAttribute, (CFTypeRef*) &menuBarArrayRef);
    NSArray *menuBarItems = CFBridgingRelease(menuBarArrayRef);
    for (id menuBarItemRef in menuBarItems) {
      [self readAllMenuItems :(__bridge AXUIElementRef)menuBarItemRef];
    }
  }
  
  return elements;
}

- (void) readAllMenuItems :(AXUIElementRef) menuBarItemRef {
  CFArrayRef childrenArrayRef;
  AXUIElementCopyAttributeValue(menuBarItemRef, kAXChildrenAttribute, (CFTypeRef*) &childrenArrayRef);
  NSArray *childrenArray = CFBridgingRelease(childrenArrayRef);
  
  if (childrenArray.count > 0) {
    for (id oneChildren in childrenArray) {
      [self readAllMenuItems :(__bridge AXUIElementRef) oneChildren];
    }
  }
  else {
    MenuItem *item = [[MenuItem alloc] initWithUIElementRef: menuBarItemRef];
    [elements addObject:item];
  }
}

@end
