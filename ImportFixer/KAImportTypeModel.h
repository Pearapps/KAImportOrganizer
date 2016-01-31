//
//  KAImportTypeModel.h
//  ImportFixer
//
//  Created by Kenneth Parker Ackerson on 1/30/16.
//  Copyright © 2016 Kenneth Parker Ackerson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KAImportType.h"

/**
 *  Represents a @c KAImportType as an object.
 *  Provides a way to store them in Objective-C collections and to transform from string to @c KAImportType.
 */
@interface KAImportTypeModel : NSObject

- (nonnull instancetype)initWithImportTypeString:(nonnull NSString *)importTypeString;

- (nonnull instancetype)initWithImportType:(KAImportType)importType;

@property (nonatomic, readonly) KAImportType importType;

@end
