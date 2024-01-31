import SwiftUI

enum DragState {
  case inactive
  case pressing
  case dragging(translation: CGFloat)

  var translation: CGFloat {
    switch self {
    case .inactive, .pressing:
      return .zero
    case .dragging(let translation):
      return translation
    }
  }

  var isActive: Bool {
    switch self {
    case .inactive:
      return false
    case .pressing, .dragging:
      return true
    }
  }

  var isDragging: Bool {
    switch self {
    case .inactive, .pressing:
      return false
    case .dragging:
      return true
    }
  }
}

struct SlidingToastOverlay<Content: View>: View {
  @State private var startLocation = CGPoint(x: 0, y: 0)
  @GestureState private var currentLocation = CGPoint(x: 0, y: 0)
  @State private var lastLocation = CGPoint(x: 0, y: 0)
  @State private var viewState = CGSize.zero
  @GestureState private var dragState = DragState.inactive

  var content: () -> Content

  var drag: some Gesture {
    DragGesture()
      .onChanged { value in
        //print(value)
        self.startLocation = value.location
      }
      .onEnded { value in
        //print(value)
        self.lastLocation = CGPoint(x: 0, y: 500 - value.location.y)
      }
      .updating($currentLocation) { value, state, transaction in
        print(value.startLocation.y)
//        if (value.startLocation.y > 600) {
          state = CGPoint(x: 0, y: value.startLocation.y - value.location.y)
          transaction = Transaction(animation: .easeInOut)
//        }
      }
  }

  var body: some View {
    VStack {
      Spacer()
      ZStack(alignment: .top) {
        RoundedRectangle(cornerRadius: 30)
          .fill(.white)
          .opacity(0.95)
          .shadow(radius: 10)

        VStack {
          ZStack(alignment: .center) {
            Rectangle().fill(.clear)
            RoundedRectangle(
              cornerRadius: 30
            )
            .fill(.black)
            .opacity(0.5)
            .frame(
              width: 100,
              height: 10)
            //.shadow(radius: dragState.isActive ? 8 : 0)
            //.overlay(dragState.isDragging ? Circle().stroke(Color.white, lineWidth: 2) : nil)
          }
          .frame(
            maxWidth: .infinity,
            maxHeight: 60)


          content()
        }
      }.frame(height: 300 + lastLocation.y + currentLocation.y )
    }
    .gesture(drag)
    .ignoresSafeArea()
  }

}

struct SlidingToastOverlay_Previews: PreviewProvider {
  static var previews: some View {
    SlidingToastOverlay {
//      Rectangle()
      EmptyView()
    }
  }
}
