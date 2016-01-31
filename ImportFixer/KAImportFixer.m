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
#import "KAFullContentsImportReplacerAndTransformer.h"
#import "KASourceFileLocator.h"
#import "KAWholeFileLoadingLineReader.h"
#import "KASettings.h"
#import "KASettingsReader.h"
#import "KAImportStringTransformer.h"

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
                NSString *fileContents = [[NSString alloc] initWithContentsOfURL:file encoding:NSUTF8StringEncoding error:nil];
                
                KAImportFinder *importFinder = [[KAImportFinder alloc] initWithLineReader:[[KAWholeFileLoadingLineReader alloc] initWithFileContents:fileContents]];
                NSArray *firstImports = [importFinder importStrings];
                NSArray *newlinesAmounts = [importFinder numbersOfNewLines];
                
                KAFullContentsImportReplacerAndTransformer *importReplacer = [[KAFullContentsImportReplacerAndTransformer alloc] initWithImports:firstImports
                                                                                                                               numbersOfNewlines:newlinesAmounts
                                                                                                                                originalContents:fileContents insertsNewLinesInBetweenTypes:NO
                                                                                                                           sortOrderOfImportType:settings.sortOrder];
                
                importCount += [importReplacer importAmount];
                if ([importReplacer didChangeAnyCharacters]) {
                    [[importReplacer transformedString] writeToURL:file atomically:YES encoding:NSUTF8StringEncoding error:nil];
                }
            });
        }
        
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    }
    
    NSLog(@"Sorted %ld imports in %ld files - in %f seconds", importCount, fileCount, [[NSDate date] timeIntervalSinceReferenceDate] - time);
}

@end
