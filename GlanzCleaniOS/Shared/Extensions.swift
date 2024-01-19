//
//  Extensions.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 31.12.2023.
//

import Foundation
import SwiftUI
import UIKit

extension Binding {
    func onUpdate(_ closure: @escaping () -> Void) -> Binding<Value> {
        Binding(get: {
            wrappedValue
        }, set: { newValue in
            wrappedValue = newValue
            closure()
        })
    }
}

// Used for validation
extension String {
    /// Allows only `a-zA-Z0-9`
    public var lettersOnly: Bool {
        guard !isEmpty else {
            return false
        }
        let allowed = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let characterSet = CharacterSet(charactersIn: allowed)
        guard rangeOfCharacter(from: characterSet.inverted) == nil else {
            return false
        }
        return true
    }
}

// Used for exporting pdf
extension View {
    // MARK: Extracting View's height and width with Hosting Controller and ScrollView
    func convertToScrollView<Content: View>(@ViewBuilder content: @escaping () -> Content) -> UIScrollView {
        let scrollView = UIScrollView()
        
        // MARK: Converting SwiftUI view to uikit view
        let hostingController = UIHostingController(rootView: content()).view!
        hostingController.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: Constraints
        let constraints = [
            hostingController.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            hostingController.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            hostingController.topAnchor.constraint(equalTo: scrollView.topAnchor),
            hostingController.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            // Width anchro
            hostingController.widthAnchor.constraint(equalToConstant: screenBounds().width)
        ]
        scrollView.addSubview(hostingController)
        scrollView.addConstraints(constraints)
        scrollView.layoutIfNeeded()
        return scrollView
    }
    
    // MARK: Export to PDF
    func exportPDF<Content: View>(@ViewBuilder content: @escaping () -> Content, completion: @escaping(Bool, URL?)->()){
     
        
        // MARK: Temp URL
        let documentDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        
        // MARK: To generate new file whenever its generated
        let outputFileURL = documentDirectory.appendingPathComponent("invoice\(UUID().uuidString).pdf")
        
        // MARK: PDF View
        let pdfView = convertToScrollView {
            content()
        }
        pdfView.tag = 1009
        let size = pdfView.contentSize
        // Removing safe area top value
        pdfView.frame = CGRect(x: 0, y: getSafeArea().top, width: size.width, height: size.height)
        //  Attaching to root view and rendering ther PDF
        getRootController().view.insertSubview(pdfView, at: 0)
        //  Rendering PDF
        let renderer = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width:size.width, height: size.height))
        do {
            try renderer.writePDF(to: outputFileURL) { context in
                context.beginPage()
                pdfView.layer.render(in: context.cgContext)
            }
            completion(true, outputFileURL)
        } catch {
            completion(false, nil)
            print(error.localizedDescription)
        }
        // MARK: Removing the added View
        getRootController().view.subviews.forEach { view in
            if view.tag == 1009 {
                print("Removed from ")
                view.removeFromSuperview()
            }
        }
    }
    
    func getRootController() -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        return root
    }
    
    
    func screenBounds() -> CGRect {
        return UIScreen.main.bounds
    }
    
    func getSafeArea() -> UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else {
            return .zero
        }
        return safeArea
    }
}

extension Date {
    func toString() -> String {
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "dd MMM yyyy"
          return dateFormatter.string(from: self)
      }
}
