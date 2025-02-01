//  HomeViewModel.swift
//  Headway
//
//  Created by omar abozeid on 27/01/2025.

import Foundation

//@MainActor
//class HomeViewModel: ObservableObject {
//    @Published var featuredGIFs: [Gif] = []
//    @Published var categories: [GifCategory] = []
//    @Published var isLoading = false
//    @Published var errorMessage: String? = nil
//    
//    @Published var username: String {
//        didSet { saveUserName() }
//    }
//    
//    init() {
//        self.username = UserDefaults.standard.string(forKey: "name") ?? "John Doe"
//    }
//    
//    private func saveUserName() {
//        UserDefaults.standard.set(username, forKey: "name")
//    }
//    
//    func fetchTrendingGIFs(limit: Int = 10) async {
//        isLoading = true
//        let request = APIRouter.GetTrendingGIFs(limit: limit)
//        
//        do {
//            let response = try await NetworkManager.shared.sendRequestAsync(modelType: GifResponse.self, request)
//            self.featuredGIFs = response.results
//        } catch {
//            self.errorMessage = "Failed to fetch GIFs"
//        }
//        
//        isLoading = false
//    }
//}
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
            self.errorMessage = nil
        } catch {
            self.errorMessage = "Failed to fetch GIFs"
        }
        
        isLoading = false
    }
    
    func searchGIFs(query: String, limit: Int = 10) async {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            await fetchTrendingGIFs(limit: limit)
            return
        }
        
        isLoading = true
        let request = APIRouter.SearchGIFs(query: query, limit: limit)
        
        do {
            let response = try await NetworkManager.shared.sendRequestAsync(modelType: GifResponse.self, request)
            self.featuredGIFs = response.results
            self.errorMessage = nil
        } catch {
            self.errorMessage = "Failed to search GIFs"
        }
        
        isLoading = false
    }
}
