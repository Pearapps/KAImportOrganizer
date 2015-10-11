//
//  KAImportFixer.m
//  ImportFixer
//
//  Created by Kenneth Parker Ackerson on 10/11/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import "KAImportFixer.h"
#import "KAImportFinder.h"
#import "KAImportSorter.h"
#import "KAImportReplacer.h"
#import "KASourceFileLocator.h"
#import "KAWholeFileLoadingLineReader.h"
#import "KASettings.h"
#import "KASettingsReader.h"

@implementation KAImportFixer

- (instancetype)init {
    self = [super init];
    
    KASettings *settings = [KASettingsReader readSettings];
    NSTimeInterval time = [[NSDate date] timeIntervalSinceReferenceDate];

    for (NSString *directory in settings.directories) {
        NSURL *URL = [NSURL fileURLWithPath:directory];
//        NSURL *URL = [NSURL fileURLWithPath:[[NSHomeDirectory() stringByAppendingPathComponent:@"Desktop"] stringByAppendingPathComponent:@"DirectoryToSearch"]];
        
        KASourceFileLocator *sourceFileLocator = [[KASourceFileLocator alloc] initWithDirectoryToLocateSourceFilesIn:URL acceptedPathExtensions:settings.fileExtensions];
        
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
        dispatch_group_t group = dispatch_group_create();
        
        NSArray *files = [sourceFileLocator files];
        
        for (NSURL *file in files) {
            dispatch_group_async(group, queue, ^{
                KAImportFinder *importFinder = [[KAImportFinder alloc] initWithLineReader:[[KAWholeFileLoadingLineReader alloc] initWithFileURL:file]];
                NSArray *firstImports = [importFinder importStrings];
                
                for (NSArray *importStrings in firstImports) {
                    KAImportSorter *sorter = [[KAImportSorter alloc] initWithImports:importStrings];
                    [[[KAImportReplacer alloc] initWithOriginalImportStrings:importStrings sorted:[sorter sortedImports] fileURL:file] replace];
                }
            });
        }
        
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);

    }
    NSLog(@"%f", [[NSDate date] timeIntervalSinceReferenceDate] - time);

    
    return self;
}



@end
