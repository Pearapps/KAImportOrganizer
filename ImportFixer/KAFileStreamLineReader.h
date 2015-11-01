//
//  KAFileStreamLineReader.h
//  ImportFixer
//
//  Created by Kenneth Parker Ackerson on 11/1/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KALineReader.h"

@interface KAFileStreamLineReader : NSObject <KALineReader>

- (instancetype)initWithFileURL:(NSURL *)URL;

@end
