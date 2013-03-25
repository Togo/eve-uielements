//
//  UIElementUtilities.h
//  UIElements
//
//  Created by Tobias Sommer on 10/21/12.
//  Copyright (c) 2012 Tobias Sommer. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIElement;

@interface UIElementUtilities : NSObject

+ (NSString*) readkAXAttributeString:(AXUIElementRef)element :(CFStringRef) kAXAttribute;
+ (AXUIElementRef) secondParent :(AXUIElementRef) elementRef;
+ (NSString*) cleanString :(id) string;
+ (AXUIElementRef) getAppRefFromBundleIdentifier :bundleIdentifier;
+ (AXUIElementRef) getUIElementUnderMousePointer :(NSString*) bundleIdentifier;
+ (NSImage *) captureUIElement : (AXUIElementRef) ref;

+ (UIElement *)copyElementAtPoint:(CGFloat)x andPoint:(CGFloat)y applicationReference:(AXUIElementRef)appRef rectToScan:(NSRect)selectedRect;
+ (NSRect)readElementDimension:(AXUIElementRef)ref;
@end
