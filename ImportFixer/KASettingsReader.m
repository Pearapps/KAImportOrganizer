//
//  KASettingsReader.m
//  ImportFixer
//
//  Created by Kenneth Parker Ackerson on 10/11/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import "KASettingsReader.h"
#import "KASettings.h"

@implementation KASettingsReader

+ (KASettings *)readSettings {
    NSURL *config = [NSURL fileURLWithPath:@"import_config"];
    
    NSError *error = nil;
    
    NSDictionary *settings = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:config] options:0 error:&error];
    
    if (!settings && error) {
        NSLog(@"Could not read import_config file. %@", error);
        exit(132);
    }
    
    NSArray *fileExtensions = settings[@"file_extensions"];
    NSArray *directories = settings[@"directories"];
    
    const BOOL shouldInsertNewLinesBetweenImportTypes = [settings[@"insert_new_lines_between_import_types"] boolValue];
    
    return [[KASettings alloc] initWithFileExtensions:fileExtensions directories:directories insertsNewLinesInBetweenTypes:shouldInsertNewLinesBetweenImportTypes];
}

@end
