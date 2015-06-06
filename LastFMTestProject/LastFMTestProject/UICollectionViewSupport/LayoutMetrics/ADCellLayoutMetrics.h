
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ADCellLayoutMetrics : NSObject

@property (nonatomic, assign, readonly) Class cellClass;
@property (nonatomic, strong, readonly) NSString *cellIdentifier;
@property (nonatomic, assign, readonly, getter=shouldUseNib) BOOL useNib;

- (instancetype)initWithClass:(Class) cellClass
               cellIdentifier:(NSString *) cellIdentifier
                       useNib:(BOOL) useNib;

- (void) registerWithCollectionView:(UICollectionView *) collectionView;

@end
