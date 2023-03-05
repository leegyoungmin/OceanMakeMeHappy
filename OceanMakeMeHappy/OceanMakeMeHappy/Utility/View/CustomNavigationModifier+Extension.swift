//
//  CustomNavigationModifier+Extension.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.
        

import SwiftUI

struct CustomNavigationBarModifier<Center, Left, Right>: ViewModifier where Center: View, Left: View, Right: View {
    let centerView: (() -> Center)?
    let leftView: (() -> Left)?
    let rightView: (() -> Right)?
    let barColor: Color
    
    init(
        centerView: (() -> Center)? = nil,
        leftView: (() -> Left)? = nil,
        rightView: (() -> Right)? = nil,
        barColor: Color = .clear
    ) {
        self.centerView = centerView
        self.leftView = leftView
        self.rightView = rightView
        self.barColor = barColor
    }
    
    func body(content: Content) -> some View {
        VStack {
            ZStack {
                HStack {
                    self.leftView?()
                    
                    Spacer()
                    
                    self.rightView?()
                }
                .frame(maxHeight: 25)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
                
                HStack {
                    Spacer()
                    
                    self.centerView?()
                    
                    Spacer()
                }
            }
            .padding(.horizontal, 5)
            .padding(.bottom, 5)
            .background(barColor.ignoresSafeArea(.all, edges: .top))
            
            content
        }
        .navigationBarHidden(true)
    }
}

extension View {
    func customNavigationBar<Center: View, Left: View, Right: View>(
        centerView: @escaping (() -> Center),
        leftView: @escaping (() -> Left),
        rightView: @escaping (() -> Right)
    ) -> some View {
        modifier(
            CustomNavigationBarModifier(centerView: centerView, leftView: leftView, rightView: rightView)
        )
    }
    
    func customNavigationBar<CenterView: View>(
        centerView: @escaping (() -> CenterView)
    ) -> some View {
        modifier(
            CustomNavigationBarModifier(
                centerView: centerView,
                leftView: {
                EmptyView()
            }, rightView: {
                EmptyView()
            })
        )
    }
    
    func customNavigationBar<LeftView: View> (
        leftView: @escaping (() -> LeftView)
    ) -> some View {
        modifier(
            CustomNavigationBarModifier(centerView: {
                EmptyView()
            }, leftView: leftView, rightView: {
                EmptyView()
            })
        )
    }
}
