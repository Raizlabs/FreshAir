//
//  RZFUpdateViewModel.m
//  FreshAir
//
//  Created by Brian King on 1/27/16.
//  Copyright © 2016 Raizlabs. All rights reserved.
//

#import "RZFUpdateViewModel.h"
#import "RZFReleaseNotes.h"

static NSString * const RZFUpdateViewModelForcedUpdatePrefix = @"freshair.update.forced";
static NSString * const RZFUpdateViewModelUpdatePrefix = @"freshair.update";
static NSString * const RZFUpdateViewModelStringTableName = @"FreshAirUpdate";
static NSString * const RZFUpdateViewModelUpdateImageName = @"freshair_update";

static NSString * const RZFUpdateViewModelLocalizedKeyTitle = @"title";
static NSString * const RZFUpdateViewModelLocalizedKeyDescription = @"description";
static NSString * const RZFUpdateViewModelLocalizedKeyConfirm = @"confirm";
static NSString * const RZFUpdateViewModelLocalizedKeyDismiss = @"dismiss";

static NSString *RZFLocalizedValue(NSString * _Nonnull prefix, NSString * _Nonnull key, NSBundle * _Nullable fallbackBundle) {
    static NSString * const notFoundToken = @"RZFKeyNotFound";
    
    NSString *fullKey = [@[prefix,key] componentsJoinedByString:@"."];
    NSBundle *mainBundle = [NSBundle mainBundle];
    
    NSString *localizedValue = [mainBundle localizedStringForKey:fullKey value:notFoundToken table:nil];
    
    if ([localizedValue isEqualToString:notFoundToken]) {
        localizedValue = [mainBundle localizedStringForKey:fullKey value:notFoundToken table:RZFUpdateViewModelStringTableName];
    }
    
    if ([localizedValue isEqualToString:notFoundToken] && fallbackBundle) {
        NSString *fallbackLocalizedValue = [fallbackBundle localizedStringForKey:fullKey value:notFoundToken table:nil];
        
        if ([fallbackLocalizedValue isEqualToString:notFoundToken]) {
            fallbackLocalizedValue = [fallbackBundle localizedStringForKey:fullKey value:notFoundToken table:RZFUpdateViewModelStringTableName];
        }
        
        localizedValue = fallbackLocalizedValue;
    }
    
    if ([localizedValue isEqualToString:notFoundToken]) {
        NSLog(@"failed to find localized value for key %@", fullKey);
        localizedValue = nil;
    }
    
    return localizedValue;
}

@implementation RZFUpdateViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        /* Do Nothing */
    }
   
    return self;
}

- (UIImage*)image
{
    UIImage *image = [UIImage imageNamed:RZFUpdateViewModelUpdateImageName];
    
    if (!image) {
        NSBundle *fallbackBundle = [NSBundle bundleForClass:self.class];
        image = [UIImage imageNamed:RZFUpdateViewModelUpdateImageName inBundle:fallbackBundle compatibleWithTraitCollection:nil];
    }
    
    return image;
}

- (NSString*)localizedTitle
{
    return [self localizedValueForKey:RZFUpdateViewModelLocalizedKeyTitle];
}

- (NSString*)localizedDescription
{
    return [self localizedValueForKey:RZFUpdateViewModelLocalizedKeyDescription];
}

- (NSString*)localizedDismiss
{
    return [self localizedValueForKey:RZFUpdateViewModelLocalizedKeyDismiss];
}

- (NSString*)localizedConfirmation
{
    return [self localizedValueForKey:RZFUpdateViewModelLocalizedKeyConfirm];
}

#pragma  mark - Private

- (NSString*)localizedValueForKey:(NSString*)key
{
    NSString *localizedValue = nil;
    NSBundle *fallbackBundle = [NSBundle bundleForClass:self.class];
    
    if (self.isForced) {
        localizedValue = RZFLocalizedValue(RZFUpdateViewModelForcedUpdatePrefix, key, fallbackBundle);
    }
    
    if (!localizedValue) {
        localizedValue = RZFLocalizedValue(RZFUpdateViewModelUpdatePrefix, key, fallbackBundle);
    }
    
    return localizedValue;
}

@end
