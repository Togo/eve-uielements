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
#import "StaticTextField.h"
#import "NullUIElement.h"
#import "SearchTextField.h"

@implementation UIElement

@synthesize shortcut;
@synthesize owner;

@synthesize user;

@synthesize uiElementIdentifier;
@synthesize cocoaIdentifierString;

@synthesize shortcutString;

@synthesize role;
@synthesize roleDescription;
@synthesize title;
@synthesize parentTitle;
@synthesize elementDescription;
@synthesize help;
@synthesize subrole;
@synthesize cocoaIdentifierAttribute;
@synthesize textFieldValue;

@synthesize elementImage;

@synthesize disabled;


+ (id) createUIElement :(AXUIElementRef) ref {
  // kAXRoleAttribute
  NSString *attribute = [UIElementUtilities readkAXAttributeString:ref :kAXRoleAttribute];
  NSString *elementRole = attribute ? attribute : @"";
  
  attribute = [UIElementUtilities readkAXAttributeString:ref :kAXSubroleAttribute];
  NSString *subRole = attribute ? attribute : @"";
  
  if ([elementRole isEqualToString :(NSString*)kAXButtonRole]
    || [elementRole isEqualToString :(NSString*)kAXRadioButtonRole]
    || [elementRole isEqualToString :(NSString*)kAXCheckBoxRole]) {
    return [[Button alloc] initWithUIElementRef:ref];
  }
  else if ([elementRole isEqualToString:(NSString*)kAXMenuItemRole])
  {
    return [[MenuItem alloc] initWithUIElementRef:ref];
  }
  else if ([elementRole isEqualToString:(NSString*)kAXTextFieldRole])
  {
    if ([subRole isEqualToString:(NSString*) kAXSearchFieldSubrole])
    {
      return [[SearchTextField alloc] initWithUIElementRef:ref];
    }
    else
    {
      return [[TextField alloc] initWithUIElementRef:ref];
    }
  }
  else if ([elementRole isEqualToString:(NSString*)kAXStaticTextRole])
  {
    return [[StaticTextField alloc] initWithUIElementRef:ref];
  }
  else
  {
    return [[NullUIElement alloc] initWithUIElementRef:ref];
  }
  
  return nil;
}

- (id) initWithUIElementRef :(AXUIElementRef) ref {
  @synchronized(self) {
    self = [super init];
    
    self.owner = [[Application alloc] initWithElementReference:ref];
    
    self.user = NSUserName();
    
    // kAXRoleAttribute
    NSString *attribute = [UIElementUtilities readkAXAttributeString:ref :kAXRoleAttribute];
    self.role = attribute ? attribute : @"";
    
    // kAXRoleDescriptionAttribute
    attribute = [UIElementUtilities readkAXAttributeString:ref :kAXRoleDescriptionAttribute];
    self.roleDescription = attribute ? attribute : @"";
    
    // kAXTitleAttribute
    attribute = [UIElementUtilities readkAXAttributeString:ref :kAXTitleAttribute];
    self.title = attribute ? [UIElementUtilities cleanString:attribute] : @"";
    
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
    
    // kAXValueAttribute
    attribute = [UIElementUtilities readkAXAttributeString:ref :kAXValueAttribute];
    self.textFieldValue = attribute ? attribute : @"";
    
    // kAXVCocoaIdentifierAttribute
    attribute = [UIElementUtilities readkAXAttributeString:ref :kAXIdentifierAttribute];
    self.cocoaIdentifierAttribute = attribute ? attribute : @"";
    
    // The Shortcut
    self.shortcut = [[EVEShortcut alloc] initWithUIElementRef:ref];
    
    // show message?
    self.disabled = NO;
    
    return self;
  }
}

- (id) createIdentifier {
  [NSException raise:NSInternalInconsistencyException
              format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
  return nil;
}

@end
