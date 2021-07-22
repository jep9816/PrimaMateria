//
//  XTRPreferencesInfoView.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 7/22/21.
//  Copyright © 2021 Jerry Porter. All rights reserved.
//

import SwiftUI
import Combine

enum LanguageCodes: String {
    
    case English = "en"
    case Spanish = "es"
    case Russian = "ru"
    case French = "fr"
    
    func code() -> String {
        return self.rawValue
    }
    
}

struct XTRPreferencesInfoView: View {
    
    @ObservedObject var webViewStateModel: XTRWebViewStateModel = XTRWebViewStateModel()
    private let imageNames = (1...72).map { String(format: "Globe%02d", $0) }
    @State private var showingAlert = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .bottom, spacing: 5) {
                Image("icon")
                
                Text("Xtrensa")
                    .font(Font.custom("Papyrus", size: 36.0))
                    .fontWeight(.regular)
                    .foregroundColor(.black)
                
                Spacer()
                
                Text(Bundle.main.appNameString!)
                    .font(Font.custom("Papyrus", size: 48.0))
                    .fontWeight(.regular)
                    .foregroundColor(.black)
                
                Spacer()
                
                VStack(spacing: 0) {
                    HStack(spacing: 5) {
                        Text(NSLocalizedString("version", comment: "Version") + ":")
                            .font(Font.custom("Papyrus", size: 18.0))
                            .fontWeight(.regular)
                            .foregroundColor(Color(XTRColorFactory.backgroundColor))
                            .frame(width: 100, height: 24, alignment: .trailing)
                        
                        Text(Bundle.main.appVersionString!)
                            .font(Font.custom("Papyrus", size: 18.0))
                            .fontWeight(.regular)
                            .foregroundColor(Color(XTRColorFactory.backgroundColor))
                            .frame(width: 60, height: 24, alignment: .leading)
                    }
                    
                    HStack(spacing: 5) {
                        Text(NSLocalizedString("copyright", comment: "Copyright") + ":")
                            .font(Font.custom("Papyrus", size: 18.0))
                            .fontWeight(.regular)
                            .foregroundColor(Color(XTRColorFactory.backgroundColor))
                            .frame(width: 100, height: 24, alignment: .trailing)
                        
                        Text(Bundle.main.copywriteString!)
                            .font(Font.custom("Papyrus", size: 18.0))
                            .fontWeight(.regular)
                            .foregroundColor(Color(XTRColorFactory.backgroundColor))
                            .frame(width: 60, height: 24, alignment: .leading)
                            .padding(5)
                    }
                }
            }
            .border(Color.black, width: 1)
            .background(Color(XTRColorFactory.tableViewCellBorderColor))
            
            HStack(spacing: 0) {
                Spacer()
                Text(NSLocalizedString("credits", comment: "Credits"))
                    .font(.system(size: 24, weight: .regular))
                    .foregroundColor(Color.white)
                
                Spacer()
                
                // swiftlint:disable multiple_closures_with_trailing_closure
                LoadingView()

                //Label("Globe", systemImage: "globe")
                //    .labelStyle(IconOnlyLabelStyle())
                //        .frame(width: 44, height: 44, alignment: .center)
                //}
                //.aspectRatio(contentMode: .fill)
                //.font(.system(size: 36, weight: .bold))
                
                .contextMenu(ContextMenu(menuItems: {
                    Text(NSLocalizedString("chooseLanguage", comment: ""))
                    
                    Button("🇺🇸 " + NSLocalizedString("english", comment: "English"), action: {
                        self.applyLanguage(code: .English)
                        showingAlert.toggle()
                    })
                    .disabled(XTRPropertiesStore.currentLanguageCode == "en")

                    Button("🇪🇸 " + NSLocalizedString("spanish", comment: "Spanish"), action: {
                        self.applyLanguage(code: .Spanish)
                        showingAlert.toggle()
                    })
                    .disabled(XTRPropertiesStore.currentLanguageCode == "es")

                    Button("🇷🇺 " + NSLocalizedString("russian", comment: "Russian"), action: {
                        self.applyLanguage(code: .Russian)
                        showingAlert.toggle()
                    })
                    .disabled(XTRPropertiesStore.currentLanguageCode == "ru")

                    Button("🇫🇷 " + NSLocalizedString("french", comment: "French"), action: {
                        self.applyLanguage(code: .French)
                        showingAlert.toggle()
                    })
                    .disabled(XTRPropertiesStore.currentLanguageCode == "fr")
                 }))
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(NSLocalizedString("languageChanged", comment: "Language Changed")), message: Text(NSLocalizedString("restartApp", comment: "Restart App")), dismissButton: .default(Text("OK")))
            }
            .padding(5)
            .border(Color.black, width: 1)
            .background(Color.gray)
            
            VStack(spacing: 0) {
                XTRLoadingView(isShowing: .constant(webViewStateModel.loading)) {
                    XTRWebView(url: URL(fileURLWithPath: creditsPath(documentName: XTRPreferencesViewConfig.creditsDocument)), webViewStateModel: self.webViewStateModel)
                }
            }
            .background(Color(XTRColorFactory.tableViewCellBorderColor))
            .border(Color(XTRColorFactory.backgroundColor), width: 2)
        }
    }
    
    func creditsPath(documentName: String) -> String {
        guard let path = Bundle.main.path(forResource: documentName, ofType: nil) else { return "" }
        return path
    }
    
    private func applyLanguage(code: LanguageCodes) {
        XTRPropertiesStore.currentLanguageCode = code.code()
        //LocaleManager.apply(locale: Locale(identifier: code.code()))
    }
    
}

struct XTRPreferencesInfoView_Previews: PreviewProvider {
    
    static var previews: some View {
        XTRPreferencesInfoView().previewLayout(.fixed(width: 1024, height: 768))
    }
    
}

class LoadingTimer {

    let publisher = Timer.publish(every: 0.1, on: .main, in: .default)
    private var timerCancellable: Cancellable?

    func start() {
        self.timerCancellable = publisher.connect()
    }

    func cancel() {
        self.timerCancellable?.cancel()
    }
}

struct LoadingView: View {

    @State private var index = 0

    private let images = (1...7).map { UIImage(named: String(format: "Globe%02d", $0))! }
    private var timer = LoadingTimer()

    var body: some View {

        return Image(uiImage: images[index])
            .resizable()
            .frame(width: 44, height: 44, alignment: .center)
            .onReceive(
                timer.publisher,
                perform: { _ in
                    self.index += 1
                    if self.index >= 7 { self.index = 0 }
                }
            )
            .onAppear { self.timer.start() }
            .onDisappear { self.timer.cancel() }
    }
}

public struct AnimatedImage: View {
    
    // MARK: - Properties
    @State private var image: Image?
    
    private let imagesNames: [String]
    private let templateImageName: String?
    private let interval: Double
    private let loop: Bool
    private let loopIndex: Int
    private let iterations: Int
    
    /// Create a AnimatedImage
    /// - Parameters:
    ///     - imagesNames: An Array of images names that will be shown.
    ///     - templateImageName: Name of the first image. If not provided, the default value will be used.
    ///     - interval: Time that each image will still shown.
    ///     - loop: Boolean that determines if the video will play on loop. If not provided, the default value false will be used.
    ///     - loopIndex: Where the video restarts when on loop. If not provided, the default value 0 will be used.
    ///     - iterations: If the video loops, how many times it will loop. For infinite loop just not use this parameter. If not provided, the default value infinite will be used.
    public init(_ images: [String],
                templateImageName: String? = nil,
                interval: Double,
                loop: Bool = false,
                loopIndex: Int = 0,
                iterations: Int = Int.max) {
        self.imagesNames = images
        self.templateImageName = templateImageName
        self.interval = interval
        self.loop = loop
        self.loopIndex = loopIndex
        self.iterations = iterations
    }
    
    public var body: some View {
        Group {
            image?
                .resizable()
                .scaledToFit()
        }.onAppear(perform: {
            self.animate()
        })
    }
    
    /// Create a video sensation
    ///
    /// Use this method to iterate through the images to look like a video
    private func animate() {
        var imageIndex: Int = 0
        var iterations: Int = 1
        var idle: Bool = false
        
        Timer.scheduledTimer(withTimeInterval: self.interval, repeats: true) { timer in
            if imageIndex < self.imagesNames.count {
                self.image = Image(self.imagesNames[imageIndex])
                imageIndex += 1
                
                if imageIndex == self.imagesNames.count && self.loop && iterations != self.iterations {
                    imageIndex = self.loopIndex
                    
                    if self.iterations != Int.max {
                        iterations += 1
                    }
                    
                    if !idle {
                        idle = true
                    }
                }
            }
            if !self.loop && idle && iterations == self.iterations {
                timer.invalidate()
            }
        }
    }
}

//for index in 1...72 {
//    let numValue =  String(format: "%02d", index)
//    let imageName = "Globe\(numValue).png"
//    animationImages.append(UIImage(named: imageName)!)
//}
