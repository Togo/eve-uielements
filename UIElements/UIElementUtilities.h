//
//  UIElementUtilities.h
//  UIElements
//
//  Created by Tobias Sommer on 10/21/12.
//  Copyright (c) 2012 Tobias Sommer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIElementUtilities : NSObject

+ (NSString*) readkAXAttributeString:(AXUIElementRef)element :(CFStringRef) kAXAttribute;
+ (AXUIElementRef) secondParent :(AXUIElementRef) elementRef;

@end
