//
//  MenuBarIndexing.h
//  UIElements
//
//  Created by Tobias Sommer on 10/23/12.
//  Copyright (c) 2012 Tobias Sommer. All rights reserved.
//

#import "UIElementIndexing.h"

@interface MenuBarIndexing : UIElementIndexing {
  NSMutableArray *elements;
}

@property NSMutableArray *elements;

- (NSArray*) indexMenuBar :(AXUIElementRef) appRef;
- (NSArray*) indexMenuBarWithBundleIdentifier :(NSString*) bundleIdentifier;
- (void) readAllMenuItems :(AXUIElementRef) menuBarItemRef;
@end
