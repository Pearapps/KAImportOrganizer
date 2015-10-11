//
//  KAImportStatement.h
//  ImportFixer
//
//  Created by Kenneth Parker Ackerson on 10/11/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

@import Foundation;

typedef NS_ENUM(char, KAImportType) {
    KAImportTypePound,
    KAImportTypeAtSign,
    KAImportTypeSwift
};

@interface KAImportStatement : NSObject

- (instancetype)initWithImportString:(NSString *)importString;

@property (nonatomic, copy, readonly) NSString *importString;

@property (nonatomic, readonly) NSArray <NSString *> *importParts;

@property (nonatomic, readonly) KAImportType importType;

@end
