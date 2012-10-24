//
//  UIElement.m
//  UIElements
//
//  Created by Tobias Sommer on 10/21/12.
//  Copyright (c) 2012 Tobias Sommer. All rights reserved.
//

#import "UIElement.h"
#import "Button.h"
#import "MenuItem.h"
#import "TextField.h"

@implementation UIElement

@synthesize shortcut;
@synthesize owner;
@synthesize uiElementIdentifier;

@synthesize role;
@synthesize roleDescription;
@synthesize title;
@synthesize parentTitle;
@synthesize elementDescription;
@synthesize help;
@synthesize subrole;

@synthesize disabled;

+ (id) createUIElement :(AXUIElementRef) ref {
  // kAXRoleAttribute
  NSString *attribute = [UIElementUtilities readkAXAttributeString:ref :kAXRoleAttribute];
  NSString *elementRole = attribute ? attribute : @"";
  
  if ([elementRole isEqualToString:(NSString*)kAXButtonRole]) {
    return [[Button alloc] initWithUIElementRef:ref];
  } else if ([elementRole isEqualToString:(NSString*)kAXMenuBarItemRole]) {
    return [[MenuItem alloc] initWithUIElementRef:ref];
  } else if ([elementRole isEqualToString:(NSString*)kAXTextFieldRole]) {
    return [[TextField alloc] initWithUIElementRef:ref];
  }
  
  return nil;
}

- (id) initWithUIElementRef :(AXUIElementRef) ref {
  self = [super init];
  

  self.owner = [[Application alloc] initWithElementReference:ref];

  self.itemRef = ref;
  // kAXRoleAttribute
  NSString *attribute = [UIElementUtilities readkAXAttributeString:ref :kAXRoleAttribute];
  self.role = attribute ? attribute : @"";
  
  // kAXRoleDescriptionAttribute
  attribute = [UIElementUtilities readkAXAttributeString:ref :kAXRoleDescriptionAttribute];
  self.roleDescription = attribute ? attribute : @"";
  
  // kAXTitleAttribute
  attribute = [UIElementUtilities readkAXAttributeString:ref :kAXTitleAttribute];
  self.title = attribute ? attribute : @"";
  
  // kAXParentTitleAttribute
  AXUIElementRef parentRef = [UIElementUtilities secondParent:ref];
  attribute = [UIElementUtilities readkAXAttributeString:parentRef :kAXTitleAttribute];
  self.parentTitle = attribute ? attribute : @"";
  
  // kAXDescriptionAttribute
  attribute = [UIElementUtilities readkAXAttributeString:ref :kAXDescriptionAttribute];
  self.elementDescription = attribute ? attribute : @"";
  
  // kAXHelpAttribute
  attribute = [UIElementUtilities readkAXAttributeString:ref :kAXHelpAttribute];
  self.help = attribute ? attribute : @"";
  
  // kAXSubroleAttribute
  attribute = [UIElementUtilities readkAXAttributeString:ref :kAXSubroleAttribute];
  self.subrole = attribute ? attribute : @"";
  
  // The Shortcut
  self.shortcut = [[EVEShortcut alloc] initWithUIElementRef:ref];
  
  // show message?
  self.disabled = NO;
  
  return self;
}

- (id) createIdentifier {
  [NSException raise:NSInternalInconsistencyException
              format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
  return nil;
}

@end