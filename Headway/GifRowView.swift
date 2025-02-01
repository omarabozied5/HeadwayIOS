//
//  GifRowView.swift
//  Headway
//
//  Created by omar abozeid on 27/01/2025.
//

import SwiftUI

struct GifRowView: View {
    let gif: Gif // A single GIF object to display
    
    var body: some View {
        HStack {
            // Display the GIF thumbnail
            AsyncImage(url: URL(string: gif.media_formats.tinygif.url)) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 80, height: 80)
            .cornerRadius(8)
            
            // Display the GIF title
            Text(gif.title)
                .font(.headline)
        }
        .padding(.vertical, 8)
    }
}
