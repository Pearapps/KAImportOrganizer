//
//  ImportFinder.m
//  ImportFixer
//
//  Created by Kenneth Parker Ackerson on 10/10/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import "KAImportFinder.h"
#import "KALineReader.h"
#import "KAImportStatement.h"
#import "KAWholeFileLoadingLineReader.h"

@interface KAImportFinder ()

@property (nonatomic, readonly) id <KALineReader> lineReader;

@property (nonatomic, readonly) NSArray *numbersOfNewLines;
@property (nonatomic, readonly) NSArray *importStrings;

@end

@implementation KAImportFinder

- (instancetype)initWithLineReader:(id <KALineReader>)lineReader {
    self = [super init];
    
    _lineReader = lineReader;
    [self analyze];
    
    return self;
}

static inline BOOL stringContainsOneOfTheseStrings(NSString *string, NSArray *otherstrings) {
    for (NSString *stn in otherstrings) {
        if ([string containsString:stn]) {
            return YES;
        }
    }
    return NO;
}

- (void)analyze {
    id <KALineReader> lineReader = [self lineReader];
    NSMutableArray *lines = [NSMutableArray new];
    NSMutableArray *rangeOfNewLines = [[NSMutableArray alloc] init];
    
    NSArray *preprocessorConditionals = @[@"#elif", @"#endif", @"#if", @"#ifdef", @"#else", @"//", @"/**", @"*/", @"*"];
    
    NSMutableArray *currentLinesArray = [NSMutableArray new];
    
    [lines addObject:[NSMutableArray new]];
    [rangeOfNewLines addObject:@(0)];
    
    NSInteger currentCountOfNewLines = 0;
    NSInteger batchedCountOfNewLines = 0;
    BOOL hasFoundImportYet = NO;
    
    void (^replace)(NSInteger) = ^void(NSInteger currentCountOfNewLines) {
        [rangeOfNewLines replaceObjectAtIndex:rangeOfNewLines.count - 1 withObject:@(currentCountOfNewLines)];
    };

    
    while ([lineReader hasAnotherLine]) {
        NSString *line = [lineReader readLine];
        
        replace(currentCountOfNewLines);
        
        if (stringContainsOneOfTheseStrings(line, preprocessorConditionals)) {
            currentLinesArray = [NSMutableArray new];
            
            [lines addObject:currentLinesArray];
            [rangeOfNewLines addObject:@(0)];
            currentCountOfNewLines = 0;
        }
        else if ([self isImportStatement:line]) {
            hasFoundImportYet = YES;
            currentCountOfNewLines += batchedCountOfNewLines;
            batchedCountOfNewLines = 0;
            [currentLinesArray addObject:[[KAImportStatement alloc] initWithImportString:line]];
            replace(currentCountOfNewLines);
        }
        else if ([line isEqual:@"\n"]) {
            if (hasFoundImportYet) { batchedCountOfNewLines++; }
        }
        else if (stringContainsOneOfTheseStrings(line, @[@"@implementation", @"@interface"])) {
            break;
        }
    }
    
    _importStrings = lines;
    _numbersOfNewLines = rangeOfNewLines;
}

- (BOOL)isImportStatement:(NSString *)string {
    if (string.length >= 5 && stringContainsOneOfTheseStrings(string, @[@"import ", @"#import ", @"@import "])) {
        return YES;
    }
    return NO;
}

@end
