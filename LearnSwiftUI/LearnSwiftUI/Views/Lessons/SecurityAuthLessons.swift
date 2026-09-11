import AuthenticationServices
import SwiftUI

struct SecurityKeychainLessonView: View {
    @StateObject private var viewModel = KeychainLessonViewModel()
    var body: some View {
        List {
            Section("Credential lifecycle") {
                SecureField("Credential", text: $viewModel.token)
                HStack { Button("Save", action: viewModel.save); Button("Load", action: viewModel.load); Button("Logout", role: .destructive, action: viewModel.delete) }.buttonStyle(.bordered)
                Text(viewModel.status).foregroundStyle(.secondary)
                CodeBlock(code: "SecItemAdd(query as CFDictionary, nil)\nSecItemCopyMatching(query as CFDictionary, &result)\nSecItemDelete(query as CFDictionary)")
            }
            LessonDetailSection(details: LessonDetailsCatalog.credentialSecurity)
        }.navigationTitle("Credential Security").navigationBarTitleDisplayMode(.inline)
    }
}

struct CryptoKitLessonView: View {
    @StateObject private var viewModel = CryptoKitLessonViewModel()
    var body: some View {
        List {
            Section("Hash or encrypt") {
                TextField("Input", text: $viewModel.input)
                HStack { Button("SHA-256", action: viewModel.hash); Button("AES-GCM", action: viewModel.encrypt) }.buttonStyle(.borderedProminent)
                Text(viewModel.output).font(.caption.monospaced()).textSelection(.enabled)
                CodeBlock(code: "let digest = SHA256.hash(data: data)\nlet sealed = try AES.GCM.seal(data, using: key)")
            }
            LessonDetailSection(details: LessonDetailsCatalog.cryptoKit)
        }.navigationTitle("CryptoKit").navigationBarTitleDisplayMode(.inline)
    }
}

struct OAuthLessonView: View {
    @StateObject private var viewModel = OAuthLessonViewModel()
    var body: some View {
        List {
            Section("Authorization Code + PKCE") {
                Button("Generate PKCE values", action: viewModel.generate).buttonStyle(.borderedProminent)
                LabeledContent("Verifier") { Text(viewModel.verifier).lineLimit(2).font(.caption.monospaced()) }
                Text(viewModel.authorizationURL).font(.caption.monospaced()).textSelection(.enabled)
                CodeBlock(code: "ASWebAuthenticationSession(url: authorizationURL, callbackURLScheme: scheme) { callback, error in\n    // validate state, exchange code + verifier\n}")
            }
            LessonDetailSection(details: LessonDetailsCatalog.oauth)
        }.navigationTitle("OAuth & OIDC").navigationBarTitleDisplayMode(.inline)
    }
}

struct SignInWithAppleLessonView: View {
    @State private var status = "Not signed in"
    var body: some View {
        List {
            Section("Apple authorization") {
                SignInWithAppleButton(.signIn) { request in request.requestedScopes = [.fullName, .email] } onCompletion: { result in
                    switch result { case .success(let authorization): status = "Credential received: \(type(of: authorization.credential))"; case .failure(let error): status = error.localizedDescription }
                }.frame(height: 48).signInWithAppleButtonStyle(.black)
                Text(status).foregroundStyle(.secondary)
                Text("Running sign-in requires the Sign in with Apple capability and Apple Developer configuration.").font(.caption)
            }
            LessonDetailSection(details: LessonDetailsCatalog.signInApple)
        }.navigationTitle("Sign in with Apple").navigationBarTitleDisplayMode(.inline)
    }
}
