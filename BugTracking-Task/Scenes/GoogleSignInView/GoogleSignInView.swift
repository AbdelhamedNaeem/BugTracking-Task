//
//  ContentView.swift
//  BugTracking-Task
//
//  Created by Abdelhamid on 05/01/2025.
//

import SwiftUI

struct GoogleSignInView: View {
    
    @ObservedObject var viewModel: GoogleSignInViewModel
    @State private var isUserSignedIn: Bool = UserDefaultsManager().isUserSignedIn()
    let userDefaultManager: UserDefaultsManaging = UserDefaultsManager()
    @State private var sharedImage: UIImage? = nil

    init(viewModel: GoogleSignInViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(
                    destination: DependencyManager.createBugView(),
                    isActive: $viewModel.isSignedIn
                ) {
                    EmptyView()
                }

                VStack {
                    Spacer()

                    Text("Welcome \(userDefaultManager.loadUser()?.name ?? "") to Bug Tracking App")
                        .font(.title)
                        .padding()
                                
                    if viewModel.isLoading {
                        ProgressView("Loading...")
                            .padding()
                    } else {
                        if isUserSignedIn {
                            HStack {
                                Button(action: {
                                    viewModel.isSignedIn = true
                                    isUserSignedIn = true
                                }, label: {
                                    Text("Create Bug")
                                        .bold()
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                        .padding(.horizontal)
                                })
                                
                                Button(action: {
                                    userDefaultManager.removeUser()
                                    isUserSignedIn = false
                                }, label: {
                                    Text("Sign Out")
                                        .bold()
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.red)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                        .padding(.horizontal)
                                })

                            }
                            
                        }else {
                            GoogleSignInButton(action: handleGoogleSignIn)
                                .padding(.horizontal, 40)
                        }
                    }

                    Spacer()
                }
                .padding()
                .alert(isPresented: .constant(viewModel.errorMessage != nil)) {
                    Alert(
                        title: Text("Error"),
                        message: Text(viewModel.errorMessage ?? "An unknown error occurred"),
                        dismissButton: .default(Text("OK")) {
                            viewModel.errorMessage = nil
                        }
                    )
                }
            }
        }
        .onOpenURL { url in
            handleIncomingURL(url)
        }
    }

    private func handleGoogleSignIn() {
        Task {
            await viewModel.signIn()
            isUserSignedIn = true
        }
    }
    
    private func handleIncomingURL(_ url: URL) {
        if let imageData = try? Data(contentsOf: url),
           let image = UIImage(data: imageData) {
            sharedImage = image
            viewModel.isSignedIn = true
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
