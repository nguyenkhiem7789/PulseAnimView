//
//  PulseAnimView.swift
//  FBSnapshotTestCase
//
//  Created by Nguyen on 4/18/20.
//

import UIKit

@IBDesignable
public class PulseAnimView: UIView {

    private var pulseLayer = CAShapeLayer()
    private var animationGroup = CAAnimationGroup()

    private var animDuration: TimeInterval = 0.7
    private var radius: CGFloat = 200
    private var numberOfPluses: Float = Float.infinity
    private var parentView: UIView? = nil

    private var circlePulseRadius: CGFloat = 0.0

    @IBInspectable
    public var pulseColor: UIColor = UIColor.white {
        didSet {
            pulseLayer.fillColor = pulseColor.cgColor
        }
    }

    @IBInspectable var pulseRadius: CGFloat = 0.0 {
        didSet {
            self.circlePulseRadius = pulseRadius
        }
    }

    @IBInspectable var circleBorder: Bool = false {
        didSet {
            self.layer.cornerRadius = frame.width/2
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        createPulseLayer()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createPulseLayer()
    }

    ///to set pulse layer below other view
    public func about(view: UIView) {
        self.parentView = view
    }

    func createPulseLayer() {
        self.clipsToBounds = true
        ///not use masksToBounds
//        self.layer.masksToBounds = true
        let centerPoint = CGPoint(x: self.frame.size.width / 2.0, y: self.frame.size.height / 2.0)
        var circlePath: UIBezierPath? = nil
        if circlePulseRadius > 0 {
            circlePath = UIBezierPath(arcCenter: centerPoint, radius: circlePulseRadius, startAngle: CGFloat(-(0.5 * Double.pi)), endAngle: CGFloat(1.5 * Double.pi), clockwise: true)
        } else {
            circlePath = UIBezierPath(arcCenter: centerPoint, radius: frame.size.width, startAngle: CGFloat(-(0.5 * Double.pi)), endAngle: CGFloat(1.5 * Double.pi), clockwise: true)
        }
        createGroupAnim()
        pulseLayer.frame = layer.bounds
        pulseLayer.path = circlePath!.cgPath
        pulseLayer.opacity = 0
        pulseLayer.fillColor = pulseColor.cgColor
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        self.addGestureRecognizer(tapGesture)
    }

    @objc func handleTap(sender: UITapGestureRecognizer) {
        addPulseLayer()
    }

    func addPulseLayer() {
         pulseLayer.add(animationGroup, forKey: "pulse")
        if parentView == nil {
            self.layer.addSublayer(pulseLayer)
        } else {
            ///use insertSublayer you nedd set position for pulseLayer
            pulseLayer.position = layer.position
            self.parentView!.layer.insertSublayer(pulseLayer, below: layer)
        }
    }

    func createScaleAnim() -> CABasicAnimation {
        let scaleAnim = CABasicAnimation(keyPath: "transform.scale.xy")
        scaleAnim.fromValue = 0
        scaleAnim.toValue = 1
        scaleAnim.duration = animDuration
        return scaleAnim
    }

    func createOpacityAnim() -> CAKeyframeAnimation {
        let opacityAnim = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnim.values = [0.4, 0.8, 0]
        opacityAnim.keyTimes = [0, 0.2, 1]
        opacityAnim.duration = animDuration
        return opacityAnim
    }

    func createGroupAnim() {
        self.animationGroup.duration = animDuration
        self.animationGroup.repeatCount = 1
        self.animationGroup.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
        self.animationGroup.animations = [createScaleAnim(),  createOpacityAnim()]
    }
}
