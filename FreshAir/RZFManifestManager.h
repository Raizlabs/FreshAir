//
//  RZFRemoteBundleController.h
//  FreshAir
//
//  Created by Brian King on 1/23/16.
//  Copyright © 2016 Raizlabs. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN;

@protocol RZFManifestManagerDelegate;
@class RZFEnvironment;

@interface RZFManifestManager : NSObject

/**
 *  The default local URL to download the manifest bundles too.
 */
+ (NSURL *)defaultLocalURL;

/**
 *  Create a new manifest manager that will obtain the manifest at the remote URL and store it in the localURL directory
 *
 *  @param remoteURL The remote URL to load. This should refer to the .freshair file, not the manifest file.
 *  @param localURL The local path to store the root bundle. A directory will be appended to this URL to contain the root bundle. If this value is nil, it will default to [RZFManifestManager defaultLocalURL]
 *  @param environment The local path to store the root bundle. A directory will be appended to this URL to contain the root bundle.
 *
 *
 *  @param delegate The delegate to be informed when a bundle is loaded.
 */
- (instancetype)initWithRemoteURL:(NSURL *)remoteURL
                         localURL:(NSURL * __nullable)localURL
                      environment:(RZFEnvironment * __nullable)environment
                         delegate:(id<RZFManifestManagerDelegate>)delegate;

/**
 *  Update the local bundle to the state of the remote bundle.
 */
- (void)update;

@property (strong, nonatomic, readonly) NSBundle * __nullable bundle;
@property (strong, nonatomic, readonly) NSArray<NSBundle *> *allBundles;
@property (assign, nonatomic, readonly) BOOL loaded;


@end

@protocol RZFManifestManagerDelegate <NSObject>

- (void)manifestManager:(RZFManifestManager *)manifestManager didLoadBundle:(NSBundle *)bundle;
- (void)manifestManager:(RZFManifestManager *)manifestManager didEncounterError:(NSError *)error;

@end

NS_ASSUME_NONNULL_END;

