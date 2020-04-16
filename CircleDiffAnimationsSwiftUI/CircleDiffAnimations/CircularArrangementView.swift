import SwiftUI


//Implementation of the circular arrangement inspired by https://github.com/christophedellac/CDCircularMenu

struct CircularArrangementView: View {
    
    @State private var circleInfoModel = CircleInfoModel()
    
    private let itemsCount = 7
    private let circleRadius = Dimensions.circleRadius.rawValue
    
    var body: some View {
        
        ZStack {
            ForEach(circleInfoModel.activeCircles) { circleInfo in
                ColorView(circleInfo: circleInfo)
                    .offset(x: self.xOffset(self.circleInfoModel.index(of: circleInfo)!),
                            y: self.yOffset(self.circleInfoModel.index(of: circleInfo)!))
                    .animation(.easeInOut)
                    .transition(.custom)
            }
            
            Button(action: {
                withAnimation { self.circleInfoModel.toggle() }
            }) {
                Text("Toggle").font(.title)
            }.offset(y: 300)
        }
        
    }
    
    private func xOffset(_ index: Int) -> CGFloat {
        let slice = CGFloat(2 * Double.pi / Double(itemsCount))
        return circleRadius * cos(slice * CGFloat(index))
    }
    
    private func yOffset(_ index: Int) -> CGFloat {
        let slice = CGFloat(2 * Double.pi / Double(itemsCount))
        return circleRadius * sin(slice * CGFloat(index))
    }
}

struct ColorView: View {
    let circleInfo: CircleInfo
    var body: some View {
        Circle()
            .foregroundColor(circleInfo.color)
            .frame(
                width: self.circleInfo.getSize(),
                height: self.circleInfo.getSize()
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CircularArrangementView()
    }
}

extension CircleInfo {
    func getSize() -> CGFloat {
        self.isExpanded ? Dimensions.selectedSize.rawValue : Dimensions.unselectedSize.rawValue
    }
}

extension AnyTransition {
    static var custom: AnyTransition {
        let insertion = AnyTransition.scale.combined(with: .offset())
        let removal = AnyTransition.scale
        
        return .asymmetric(insertion: insertion, removal: removal)
    }
}
