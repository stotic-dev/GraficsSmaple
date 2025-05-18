//
//  MotionRepository.swift
//  MetalSample
//
//  Created by 佐藤汰一 on 2025/05/16.
//

import CoreMotion
import SwiftUI

struct MotionRepository {
    let isAvailable: () -> Bool
    let didUpdate: (@escaping (Result<MotionDeviceModel, Error>) -> Void) -> Void
    let stop: () -> Void
}

extension MotionRepository: EnvironmentKey {
    private static let motionManager = CMMotionManager()
    
    static var defaultValue: MotionRepository = .init {
        return motionManager.isAccelerometerAvailable
    } didUpdate: { handler in
        motionManager.accelerometerUpdateInterval = 0.05
        motionManager.startAccelerometerUpdates(to: .main) { data, error in
            if let error {
                handler(.failure(error))
                return
            }
            
            guard let data else { return }
            let model = MotionDeviceModel(x: data.acceleration.x,
                                          y: data.acceleration.y)
            handler(.success(model))
        }
    } stop: {
        motionManager.stopAccelerometerUpdates()
    }
}

extension EnvironmentValues {
    var motionRepository: MotionRepository {
        get{ self[MotionRepository.self] }
        set{ self[MotionRepository.self] = newValue }
    }
}
