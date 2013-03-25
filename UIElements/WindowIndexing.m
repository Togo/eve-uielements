//
//  WindowIndexing.m
//  UIElements
//
//  Created by Tobias Sommer on 11/26/12.
//  Copyright (c) 2012 Tobias Sommer. All rights reserved.
//

#import "WindowIndexing.h"
#import "UIElementUtilities.h"
#import "UIElement.h"
#import "NullUIElement.h"


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
	      dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
	      dispatch_async(queue, ^{
	        [self indexElements:(__bridge AXUIElementRef) windowChildren[i] :allElements];
	      });
      }
    }
  }

  return allElements;
}

- (void) indexElements :(AXUIElementRef) ref :(NSMutableArray*) allElements {
	NSArray *childrenArray= [self getChildrenArray:ref];

	[self addUIElmentToArray:ref allElements:allElements];

	if ( childrenArray.count > 0 ) {
    for (id oneChildren in childrenArray) {
      [self indexElements :(__bridge AXUIElementRef) oneChildren :allElements];
    }
  }

}

- (NSArray *)getChildrenArray:(AXUIElementRef)ref {
	CFArrayRef childrenArrayRef;
	AXUIElementCopyAttributeValue(ref, kAXChildrenAttribute, (CFTypeRef*) &childrenArrayRef);
	NSArray *childrenArray = CFBridgingRelease(childrenArrayRef);
	return childrenArray;
}

- (void)addUIElmentToArray:(AXUIElementRef)ref allElements:(NSMutableArray *)allElements {
	UIElement *element = [UIElement createUIElement:ref];
	if([element class] != NullUIElement.class) {
		[element setElementImage:[UIElementUtilities captureUIElement :ref]];
		[allElements addObject:element];
	}
}

@end
