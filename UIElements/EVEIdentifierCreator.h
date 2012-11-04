//
//  EVEIdentifier.h
//  UIElements
//
//  Created by Tobias Sommer on 10/21/12.
//  Copyright (c) 2012 Tobias Sommer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Identifier.h"

@interface EVEIdentifierCreator : NSObject <Identifier>

@property (strong, nonatomic) NSString *identifierString;

- (BOOL) withDescription;
- (BOOL) withHelp;
- (BOOL) withAppName;
- (BOOL) withTitle;
- (BOOL) withSubrole;
- (BOOL) withParentTitle;

@end
