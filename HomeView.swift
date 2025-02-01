import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @AppStorage("name") private var username: String = "John Doe"
    
    var body: some View {
        NavigationStack {
            VStack {
                // Welcome Message
                Text("Welcome, \(username)!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
                    .padding(.top, 20)
                
                // Error Message
                if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                }
                
                // GIFs Grid
                if !viewModel.featuredGIFs.isEmpty {
                    gifGridView
                        .padding()
                } else {
                    Text("Loading... ")
                        .foregroundColor(.gray)
                        .padding()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // Leading space to balance the layout
                ToolbarItem(placement: .navigationBarLeading) {
                    Spacer()
                        .frame(width: 40)  // Match the width of profile icon
                }
                
                // Centered Title
                ToolbarItem(placement: .principal) {
                    Text("Home")
                        .font(.headline)
                        .fontWeight(.semibold)
                }
                
                // Profile Icon
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ProfileScreen()) {
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 24))  // Consistent size
                            .foregroundColor(.blue)
                            .frame(width: 40)  
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .task {
                print("Fetching GIFs...")
                await viewModel.fetchTrendingGIFs()
            }
        }
    }
}

// MARK: - View Extensions
extension HomeView {
    var gifGridView: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))], spacing: 16) {
                ForEach(viewModel.featuredGIFs) { gif in
                    NavigationLink(destination: DetailScreen()) {
                        gifItemView(gif: gif)
                    }
                }
            }
        }
        .refreshable {
            await viewModel.fetchTrendingGIFs()
        }
    }
    
    func gifItemView(gif: Gif) -> some View {
        VStack {
            AsyncImage(url: URL(string: gif.media_formats.tinygif.url)) { image in
                image.resizable().scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 120, height: 120)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Text(gif.title ?? "GIF")
                .font(.caption)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
                .lineLimit(2)  // Limit to 2 lines for consistency
        }
        .frame(width: 120)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(radius: 3)
        )
    }
}
