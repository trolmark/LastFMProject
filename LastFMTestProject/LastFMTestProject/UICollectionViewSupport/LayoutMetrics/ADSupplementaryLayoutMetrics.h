
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ADSupplementaryLayoutMetrics : NSObject

/// Optional reuse identifier. If not specified, this will be inferred from the class of the supplementary view.
@property (nonatomic, copy) NSString *reuseIdentifier;

// Should we register it from nib or class
@property (nonatomic, assign, getter=shouldUseNib) BOOL useNib;

/// The class to use when dequeuing an instance of this supplementary view
@property (nonatomic) Class supplementaryClass;

/// The height of the supplementary view. If set to 0, the view will be measured to determine its optimal height.
@property (nonatomic) CGFloat height;

- (instancetype)initWithClass:(Class) supplementaryClass
                   identifier:(NSString *) supplementaryIdentifier
                       useNib:(BOOL)useNib;


- (void) registerWithCollectionView:(UICollectionView *) collectionView supplementaryKind:(NSString *) kind;



@end
