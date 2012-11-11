//
//  Identifier.h
//  UIElements
//
//  Created by Tobias Sommer on 10/21/12.
//  Copyright (c) 2012 Tobias Sommer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIElement.h"

@protocol  Identifier <NSObject>

- (NSString*) createIdentifier :(id) element;
- (NSString*) createCocoaIdentifier :(id) element;

@end

