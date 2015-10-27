//
//  KASettingsReader.m
//  ImportFixer
//
//  Created by Kenneth Parker Ackerson on 10/11/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import "KASettingsReader.h"
#import "KASettings.h"

#define TestDirectory @"/Users/Kenny/Desktop/Chains"

@implementation KASettingsReader

+ (KASettings *)readSettings {
#ifdef DEBUG
    return [[KASettings alloc] initWithDirectories:@[TestDirectory] fileExtensions:@[@"h"]];
#else
    NSURL *config = [NSURL fileURLWithPath:@"import_config"];
    
    NSError *error = nil;
    
    NSDictionary *settings = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:config] options:0 error:&error];
    
    if (!settings && error) {
        NSLog(@"Could not read import_config file. %@", error);
        exit(132);
    }
    
    NSArray *fileExtensions = settings[@"file_extensions"];
    NSArray *directories = settings[@"directories"];
    
    return [[KASettings alloc] initWithDirectories:directories fileExtensions:fileExtensions];
#endif
}

@end
