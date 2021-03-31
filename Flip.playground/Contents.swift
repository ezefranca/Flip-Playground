import PlaygroundSupport
import SwiftUI

extension View {
    @ViewBuilder
    func rotate(_ direction: FlipDirection, degrees: Double) -> some View {
        if case .horizontal = direction {
            self.rotation3DEffect(.init(degrees: degrees), axis: (x: 0, y: 1, z: 0))
        } else {
            self.rotation3DEffect(.init(degrees: degrees), axis: (x: 1, y: 0, z: 0))
        }
    }

}

public enum FlipDirection {
    case horizontal, vertical
}

struct Flip: ViewModifier {
    public var direction: FlipDirection

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
                .rotationEffect(.init(degrees: 180))
                .rotate(direction, degrees: 180)
        }
    }
}

struct BodyView: View {
    var body: some View {
        HStack {
            Text("Hello World")
                .modifier(Flip(direction: .vertical))
            Text("Hello Universe")
                .modifier(Flip(direction: .horizontal))
        }
    }
}

PlaygroundPage.current.liveView = UIHostingController(rootView: BodyView())
