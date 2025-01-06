//
//  ContentView.swift
//  BugTracking-Task
//
//  Created by Abdelhamid on 05/01/2025.
//

import SwiftUI

struct GoogleSignInView: View {
    
    @ObservedObject var viewModel: GoogleSignInViewModel

    init(viewModel: GoogleSignInViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(
                    destination: CreateBugView(),
                    isActive: Binding(
                        get: { viewModel.navigationState == .createBug },
                        set: { if !$0 { viewModel.navigationState = .none } }
                    )
                ) {
                    EmptyView()
                }

                VStack {
                    Spacer()

                    Text("Welcome to Bug Tracking App")
                        .font(.title)
                        .padding()
                                
                    if viewModel.isLoading {
                        ProgressView("Loading...")
                            .padding()
                    } else {
                        GoogleSignInButton(action: handleGoogleSignIn)
                            .padding(.horizontal, 40)
                    }

                    Spacer()
                }
                .padding()
            }
        }
    }

    private func handleGoogleSignIn() {
        Task {
            await viewModel.signIn()
        }
    }
}

#Preview {
    DependencyManager.createGoogleSignInView()
}

struct GoogleSignInButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text("Sign in with Google")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.black)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            )
        }
    }
}
