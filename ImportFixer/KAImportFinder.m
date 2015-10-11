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

@end

@implementation KAImportFinder

- (instancetype)initWithLineReader:(id <KALineReader>)lineReader {
    self = [super init];
    
    _lineReader = lineReader;
    
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

- (NSArray *)importStrings {
    id <KALineReader> lineReader = [self lineReader];
    NSMutableArray *lines = [NSMutableArray new];
    
    NSArray *preprocessorConditionals = @[@"#elif", @"#if", @"#ifdef", @"#else", @"//"];
    
    NSMutableArray *currentLinesArray = [NSMutableArray new];
    [lines addObject:currentLinesArray];
    
    while ([lineReader hasAnotherLine]) {
        NSString *line = [lineReader readLine];
        
        if (stringContainsOneOfTheseStrings(line, preprocessorConditionals)) {
            currentLinesArray = [NSMutableArray new];
            [lines addObject:currentLinesArray];
        }
        else if ([self isImportStatement:line]) {
            [currentLinesArray addObject:[[KAImportStatement alloc] initWithImportString:line]];
        }
        else if ([line containsString:@"@implementation"] || [line containsString:@"@interface"]) {
            break;
        }
    }
    
    return lines;
}

- (BOOL)isImportStatement:(NSString *)string {
    if (string.length >= 5 && ([string rangeOfString:@"#import"].location != NSNotFound || [string rangeOfString:@"@import"].location != NSNotFound || [string rangeOfString:@"import"].location != NSNotFound)) {
        return YES;
    }
    return NO;
}

@end
