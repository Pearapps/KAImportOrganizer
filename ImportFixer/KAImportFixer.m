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

- (void)organize {
    KASettings *settings = [KASettingsReader readSettings];
    NSTimeInterval time = [[NSDate date] timeIntervalSinceReferenceDate];
    
    __block NSInteger importCount = 0;
    __block NSInteger fileCount = 0;
    
    for (NSString *directory in settings.directories) {
        NSURL *URL = [NSURL fileURLWithPath:directory];
        
        KASourceFileLocator *sourceFileLocator = [[KASourceFileLocator alloc] initWithDirectoryToLocateSourceFilesIn:URL acceptedPathExtensions:settings.fileExtensions];
        
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
        dispatch_group_t group = dispatch_group_create();
        
        NSArray *files = [sourceFileLocator files];
        fileCount += files.count;

        for (NSURL *file in files) {
            dispatch_group_async(group, queue, ^{
                KAImportFinder *importFinder = [[KAImportFinder alloc] initWithLineReader:[[KAWholeFileLoadingLineReader alloc] initWithFileURL:file]];
                const NSArray *firstImports = [importFinder importStrings];
                const NSArray *newlinesAmounts = [importFinder numbersOfNewLines];
                
                NSInteger i = 0;
                for (NSArray *importStrings in firstImports) {
                    const NSInteger numberOfNewlines = [newlinesAmounts[i] integerValue];
                    i++;
                    
                    importCount += importStrings.count;
                    KAImportSorter *sorter = [[KAImportSorter alloc] initWithImports:importStrings];
                    [[[KAImportReplacer alloc] initWithOriginalImportStrings:importStrings sorted:[sorter sortedImports] fileURL:file numberOfNewlines:numberOfNewlines] replace];
                }
            });
        }
        
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    }
    
    NSLog(@"Sorted %ld imports in %ld files - in %f seconds", importCount, fileCount, [[NSDate date] timeIntervalSinceReferenceDate] - time);
}

@end
