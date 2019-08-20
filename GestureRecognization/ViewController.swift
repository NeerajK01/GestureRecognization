//
//  ViewController.swift
//  GestureRecognization
//
//  Created by Neeraj kumar on 21/06/19.
//  Copyright © 2019 prolifics. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func handlePan(_ recognizer: UIPanGestureRecognizer){
        guard let recognizerView = recognizer.view else{
            return
        }
        
        let translation = recognizer.translation(in: view)
        recognizerView.center.x += translation.x
        recognizerView.center.y += translation.y
        recognizer.setTranslation(.zero, in: view)
        
        guard recognizer.state == .ended else{
            return
        }
        
        let velocity = recognizer.velocity(in: view)
        let vectorToFinalPoint = CGPoint(x: velocity.x / 15, y: velocity.y / 15)
        let bounds = view.bounds.inset(by: view.safeAreaInsets)

        var finalPoint = recognizerView.center
        finalPoint.x += vectorToFinalPoint.x
        finalPoint.y += vectorToFinalPoint.y
        finalPoint.x = min(max(finalPoint.x, bounds.minX), bounds.maxX)
        finalPoint.y = min(max(finalPoint.y, bounds.minY), bounds.maxY)
        let vectorToFinalPointLength = (
            vectorToFinalPoint.x * vectorToFinalPoint.x
                + vectorToFinalPoint.y * vectorToFinalPoint.y
            ).squareRoot()

        UIView.animate(
            withDuration: TimeInterval(vectorToFinalPointLength / 1800),
            delay: 0,
            options: .curveEaseOut,
            animations: { recognizerView.center = finalPoint }
        )
        
    }
    
    @IBAction func handlePinch(_ recognizer: UIPinchGestureRecognizer){
        guard let recognizerView = recognizer.view else{
            return
        }
        recognizerView.transform = recognizerView.transform.scaledBy(x: recognizer.scale, y: recognizer.scale)
        recognizer.scale = 1
    }
    
    @IBAction func rotationPan(_ recognizer: UIRotationGestureRecognizer){
        guard  let recognizerView = recognizer.view else {
            return
        }
        recognizerView.transform = recognizerView.transform.rotated(by: recognizer.rotation)
        recognizer.rotation = 0
    }
}

