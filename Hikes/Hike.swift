import Foundation

struct Hike: Codable, Hashable, Identifiable {
    var id: Int
    var name: String
    var distance: Double
    var difficulty: Int
    var observations: [Observation]
    
    static func == (lhs: Hike, rhs: Hike) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    struct Observation: Codable, Hashable {
        var distanceFromStart: Double
        var elevation: Range<Double>
        var pace: Range<Double>
        var heartRate: Range<Double>
        
        static func == (lhs: Observation, rhs: Observation) -> Bool {
            lhs.distanceFromStart == rhs.distanceFromStart
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(distanceFromStart)
        }
    }
    
    var distanceText: String {
        String(format: "%.1f km", distance)
    }
}

// Example extension to create sample data
extension Hike {
    static var sampleHike: Hike {
        Hike(
            id: 1,
            name: "Lonesome Ridge Trail",
            distance: 4.5,
            difficulty: 2,
            observations: [
                Observation(
                    distanceFromStart: 0,
                    elevation: 1000..<1500,
                    pace: 400..<600,
                    heartRate: 85..<95
                ),
                Observation(
                    distanceFromStart: 0.5,
                    elevation: 1200..<1800,
                    pace: 450..<650,
                    heartRate: 90..<100
                ),
                Observation(
                    distanceFromStart: 1.0,
                    elevation: 1400..<2000,
                    pace: 500..<700,
                    heartRate: 95..<105
                )
            ]
        )
    }
}
