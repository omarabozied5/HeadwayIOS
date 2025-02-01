//  HomeViewModel.swift
//  Headway
//
//  Created by omar abozeid on 27/01/2025.

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    @Published var featuredGIFs: [Gif] = []
    @Published var categories: [GifCategory] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    @Published var username: String {
        didSet { saveUserName() }
    }
    
    init() {
        self.username = UserDefaults.standard.string(forKey: "name") ?? "John Doe"
    }
    
    private func saveUserName() {
        UserDefaults.standard.set(username, forKey: "name")
    }
    
    func fetchTrendingGIFs(limit: Int = 10) async {
        isLoading = true
        let request = APIRouter.GetTrendingGIFs(limit: limit)
        
        do {
            let response = try await NetworkManager.shared.sendRequestAsync(modelType: GifResponse.self, request)
            self.featuredGIFs = response.results
        } catch {
            self.errorMessage = "Failed to fetch GIFs"
        }
        
        isLoading = false
    }
}
