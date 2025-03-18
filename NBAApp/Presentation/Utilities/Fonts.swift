//
//  Fonts.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 17/03/25.
//

import Foundation
import SwiftUI

enum DSFontWeight: String {
    case regular
    case medium
    case semibold
    case bold
}

enum DSFontStyle: String {
    case h1
    case h2
    case h3
    case h4
    case h5
    case body1
    case body2
    case caption
    case overline
    case footnote
}

extension Fonts {
    static subscript(style: DSFontStyle, weight: DSFontWeight) -> Font {
        let font: UIFont = get(style, weight)
        return Font.custom(font.fontName, size: font.pointSize)
    }
}

protocol DSFont {
    var regular400: UIFont { get }
    var medium500: UIFont { get }
    var semibold600: UIFont { get }
    var bold700: UIFont { get }
}

struct Fonts {
    private static let regular: UIFont = UIFont(name: "Poppins-Regular", size: 14.0) ?? UIFont.systemFont(ofSize: 14.0)
    private static let medium: UIFont = UIFont(name: "Poppins-Medium", size: 14.0) ?? UIFont.systemFont(ofSize: 14.0)
    private static let semibold: UIFont = UIFont(name: "Poppins-SemiBold", size: 14.0) ?? UIFont.systemFont(ofSize: 14.0)
    private static let bold: UIFont = UIFont(name: "Poppins-Bold", size: 14.0) ?? UIFont.systemFont(ofSize: 14.0)

    struct H1: DSFont {
        private static let fontSize: Double = 28.0
        let regular400: UIFont = UIFontMetrics(forTextStyle: .headline).scaledFont(for: Fonts.regular.withSize(fontSize))
        let medium500: UIFont = UIFontMetrics(forTextStyle: .headline).scaledFont(for: Fonts.medium.withSize(fontSize))
        let semibold600: UIFont = UIFontMetrics(forTextStyle: .headline).scaledFont(for: Fonts.semibold.withSize(fontSize))
        let bold700: UIFont = UIFontMetrics(forTextStyle: .headline).scaledFont(for: Fonts.bold.withSize(fontSize))
    }
    static let h1: Fonts.H1 = H1()

    struct H2: DSFont {
        private static let fontSize: Double = 24.0
        let regular400: UIFont = UIFontMetrics(forTextStyle: .subheadline).scaledFont(for: Fonts.regular.withSize(fontSize))
        let medium500: UIFont = UIFontMetrics(forTextStyle: .subheadline).scaledFont(for: Fonts.medium.withSize(fontSize))
        let semibold600: UIFont = UIFontMetrics(forTextStyle: .subheadline).scaledFont(for: Fonts.semibold.withSize(fontSize))
        let bold700: UIFont = UIFontMetrics(forTextStyle: .subheadline).scaledFont(for: Fonts.bold.withSize(fontSize))
    }
    static let h2: Fonts.H2 = H2()

    struct H3: DSFont {
        private static let fontSize: Double = 22.0
        let regular400: UIFont = UIFontMetrics(forTextStyle: .title1).scaledFont(for: Fonts.regular.withSize(fontSize))
        let medium500: UIFont = UIFontMetrics(forTextStyle: .title1).scaledFont(for: Fonts.medium.withSize(fontSize))
        let semibold600: UIFont = UIFontMetrics(forTextStyle: .title1).scaledFont(for: Fonts.semibold.withSize(fontSize))
        let bold700: UIFont = UIFontMetrics(forTextStyle: .title1).scaledFont(for: Fonts.bold.withSize(fontSize))
    }
    static let h3: Fonts.H3 = H3()

    struct H4: DSFont {
        private static let fontSize: Double = 20.0
        let regular400: UIFont = UIFontMetrics(forTextStyle: .title2).scaledFont(for: Fonts.regular.withSize(fontSize))
        let medium500: UIFont = UIFontMetrics(forTextStyle: .title2).scaledFont(for: Fonts.medium.withSize(fontSize))
        let semibold600: UIFont = UIFontMetrics(forTextStyle: .title2).scaledFont(for: Fonts.semibold.withSize(fontSize))
        let bold700: UIFont = UIFontMetrics(forTextStyle: .title2).scaledFont(for: Fonts.bold.withSize(fontSize))
    }
    static let h4: Fonts.H4 = H4()

    struct H5: DSFont {
        private static let fontSize: Double = 18.0
        let regular400: UIFont = UIFontMetrics(forTextStyle: .title3).scaledFont(for: Fonts.regular.withSize(fontSize))
        let medium500: UIFont = UIFontMetrics(forTextStyle: .title3).scaledFont(for: Fonts.medium.withSize(fontSize))
        let semibold600: UIFont = UIFontMetrics(forTextStyle: .title3).scaledFont(for: Fonts.semibold.withSize(fontSize))
        let bold700: UIFont = UIFontMetrics(forTextStyle: .title3).scaledFont(for: Fonts.bold.withSize(fontSize))
    }
    static let h5: Fonts.H5 = H5()

    struct Body1: DSFont {
        private static let fontSize: Double = 16.0
        let regular400: UIFont = UIFontMetrics(forTextStyle: .body).scaledFont(for: Fonts.regular.withSize(fontSize))
        let medium500: UIFont = UIFontMetrics(forTextStyle: .body).scaledFont(for: Fonts.medium.withSize(fontSize))
        let semibold600: UIFont = UIFontMetrics(forTextStyle: .body).scaledFont(for: Fonts.semibold.withSize(fontSize))
        let bold700: UIFont = UIFontMetrics(forTextStyle: .body).scaledFont(for: Fonts.bold.withSize(fontSize))
    }
    static let body1: Fonts.Body1 = Body1()

    struct Body2: DSFont {
        private static let fontSize: Double = 14.0
        let regular400: UIFont = UIFontMetrics(forTextStyle: .body).scaledFont(for: Fonts.regular.withSize(fontSize))
        let medium500: UIFont = UIFontMetrics(forTextStyle: .body).scaledFont(for: Fonts.medium.withSize(fontSize))
        let semibold600: UIFont = UIFontMetrics(forTextStyle: .body).scaledFont(for: Fonts.semibold.withSize(fontSize))
        let bold700: UIFont = UIFontMetrics(forTextStyle: .body).scaledFont(for: Fonts.bold.withSize(fontSize))
    }
    static let body2: Fonts.Body2 = Body2()
    static let button: UIFont = Fonts.regular.withSize(16.0)

    struct Overline: DSFont {
        private static let fontSize: Double = 12.0
        let regular400: UIFont = UIFontMetrics(forTextStyle: .callout).scaledFont(for: Fonts.regular.withSize(fontSize))
        let medium500: UIFont = UIFontMetrics(forTextStyle: .callout).scaledFont(for: Fonts.medium.withSize(fontSize))
        let semibold600: UIFont = UIFontMetrics(forTextStyle: .callout).scaledFont(for: Fonts.semibold.withSize(fontSize))
        let bold700: UIFont = UIFontMetrics(forTextStyle: .callout).scaledFont(for: Fonts.bold.withSize(fontSize))
    }
    static let overline: Fonts.Overline = Overline()

    struct Caption: DSFont {
        private static let fontSize: Double = 10.0
        let regular400: UIFont = UIFontMetrics(forTextStyle: .caption1).scaledFont(for: Fonts.regular.withSize(fontSize))
        let medium500: UIFont = UIFontMetrics(forTextStyle: .caption1).scaledFont(for: Fonts.medium.withSize(fontSize))
        let semibold600: UIFont = UIFontMetrics(forTextStyle: .caption1).scaledFont(for: Fonts.semibold.withSize(fontSize))
        let bold700: UIFont = UIFontMetrics(forTextStyle: .caption1).scaledFont(for: Fonts.bold.withSize(fontSize))
    }
    static let caption: Fonts.Caption = Caption()

    struct Footnote: DSFont {
        private static let fontSize: Double = 8.0
        let regular400: UIFont = UIFontMetrics(forTextStyle: .footnote).scaledFont(for: Fonts.regular.withSize(fontSize))
        let medium500: UIFont = UIFontMetrics(forTextStyle: .footnote).scaledFont(for: Fonts.medium.withSize(fontSize))
        let semibold600: UIFont = UIFontMetrics(forTextStyle: .footnote).scaledFont(for: Fonts.semibold.withSize(fontSize))
        let bold700: UIFont = UIFontMetrics(forTextStyle: .footnote).scaledFont(for: Fonts.bold.withSize(fontSize))
    }
    static let footnote: Fonts.Footnote = Footnote()

    private static func get(_ style: DSFontStyle) -> DSFont {
        switch style {
        case .h1:
            return self.h1
        case .h2:
            return self.h2
        case .h3:
            return self.h3
        case .h4:
            return self.h4
        case .h5:
            return self.h5
        case .body1:
            return self.body1
        case .body2:
            return self.body2
        case .caption:
            return self.caption
        case .overline:
            return self.overline
        case .footnote:
            return self.footnote
        }
    }

    static func get(_ style: DSFontStyle, _ weight: DSFontWeight) -> UIFont {
        let dsFont: DSFont = self.get(style)

        switch weight {
        case .regular:
            return dsFont.regular400
        case .medium:
            return dsFont.medium500
        case .semibold:
            return dsFont.semibold600
        case .bold:
            return dsFont.bold700
        }
    }
}
