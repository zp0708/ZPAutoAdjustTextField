//
//  CALayer+SLPopAddition.h
//  GlobalGuide
//
//  Created by 融通汇信 on 15/12/16.
//  Copyright © 2015年 Belle. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

extern NSString * const kSLLayerBackgroundColor;
extern NSString * const kSLLayerBounds;
extern NSString * const kSLLayerCornerRadius;
extern NSString * const kSLLayerBorderWidth;
extern NSString * const kSLLayerBorderColor;
extern NSString * const kSLLayerOpacity;
extern NSString * const kSLLayerPosition;
extern NSString * const kSLLayerPositionX;
extern NSString * const kSLLayerPositionY;
extern NSString * const kSLLayerRotation;
extern NSString * const kSLLayerRotationX;
extern NSString * const kSLLayerRotationY;
extern NSString * const kSLLayerScaleX;
extern NSString * const kSLLayerScaleXY;
extern NSString * const kSLLayerScaleY;
extern NSString * const kSLLayerSize;
extern NSString * const kSLLayerSubscaleXY;
extern NSString * const kSLLayerSubtranslationX;
extern NSString * const kSLLayerSubtranslationXY;
extern NSString * const kSLLayerSubtranslationY;
extern NSString * const kSLLayerSubtranslationZ;
extern NSString * const kSLLayerTranslationX;
extern NSString * const kSLLayerTranslationXY;
extern NSString * const kSLLayerTranslationY;
extern NSString * const kSLLayerTranslationZ;
extern NSString * const kSLLayerZPosition;
extern NSString * const kSLLayerShadowColor;
extern NSString * const kSLLayerShadowOffset;
extern NSString * const kSLLayerShadowOpacity;
extern NSString * const kSLLayerShadowRadius;

typedef void(^SLPopComplete)(id obj, BOOL finish);

typedef NS_ENUM(NSInteger, SharkeDirection){
    SharkeDirectionLeft = -1,
    SharkeDirectionRight = 1,
};

@interface CALayer (SLPopAddition)

// MARK: BASIC
/**
 *  Add an basic animation to the reciver.
 *
 *  @param propertyNamed The name of the animatable property.
 *  @param toValue       destination value
 *  @param bounce        The effective bounciness.
 *  @param speed         The effective speed.
 *  @param key           The 'key' may be any string such that only one animation per unique key is added per object.
 *  @param complete      Optional block called on animation completion.
 */

- (void)sl_basicWithName:(NSString *)propertyNamed to:(id)toValue duration:(CGFloat)duration key:(NSString *)key complete:(SLPopComplete)complete;

/**
 *  Add an basic animation to the reciver.
 *
 *  @param propertyNamed The name of the animatable property.
 *  @param fromeValue    original value
 *  @param toValue       destination value
 *  @param bounce        The effective bounciness.
 *  @param speed         The effective speed.
 *  @param key           The 'key' may be any string such that only one animation per unique key is added per object.
 *  @param complete      Optional block called on animation completion.
 */
- (void)sl_basicWithName:(NSString *)name from:(id)fromValue to:(id)toValue duration:(CGFloat)duration key:(NSString *)key complete:(SLPopComplete)complete;

// MARK: SPRING
/**
 *  Add an spring animation to the reciver.
 *
 *  @param propertyNamed The name of the animatable property.
 *  @param toValue       destination value
 *  @param bounce        The effective bounciness.
 *  @param speed         The effective speed.
 *  @param key           The 'key' may be any string such that only one animation per unique key is added per object.
 *  @param complete      Optional block called on animation completion.
 */

- (void)sl_springWithName:(NSString *)propertyNamed to:(id)toValue bounce:(CGFloat)bounce speed:(CGFloat)speed key:(NSString *)key complete:(SLPopComplete)complete;

/**
 *  Add an spring animation to the reciver.
 *
 *  @param propertyNamed The name of the animatable property.
 *  @param fromeValue    original value
 *  @param toValue       destination value
 *  @param bounce        The effective bounciness.
 *  @param speed         The effective speed.
 *  @param key           The 'key' may be any string such that only one animation per unique key is added per object.
 *  @param complete      Optional block called on animation completion.
 */
- (void)sl_springWithName:(NSString *)propertyNamed from:(id)fromValue to:(id)toValue bounce:(CGFloat)bounce speed:(CGFloat)speed key:(NSString *)key complete:(SLPopComplete)complete;

/**
 @abstract Remove all animations attached to the receiver.
 */
- (void)sl_removeAllAnimations;

- (void)shake;

- (void)shakeWithDirection:(SharkeDirection)direction;

@end
