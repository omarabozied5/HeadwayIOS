//
//  DetailScreen.swift
//  Headway
//
//  Created by omar abozeid on 29/01/2025.
//

import SwiftUI

struct DetailScreen: View {
    @State private var notifications = true
    @State private var seasonalPhotos = true
    let goalDate = "October 18, 2023"
    
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
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Profile Header
                Text("g_kumar")
                    .font(.title.bold())
                    .padding(.top)
                
                // Settings Section
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Notifications:")
                            .foregroundStyle(.secondary)
                        Text(notifications ? "On" : "Off")
                    }
                    
                    HStack {
                        Text("Seasonal Photos:")
                            .foregroundStyle(.secondary)
                        Text("⛄️")
                    }
                    
                    HStack {
                        Text("Goal Date:")
                            .foregroundStyle(.secondary)
                        Text(goalDate)
                    }
                }
                .padding(.vertical, 8)
                
                // Badges Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("Completed Badges")
                        .font(.title2.bold())
                    
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
                        .font(.title2.bold())
                    
                    HikeView(hike: sampleHike)
                        .background(Color(uiColor: .systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(radius: 2)
                }
                .padding(.vertical, 8)
            }
            .padding(.horizontal)
        }
        .background(Color(uiColor: .systemGroupedBackground))
    }
}

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
