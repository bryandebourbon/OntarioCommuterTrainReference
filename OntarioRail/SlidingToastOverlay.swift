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
  @GestureState private var dragState = DragState.inactive
  @State private var viewYPos = 600.0

  var content: () -> Content

  var drag: some Gesture {
    DragGesture()
      .updating($dragState) { delta, state, transaction in

        state =
          .dragging(translation: delta.startLocation.y + delta.location.y)
        print("delta.startLocation.y \(delta.startLocation.y)  delta.location.y \(delta.location.y)")
      // the location numbers are relative the point of contact with the screen, not relative to origin
                transaction = Transaction(animation: .easeIn)
      }
      .onEnded { value in
        withAnimation {
          self.viewYPos = value.predictedEndLocation.y
        }
        //        print("onEnded")
        //        let currHandleYPos = abs(self.viewYPos)
        //        let newYPos = abs(value.location.y)
        //        let delta = currHandleYPos - newYPos
        //        print("delta: \(delta) currHandleYPos: \(currHandleYPos) newYPos: \(newYPos)")
        //        print(value)
        //        withAnimation(.easeOut) {
        //          if currHandleYPos <= newYPos {
        //            self.viewYPos = newYPos
        //          } else {
        //            self.viewYPos = newYPos - delta
        //          }
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
        RoundedRectangle(cornerRadius: 30)
          .fill(.black)
          .opacity(0.5)
          .frame(width: 100, height: 10)
          .padding().gesture(drag)

        content()
          .padding()

      }.frame(height: abs(550 - dragState.translation))

    }
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
