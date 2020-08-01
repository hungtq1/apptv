/// Flex Digital Health CONFIDENTIAL
/// Copyright (c) 2017-2018 Flex Digital Health, All Rights Reserved.
///
/// NOTICE:  All information contained herein is, and remains the property of Flex Digital Health. The intellectual and technical concepts contained
/// herein are proprietary to Flex Digital Health and may be covered by U.S. and Foreign Patents, patents in process, and are protected by trade secret or copyright law.
/// Dissemination of this information or reproduction of this material is strictly forbidden unless prior written permission is obtained
/// from Flex Digital Health.  Access to the source code contained herein is hereby forbidden to anyone except current Flex Digital Health employees, managers or contractors who have executed
/// Confidentiality and Non-disclosure agreements explicitly covering such access.
///
/// The copyright notice above does not evidence any actual or intended publication or disclosure  of  this source code, which includes
/// information that is confidential and/or proprietary, and is a trade secret, of  Flex Digital Health Incorporated.   ANY REPRODUCTION, MODIFICATION, DISTRIBUTION, PUBLIC  PERFORMANCE,
/// OR PUBLIC DISPLAY OF OR THROUGH USE  OF THIS  SOURCE CODE  WITHOUT  THE EXPRESS WRITTEN CONSENT OF COMPANY IS STRICTLY PROHIBITED, AND IN VIOLATION OF APPLICABLE
/// LAWS AND INTERNATIONAL TREATIES.  THE RECEIPT OR POSSESSION OF  THIS SOURCE CODE AND/OR RELATED INFORMATION DOES NOT CONVEY OR IMPLY ANY RIGHTS
/// TO REPRODUCE, DISCLOSE OR DISTRIBUTE ITS CONTENTS, OR TO MANUFACTURE, USE, OR SELL ANYTHING THAT IT  MAY DESCRIBE, IN WHOLE OR IN PART.

#import <UIKit/UIKit.h>

@interface ISMessagesHelper : NSObject

+ (ISMessagesHelper *)share;
@property (assign, nonatomic) BOOL isFirstLoad;

@end
