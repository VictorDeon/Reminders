import SwiftUI

struct AllCountView: View {
    let count: Int
    
    var body: some View {
        HStack {
            VStack(spacing: 3) {
                Image(systemName: Constants.Icons.trayCircleFill)
                    .font(.largeTitle)
                
                Text("All")
            }
            Spacer()
            VStack {
                Text("\(count)")
                    .font(.title)

                EmptyView()
            }
        }
        .padding()
        .background(Color.gray)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .padding(3)
        
    }
}

#Preview {
    AllCountView(count: 0)
}
