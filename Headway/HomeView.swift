import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @AppStorage("name") private var username: String = "John Doe"
    @State private var searchText = ""
    @State private var isSearching = false
    
    var body: some View {
        NavigationStack {
            VStack {
                // Search Bar
                searchBar
                    .padding(.horizontal)
                
                // Welcome Message (only show when not searching)
                if !isSearching {
                    Text("Welcome, \(username)!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                        .padding(.top, 20)
                }
                
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
                    Text(isSearching ? "No results found" : "Loading...")
                        .foregroundColor(.gray)
                        .padding()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Spacer()
                        .frame(width: 40)
                }
                
                ToolbarItem(placement: .principal) {
                    Text("Home")
                        .font(.headline)
                        .fontWeight(.semibold)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ProfileScreen()) {
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.blue)
                            .frame(width: 40)
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .task {
                if searchText.isEmpty {
                    await viewModel.fetchTrendingGIFs()
                }
            }
        }
    }
}

// MARK: - View Extensions
extension HomeView {
    var searchBar: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("Search GIFs...", text: $searchText)
                    .autocorrectionDisabled()
                    .onSubmit {
                        Task {
                            isSearching = true
                            await viewModel.searchGIFs(query: searchText)
                        }
                    }
                
                if !searchText.isEmpty {
                    Button(action: {
                        searchText = ""
                        isSearching = false
                        Task {
                            await viewModel.fetchTrendingGIFs()
                        }
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(8)
            .background(Color(.systemGray6))
            .cornerRadius(10)
        }
    }
    
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
            if searchText.isEmpty {
                await viewModel.fetchTrendingGIFs()
            } else {
                await viewModel.searchGIFs(query: searchText)
            }
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
            
            Text(gif.title)
                .font(.caption)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
                .lineLimit(2)
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
