
//  DetailScreen.swift
//  Headway
//
//  Created by omar abozeid on 20/01/2025.
//
import SwiftUI

struct DetailScreen: View {
    @State private var notifications = true
    @State private var seasonalPhotos = true
    let goalDate = "October 18, 2023"
    @Environment(\.dismiss) private var dismiss
    
    private var sampleHike: Hike {
        Hike.sampleHike
    }
    
    // Refined gradient colors to match the design
    private let firstHikeColors = (
        start: Color(red: 255.0/255, green: 150.0/255, blue: 200.0/255),
        end: Color(red: 255.0/255, green: 180.0/255, blue: 140.0/255)
    )

    private let earthDayColors = (
        start: Color(red: 150.0/255, green: 255.0/255, blue: 150.0/255),
        end: Color(red: 180.0/255, green: 255.0/255, blue: 180.0/255)
    )

    private let tenthHikeColors = (
        start: Color(red: 220.0/255, green: 200.0/255, blue: 180.0/255),
        end: Color(red: 200.0/255, green: 200.0/255, blue: 180.0/255)
        )
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Profile Header
                    Text("g_kumar")
                        .font(.title)
                        .fontWeight(.medium)
                    
                    // Settings Section
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Notifications:")
                                .foregroundColor(.secondary)
                            Text("On")
                        }
                        
                        HStack {
                            Text("Seasonal Photos:")
                                .foregroundColor(.secondary)
                            Text("⛄️")
                        }
                        
                        HStack {
                            Text("Goal Date:")
                                .foregroundColor(.secondary)
                            Text(goalDate)
                        }
                    }
                    .font(.subheadline)
                    
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
                            
                        
                        CompactHikeView(hike: sampleHike)
                            
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

// CompactHikeView.swift
struct CompactHikeView: View {
    var hike: Hike
    @State private var showDetail = false
    
    var body: some View {
        VStack {
            HStack {
                HikeGraph(hike: hike, path: \.elevation)
                    .frame(width: 50, height: 30)
                
                VStack(alignment: .leading) {
                    Text(hike.name)
                        .font(.headline)
                    Text(hike.distanceText)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Button {
                    withAnimation {
                        showDetail.toggle()
                    }
                } label: {
                    Image(systemName: "chevron.right.circle")
                        .imageScale(.large)
                        .rotationEffect(.degrees(showDetail ? 90 : 0))
                        .padding()
                        .foregroundColor(.blue)
                }
            }
            .padding(.vertical, 8)
            .background(Color(.systemBackground))
            
            if showDetail {
                HikeDetail(hike: hike)
                    .transition(.moveAndFade)
            }
        }
    }
}

// BadgeView.swift
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
                    .scaleEffect(0.75) // Adjusted scale for the symbol
            }
            .frame(width: 80, height: 80) // Adjusted size to match design
            
            Text(name)
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}


