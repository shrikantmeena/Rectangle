//
//  CenterProminentlyCalculation.swift
//  Rectangle
//
//  Copyright © 2019 Ryan Hanson. All rights reserved.
//

import Foundation

class CenterMiddleCalculation: WindowCalculation {
    
    override func calculate(_ params: WindowCalculationParameters) -> WindowCalculationResult? {
        
        var screenFrame: CGRect?
        if !Defaults.alwaysAccountForStage.userEnabled {
            screenFrame = params.usableScreens.currentScreen.adjustedVisibleFrame(params.ignoreTodo, true)
        }
                
        let rectResult = calculateRect(params.asRectParams(visibleFrame: screenFrame))
        
        let resultingAction: WindowAction = rectResult.resultingAction ?? params.action

        return WindowCalculationResult(rect: rectResult.rect,
                                       screen: params.usableScreens.currentScreen,
                                       resultingAction: resultingAction,
                                       resultingScreenFrame: screenFrame)
    }
    
    override func calculateRect(_ params: RectCalculationParameters) -> RectResult {
        let rectResult = WindowCalculationFactory.centerCalculation.calculateRect(params)
        var rect = params.visibleFrameOfScreen
        
        // Resize
        rect.size.width = round(params.visibleFrameOfScreen.width - (params.visibleFrameOfScreen.width * 0.3))
        rect.size.height = round(params.visibleFrameOfScreen.height - (params.visibleFrameOfScreen.height * 0.2))

        // Center
        rect.origin.x = round((params.visibleFrameOfScreen.width - rect.width) / 2.0) + params.visibleFrameOfScreen.minX
        rect.origin.y = round((params.visibleFrameOfScreen.height - rect.height) / 2.0) + params.visibleFrameOfScreen.minY

        return RectResult(rect, resultingAction: rectResult.resultingAction)
    }

}

