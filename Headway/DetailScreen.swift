import SwiftUI

struct DetailScreen: View {
    @State private var notifications = true
    @State private var seasonalPhotos = true
    let goalDate = "October 18, 2023"
    @Environment(\.dismiss) private var dismiss
    
    // Sample data for demonstration
    private var sampleHike: Hike {
        Hike.sampleHike
    }
    
    // Badge gradient colors
    private let firstHikeColors = (start: Color(red: 239.0 / 255, green: 120.0 / 255, blue: 221.0 / 255),
                                 end: Color(red: 239.0 / 255, green: 172.0 / 255, blue: 120.0 / 255))
    private let earthDayColors = (start: Color.green, end: Color.mint)
    private let tenthHikeColors = (start: Color(red: 180.0 / 255, green: 120.0 / 255, blue: 140.0 / 255),
                                 end: Color(red: 150.0 / 255, green: 150.0 / 255, blue: 120.0 / 255))
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Profile Header
                    Text("g_kumar")
                        .font(.title)
                        .fontWeight(.semibold)
                    
                    // Settings Section
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Notifications:")
                            Text(notifications ? "On" : "Off")
                        }
                        
                        HStack {
                            Text("Seasonal Photos:")
                            Text("⛄️")
                        }
                        
                        HStack {
                            Text("Goal Date:")
                            Text(goalDate)
                        }
                    }
                    .foregroundColor(.primary)
                    
                    // Badges Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Completed Badges")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                BadgeView(name: "First Hike",
                                        gradientStart: firstHikeColors.start,
                                        gradientEnd: firstHikeColors.end)
                                
                                BadgeView(name: "Earth Day",
                                        gradientStart: earthDayColors.start,
                                        gradientEnd: earthDayColors.end)
                                
                                BadgeView(name: "Tenth Hike",
                                        gradientStart: tenthHikeColors.start,
                                        gradientEnd: tenthHikeColors.end)
                            }
                            .padding(.horizontal, 2)
                        }
                    }
                    .padding(.vertical, 8)
                    // Recent Hikes Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Recent Hikes")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        HikeView(hike: sampleHike)
                             // Set initial collapsed height
                    }
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button(action: {
                    dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    .foregroundColor(.blue)
                }
            )
        }
    }
}

// Keep your existing BadgeView implementation
struct BadgeView: View {
    let name: String
    let gradientStart: Color
    let gradientEnd: Color
    
    var body: some View {
        VStack {
            ZStack {
                BadgeBackground()
                    .overlay {
                        LinearGradient(
                            colors: [gradientStart, gradientEnd],
                            startPoint: UnitPoint(x: 0.5, y: 0),
                            endPoint: UnitPoint(x: 0.5, y: 0.6)
                        )
                        .mask {
                            BadgeBackground()
                        }
                    }
                
                Badge()
            }
            .frame(width: 100, height: 100)
            
            Text(name)
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}
