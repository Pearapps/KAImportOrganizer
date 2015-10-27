//
//  KASourceFileLocator.m
//  ImportFixer
//
//  Created by Kenneth Parker Ackerson on 10/11/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import "KASourceFileLocator.h"

@interface KASourceFileLocator ()

@property (nonatomic, readonly) NSURL *directoryURL;
@property (nonatomic, readonly) NSArray *pathExtensions;

@end

@implementation KASourceFileLocator

- (instancetype)initWithDirectoryToLocateSourceFilesIn:(NSURL *)directoryURL acceptedPathExtensions:(NSArray *)pathExtensions {
    self = [super init];
    
    _directoryURL = directoryURL;
    _pathExtensions = pathExtensions;
    
    return self;
}

- (NSArray *)files {
    return [self filesInDirectory:self.directoryURL];
}

- (NSArray *)filesInDirectory:(NSURL *)directoryURL {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDirectoryEnumerator *enumerator = [fileManager enumeratorAtURL:directoryURL includingPropertiesForKeys:@[NSURLIsDirectoryKey] options:NSDirectoryEnumerationSkipsHiddenFiles | NSDirectoryEnumerationSkipsPackageDescendants errorHandler:^BOOL(NSURL *url, NSError *error) {
        if (error) { return NO; }
        
        return YES;
    }];
    
    NSMutableArray *files = [NSMutableArray new];
    
    for (NSURL *fileURL in enumerator) {
        NSNumber *isDirectory = nil;
        [fileURL getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:nil];
        
        if (!isDirectory.boolValue && [self.pathExtensions containsObject:fileURL.pathExtension]) {
            [files addObject:fileURL];
        }
    }

    return [files copy];
}

@end
