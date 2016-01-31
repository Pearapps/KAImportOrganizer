//
//  KAImportStatement.m
//  ImportFixer
//
//  Created by Kenneth Parker Ackerson on 10/11/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import "KAImportStatement.h"

@implementation KAImportStatement

- (instancetype)initWithImportString:(NSString *)importString {
    self = [super init];
    
    _importString = importString;
    _importType = [self importTypeForImportString:importString];
    
    _importParts = [[self importStringByTrimmingTokensFromImportString:[self importStringByRemovingImportPartFromImportString:importString]] componentsSeparatedByString:[self seperatorForSpecificFileImportInsideOfFrameworkOfType:_importType]];
    
    return self;
}

- (NSString *)importStringByRemovingImportPartFromImportString:(NSString *)importString {
    NSRange range = [importString rangeOfString:@"import "];
    return [importString substringFromIndex:range.location + range.length];
}

- (NSString *)importStringByTrimmingTokensFromImportString:(NSString *)importString {
    const NSArray *strings = @[@"<", @">", @"\"", @";"];
    
    NSString *returnString = importString;
    
    for (NSString *string in strings) {
        returnString = [returnString stringByReplacingOccurrencesOfString:string withString:@""];
    }
    
    return returnString;
}

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    
    if ([object isKindOfClass:[KAImportStatement class]]) {
        KAImportStatement *import = (KAImportStatement *)object;
        if (!import.importType != self.importType) {
            return NO;
        }
        return [self.importString isEqualToString:import.importString];
    }
    
    return NO;
}

- (KAImportType)importTypeForImportString:(NSString *)importString {
    if ([importString characterAtIndex:0] == '#') {
        if ([importString containsString:@"<"] && [importString containsString:@">"]) {
            return KAImportTypePoundLibrary;
        }
        
        return KAImportTypePound;
    }
    else if ([importString characterAtIndex:0] == '@' && ![importString containsString:@"@testable"]) {
        return KAImportTypeAtSign;
    }
    else {
        return KAImportTypeSwift;
    }
}

- (NSString *)seperatorForSpecificFileImportInsideOfFrameworkOfType:(KAImportType)importType {
    switch (importType) {
        case KAImportTypePound:
            // fall through on purpose
        case KAImportTypePoundLibrary:
            return @"/";
        case KAImportTypeSwift:
            // fall through on purpose
        case KAImportTypeAtSign:
            return @".";
    }
}

@end
