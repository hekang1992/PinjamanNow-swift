//
//  H5ViewController.swift
//  PinjamanNow
//
//  Created by Ethan Hayes on 2026/2/4.
//

import UIKit
import WebKit
import SnapKit
import StoreKit

class H5ViewController: BaseViewController {
    
    var pageUrl: String = ""
    
    private let locationService = LocationService()
    
    private let viewModel = AppViewModel()
    
    private lazy var webView: WKWebView = {
        let config = WKWebViewConfiguration()
        let userContent = WKUserContentController()
        
        userContent.add(self, name: "stigmatwise")
        userContent.add(self, name: "terraitor")
        userContent.add(self, name: "ters")
        userContent.add(self, name: "premenne")
        userContent.add(self, name: "horo")
        userContent.add(self, name: "studally")
        
        config.userContentController = userContent
        
        let web = WKWebView(frame: .zero, configuration: config)
        web.navigationDelegate = self
        web.uiDelegate = self
        web.allowsBackForwardNavigationGestures = true
        return web
    }()
    
    private lazy var progressView: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .default)
        progress.progress = 0
        progress.isHidden = true
        return progress
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        addObservers()
        loadIfNeeded()
    }
    
    @MainActor
    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
        webView.removeObserver(self, forKeyPath: "title")
    }
}

extension H5ViewController {
    
    private func setupUI() {
        view.addSubview(appHeadView)
        appHeadView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
        }
        
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(appHeadView.snp.bottom)
        }
        
        view.addSubview(progressView)
        progressView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(appHeadView.snp.bottom)
            make.height.equalTo(2)
        }
        
        appHeadView.backBlock = { [weak self] in
            guard let self = self else { return }
            if self.webView.canGoBack {
                self.webView.goBack()
            }else {
                self.toOrderListProductVc()
            }
        }
    }
}

extension H5ViewController {
    
    private func loadIfNeeded() {
        guard !pageUrl.isEmpty,
              let url = createRequestUrl(baseUrl: pageUrl) else { return }
        webView.load(URLRequest(url: url))
    }
}

extension H5ViewController {
    
    private func addObservers() {
        webView.addObserver(self,
                            forKeyPath: "estimatedProgress",
                            options: .new,
                            context: nil)
        
        webView.addObserver(self,
                            forKeyPath: "title",
                            options: .new,
                            context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        
        if keyPath == "estimatedProgress" {
            progressView.isHidden = webView.estimatedProgress >= 1
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)
        }
        
        if keyPath == "title" {
            appHeadView.nameLabel.text = webView.title
        }
    }
}

extension H5ViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView,
                 didStartProvisionalNavigation navigation: WKNavigation!) {
        progressView.isHidden = false
    }
    
    func webView(_ webView: WKWebView,
                 didFinish navigation: WKNavigation!) {
        progressView.isHidden = true
        progressView.progress = 0
    }
}

extension H5ViewController: WKUIDelegate {
    
    func createRequestUrl(baseUrl: String) -> URL? {
        let params = CommonParaManager.toJson()
       
        guard var components = URLComponents(string: baseUrl) else { return nil }
        
        var queryDict = [String: String]()
        
        components.queryItems?.forEach { queryDict[$0.name] = $0.value }
        
        params.forEach { queryDict[$0.key] = $0.value }
        
        components.queryItems = queryDict.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        return components.url
    }
    
}

// MARK: - H5 Call App
extension H5ViewController: WKScriptMessageHandler {
    
    func userContentController(_ userContentController: WKUserContentController,
                               didReceive message: WKScriptMessage) {
        
        switch message.name {
        case "stigmatwise":
            handleStigmatwise(message.body)
            
        case "terraitor":
            handleTerraitor(message.body)
            
        case "ters":
            handleTers()
            
        case "premenne":
            handlePremenne()
            
        case "horo":
            handleHoro(message.body)
            
        case "studally":
            handleStudally()
            
        default:
            break
        }
    }
}

private extension H5ViewController {
    
    func handleStigmatwise(_ body: Any) {
        let body = body as? [String] ?? []
        let productID = body.first ?? ""
        let orderID = body.last ?? ""
        
        locationService.success = { result in
            print("result====\(result)")
        }
        
        locationService.start()
        
        Task {
            try? await Task.sleep(nanoseconds: 3_000_000_000)
            await self.uploadInfo(to: productID, orderID: orderID)
        }
        
    }
    
    func handleTerraitor(_ body: Any) {
        guard let pageUrl = body as? String, !pageUrl.isEmpty else {
            return
        }
        
        switch true {
        case pageUrl.contains(scheme_url):
            DeepLinkProcessor.handleString(pageUrl, from: self)
            
        case pageUrl.contains("http"):
            self.goH5WebVcWith(to: pageUrl)
            
        default:
            break
        }
    }
    
    func handleTers() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func handlePremenne() {
        NotificationCenter.default.post(
            name: NSNotification.Name("changeRootViewController"),
            object: nil
        )
    }
    
    func handleHoro(_ body: Any) {
        guard let email = (body as? String)?
            .trimmingCharacters(in: .whitespacesAndNewlines),
              !email.isEmpty,
              let encodedBody = "Pinjaman Now: \(LoginManager.shared.getPhone())"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let emailURL = URL(string: "mailto:\(email)?body=\(encodedBody)"),
              UIApplication.shared.canOpenURL(emailURL) else {
            return
        }
        
        UIApplication.shared.open(emailURL)
    }
    
    func handleStudally() {
        guard #available(iOS 14.0, *),
              let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return
        }
        
        SKStoreReviewController.requestReview(in: windowScene)
    }
}

extension H5ViewController {
    
    private func uploadInfo(to productID: String, orderID: String) async {
        do {
            let paras = ["manu": productID,
                         "anemion": "9",
                         "canproof": orderID,
                         "armaneity": IDFVKeychainManager.shared.getIDFV(),
                         "vagaster": IDFVKeychainManager.shared.getIDFA(),
                         "fidel": UserDefaults.standard.object(forKey: "longitude") as? String ?? "",
                         "regionlet": UserDefaults.standard.object(forKey: "latitude") as? String ?? "",
                         "recentlyfaction": String(Int(Date().timeIntervalSince1970)),
                         "dogmatization": String(Int(Date().timeIntervalSince1970))]
            let _ = try await viewModel.uploadStudyInfo(with: paras)
        } catch {
            
        }
    }
    
}
