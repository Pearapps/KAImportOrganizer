//
//  KASettingsReader.m
//  ImportFixer
//
//  Created by Kenneth Parker Ackerson on 10/11/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import "KASettingsReader.h"
#import "KASettings.h"
#import "KAImportTypeModel.h"

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
    
    NSArray <NSString *> *sortOrder = settings[@"Objective-C_sort_order"];
    
    NSArray <KAImportTypeModel *> *importModels = nil;
    if (sortOrder.count != 3 && sortOrder.count != 0) {
        NSLog(@"Invalid amount of sort order strings found");
    }
    else {
        importModels = ^ NSArray <KAImportTypeModel *> * {
            NSMutableArray <KAImportTypeModel *> *mutableArray = [[NSMutableArray alloc] init];
            for (NSString *string in sortOrder) {
                [mutableArray addObject:[[KAImportTypeModel alloc] initWithImportTypeString:string]];
            }
            return [mutableArray copy];
        }();
    }
    
    return [[KASettings alloc] initWithFileExtensions:fileExtensions
                                          directories:directories
                        insertsNewLinesInBetweenTypes:shouldInsertNewLinesBetweenImportTypes
                                            sortOrder:importModels];
}

@end
