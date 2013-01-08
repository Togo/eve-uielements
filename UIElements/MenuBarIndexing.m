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

- (NSArray*) indexMenuBarWithBundleIdentifier :(NSString*) bundleIdentifier {
  NSMutableArray *allElements = [NSMutableArray array];
  if (bundleIdentifier == nil) {
    NSException *nilBundleIdentifier = [NSException
                                exceptionWithName:@"BundleIdentfierNil"
                                reason:@"Can't indexing a Menu Bar with a Nil Bundle Identifier"
                                userInfo:nil];
    @throw nilBundleIdentifier;
  } else {
      AXUIElementRef appRef = [UIElementUtilities getAppRefFromBundleIdentifier:bundleIdentifier];
      if (appRef != nil) {
      NSArray *indexedElements = [self indexMenuBar:appRef];
      for (id aElement in indexedElements) {
        if (aElement
            && ([[aElement title] length] > 0)
            && ([[aElement shortcutString] length] > 0) ) {
          NSMutableDictionary *dic = [NSMutableDictionary dictionary];
          [dic setValue:[aElement title] forKey:@"TitleColumn"];
          [dic setValue:[aElement shortcutString] forKey:@"ShortcutStringColumn"];
          
          [allElements addObject:dic];
        }
      }
    }
  }
  
  return allElements;
}

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
