//
//  ButtonIdentifier.h
//  UIElements
//
//  Created by Tobias Sommer on 10/21/12.
//  Copyright (c) 2012 Tobias Sommer. All rights reserved.
//

#import "EVEIdentifierCreator.h"

@interface ButtonIdentifier : EVEIdentifierCreator

- (BOOL) withDescription;
- (BOOL) withHelp;
- (BOOL) withTitle;

@end
