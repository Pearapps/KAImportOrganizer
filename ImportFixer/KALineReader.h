//
//  KALineReader.h
//  ImportFixer
//
//  Created by Kenneth Parker Ackerson on 10/10/15.
//  Copyright © 2015 Kenneth Parker Ackerson. All rights reserved.
//

@protocol KALineReader

- (NSString *)readLine;

- (BOOL)hasAnotherLine;

@end
