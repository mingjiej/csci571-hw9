//
//  bridge.h
//  CS571 HW9
//
//  Created by User on 11/23/15.
//  Copyright © 2015 User. All rights reserved.
//
#import <AFNetworking/AFNetworking.h>
#import <Aeris/Aeris.h>
#import <AerisUI/AerisUI.h>
#import <AerisMap/AerisMap.h>
#import <AerisMap/AWFMapGlobals.h>
#import <AerisMap/AWFCoordinateBounds.h>
#import <AerisMap/AWFOverlayMetadata.h>
#import <AerisMap/AWFLayerType.h>
#import <AerisMap/AWFWeatherMap.h>
#import <AerisMap/AWFWeatherMapConfig.h>
#import <AerisMap/AWFWeatherMapDelegate.h>
#import <AerisMap/AWFMapStrategy.h>

#import <AerisMap/AWFAppleMapStrategy.h>
#import <AerisMap/AWFMKImageDataLayer.h>
#import <AerisMap/AWFMKTileDataLayer.h>

#import <AerisMap/AWFDataLayer.h>
#import <AerisMap/AWFImageDataLayer.h>
#import <AerisMap/AWFPointDataLayer.h>
#import <AerisMap/AWFPolygonDataLayer.h>
#import <AerisMap/AWFTileDataLayer.h>
#import <AerisMap/AWFTileOverlayView.h>

#import <AerisMap/AWFMultiShapeOverlay.h>
#import <AerisMap/AWFAnnotation.h>
#import <AerisMap/AWFPolygon.h>
#import <AerisMap/AWFPolyline.h>
#import <AerisMap/AWFStyledMapItem.h>
#import <AerisMap/AWFStyledAnnotation.h>

#import <AerisMap/AWFGroupIdentifier.h>
#import <AerisMap/AWFMapItemStyle.h>
#import <AerisMap/AWFAnnotationStyle.h>
#import <AerisMap/AWFPolygonStyle.h>

#import <AerisMap/AWFAnimation.h>
#import <AerisMap/AWFAnimationTimeline.h>
#import <AerisMap/AWFImageAnimation.h>
#import <AerisMap/AWFPointDataAnimation.h>
#import <AerisMap/AWFAnimatableOverlay.h>

#import <AerisMap/AWFLegendStyle.h>
#import <AerisMap/AWFBarLegendStyle.h>
#import <AerisMap/AWFDataLegendStyle.h>
#import <AerisMap/AWFRadarLegendStyle.h>

#import <AerisMap/AWFTimelineView.h>
#import <AerisMap/AWFBasicControlView.h>
#import <AerisMap/AWFLegendView.h>
#import <AerisMap/AWFWeatherMapLegendView.h>
#import <AerisMap/AWFObservationCalloutContentView.h>

#import <AerisMap/AWFWeatherMapViewController.h>
#import <AerisMap/AWFMapOptionsViewController.h>
#import <AerisMap/AWFTableSection.h>
#import <AerisMap/AWFTableSectionRow.h>

#import <AerisMap/AWFMKAnnotationView.h>

#import <AerisMap/MKMapView+AerisMap.h>
#import <Aeris/AerisEngine.h>
#import <Aeris/AerisAPIClient.h>

#import <Aeris/AWFAccessPermissions.h>
#import <Aeris/AWFGlobals.h>
#import <Aeris/AWFLog.h>
#import <Aeris/AWFNetworkActivityIndicatorManager.h>
#import <Aeris/AWFObjectLoader.h>
#import <Aeris/AWFObject.h>
#import <Aeris/AWFGeographicObject.h>
#import <Aeris/AWFRequestOptions.h>
#import <Aeris/AWFRequestFilter.h>
#import <Aeris/AWFRequestQuery.h>
#import <Aeris/AWFGeoPolygon.h>
#import <Aeris/AWFRangeSummary.h>
#import <Aeris/AWFLocationManager.h>
#import <Aeris/AWFWeatherDataType.h>
#import <Aeris/AWFMeasurement.h>
#import <Aeris/AWFForecastModel.h>

#import <Aeris/AWFPlacesLoader.h>
#import <Aeris/AWFVenuesLoader.h>
#import <Aeris/AWFObservationsLoader.h>
#import <Aeris/AWFForecastsLoader.h>
#import <Aeris/AWFAdvisoriesLoader.h>
#import <Aeris/AWFSunMoonLoader.h>
#import <Aeris/AWFMoonPhasesLoader.h>
#import <Aeris/AWFNormalsLoader.h>
#import <Aeris/AWFRecordsLoader.h>
#import <Aeris/AWFEarthquakesLoader.h>
#import <Aeris/AWFStormReportsLoader.h>
#import <Aeris/AWFLightningStrikesLoader.h>
#import <Aeris/AWFStormCellsLoader.h>
#import <Aeris/AWFFiresLoader.h>
#import <Aeris/AWFTidesLoader.h>
#import <Aeris/AWFActivitiesLoader.h>
#import <Aeris/AWFIndicesLoader.h>
#import <Aeris/AWFThreatsLoader.h>
#import <Aeris/AWFPhrasesLoader.h>
#import <Aeris/AWFConvectiveLoader.h>
#import <Aeris/AWFDroughtLoader.h>
#import <Aeris/AWFBatchLoader.h>

#import <Aeris/AWFPlace.h>
#import <Aeris/AWFRelativeTo.h>
#import <Aeris/AWFVenue.h>
#import <Aeris/AWFObservation.h>
#import <Aeris/AWFObservationSummary.h>
#import <Aeris/AWFForecast.h>
#import <Aeris/AWFAdvisory.h>
#import <Aeris/AWFSunMoon.h>
#import <Aeris/AWFMoonPhase.h>
#import <Aeris/AWFNormal.h>
#import <Aeris/AWFNormalStation.h>
#import <Aeris/AWFRecord.h>
#import <Aeris/AWFEarthquake.h>
#import <Aeris/AWFStormReport.h>
#import <Aeris/AWFStormReportSummary.h>
#import <Aeris/AWFLightningStrike.h>
#import <Aeris/AWFStormCell.h>
#import <Aeris/AWFStormCellSummary.h>
#import <Aeris/AWFFire.h>
#import <Aeris/AWFFireOutlook.h>
#import <Aeris/AWFTide.h>
#import <Aeris/AWFTideStation.h>
#import <Aeris/AWFActivity.h>
#import <Aeris/AWFIndexPeriod.h>
#import <Aeris/AWFIndex.h>
#import <Aeris/AWFThreat.h>
#import <Aeris/AWFPhrase.h>
#import <Aeris/AWFStormThreat.h>
#import <Aeris/AWFConvectiveOutlook.h>
#import <Aeris/AWFDroughtIndex.h>

#import <Aeris/NSBundle+Aeris.h>
#import <Aeris/AWFObject+AutoCoding.h>
#import <Aeris/CLLocation+Aeris.h>
#import <Aeris/NSDate+Aeris.h>
#import <Aeris/NSDictionary+Aeris.h>
#import <Aeris/NSString+Aeris.h>
#import <Aeris/NSNumber+Aeris.h>
#import <Aeris/NSObject+Aeris.h>
#import <Aeris/NSArray+Aeris.h>
#import <Aeris/UIDevice+Aeris.h>
#import <AerisUI/AWFUIGlobals.h>
#import <AerisUI/AWFCascadingStyle.h>
#import <AerisUI/AWFAdvisoryStyle.h>
#import <AerisUI/AWFLegacyStyle.h>
#import <AerisUI/AWFTextStyleSpec.h>
#import <AerisUI/AWFStyledView.h>
#import <AerisUI/AWFWeatherView.h>
#import <AerisUI/AWFWeatherHeaderView.h>

#import <AerisUI/AWFForecastDetailView.h>
#import <AerisUI/AWFForecast24HourView.h>
#import <AerisUI/AWFForecastRowBasicView.h>
#import <AerisUI/AWFHourlyBasicView.h>
#import <AerisUI/AWFObservationView.h>
#import <AerisUI/AWFObservationAdvisoriesView.h>
#import <AerisUI/AWFObservationRowBasicView.h>
#import <AerisUI/AWFObservationRowCityView.h>
#import <AerisUI/AWFAdvisoryDetailView.h>
#import <AerisUI/AWFDailySummaryView.h>

#import <AerisUI/AWFCollectionViewHourlyBasicCell.h>
#import <AerisUI/AWFCollectionViewForecastRowCell.h>
#import <AerisUI/AWFCollectionViewObservationRowCell.h>
#import <AerisUI/AWFCollectionViewObservationRowCityCell.h>
#import <AerisUI/AWFCollectionViewForecast24HourCell.h>
#import <AerisUI/AWFCollectionViewDailySummaryCell.h>

#import <AerisUI/AWFGraphView.h>
#import <AerisUI/AWFGraphSeries.h>
#import <AerisUI/AWFSeriesItem.h>
#import <AerisUI/AWFSeriesPoint.h>
#import <AerisUI/AWFGraphRenderer.h>
#import <AerisUI/AWFLineGraphRenderer.h>
#import <AerisUI/AWFBarGraphRenderer.h>
#import <AerisUI/AWFGraphAxis.h>
#import <AerisUI/AWFGraphTimeAxis.h>
#import <AerisUI/AWFGraphCalloutView.h>

#import <AerisUI/AWFCalloutView.h>
#import <AerisUI/AWFCalloutContentView.h>
#import <AerisUI/AWFImage.h>
#import <AerisUI/AWFIconSet.h>
#import <AerisUI/AWFGeometry.h>
#import <AerisUI/AWFDrawing.h>
#import <AerisUI/AWFEasing.h>
#import <AerisUI/AWFArcLayer.h>
#import <AerisUI/AWFCircularProgressView.h>
#import <AerisUI/AWFEdgeSwipeGestureRecognizer.h>

#import <AerisUI/CAKeyframeAnimation+AerisUI.h>
#import <AerisUI/CALayer+AerisUI.h>
#import <AerisUI/UIColor+AerisUI.h>
#import <AerisUI/UIImage+AerisUI.h>
#import <AerisUI/UIView+AerisUI.h>
#import <AerisUI/UIBezierPath+AerisUI.h>
#ifndef bridge_h
#define bridge_h


#endif /* bridge_h */
