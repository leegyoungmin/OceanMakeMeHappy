//
//  BeachPreviewView.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI

struct BeachPreviewView: View {
    @EnvironmentObject var mapViewModel: MapViewModel
    private let beach: Beach
    
    init(beach: Beach) {
        self.beach = beach
    }
     
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    imageSection
                    
                    Spacer()
                    
                    learnMoreButton
                        .offset(y: 20)
                }
                
                titleSection
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .offset(y: 65)
        )
        .cornerRadius(10)
        .onAppear {
            
        }
    }
}

struct BeachPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        BeachPreviewView(beach: Beach(num: 1, name: "협재", address: "", longitude: 126.23994220041192, latitude: 33.394285064566915))
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
            
            Text(beach.address)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var learnMoreButton: some View {
        Button {
            // TODO: - 사진 보러가는 기능 만들기
        } label: {
            Text("더보기")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .background(Color.accentColor)
        .cornerRadius(10)
        .foregroundColor(.white)
    }
}
