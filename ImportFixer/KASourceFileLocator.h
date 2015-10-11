//
//  KASourceFileLocator.h
//  ImportFixer
//
//  Created by Kenneth Parker Ackerson on 10/11/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

@import Foundation;

@interface KASourceFileLocator : NSObject

- (instancetype)initWithDirectoryToLocateSourceFilesIn:(NSURL *)directoryURL acceptedPathExtensions:(NSArray *)pathExtensions;

- (NSArray *)files;

@end
