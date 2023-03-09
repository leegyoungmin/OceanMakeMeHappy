//
//  BeachPreviewView.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI

struct BeachPreviewView: View {
    private let beach: Beach
    
    init(beach: Beach) {
        self.beach = beach
    }
     
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            VStack(alignment: .leading, spacing: 16) {
                imageSection
                titleSection
            }
            
            VStack {
                learnMoreButton
                nextButton
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .offset(y: 65)
        )
        .cornerRadius(10)
    }
}

extension BeachPreviewView {
    private var imageSection: some View {
        ZStack {
            Image(systemName: "person")
                .resizable()
                .scaledToFill()
                .background(Color.accentColor)
                .frame(width: 100, height: 100)
                .cornerRadius(10)
        }
        .padding(6)
        .background(Color.white)
        .cornerRadius(10)
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(beach.name)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(beach.location.description)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var learnMoreButton: some View {
        Button {
            
        } label: {
            Text("더보기")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .background(Color.accentColor)
        .cornerRadius(10)
        .foregroundColor(.white)
    }
    
    private var nextButton: some View {
        Button {
            
        } label: {
            Text("다음")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .background(Color.accentColor.opacity(0.2))
        .cornerRadius(10)
        .foregroundColor(Color.accentColor)
    }
}
