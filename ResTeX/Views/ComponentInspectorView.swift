//
//  Created by Jericho Hasselbush on 11/10/23.
//

import SwiftUI

struct ComponentInspectorView: View {
    var body: some View {
        EmptyView()
    }
}

#Preview {
    @State var wire = Wire(start: .zero, length: 10)
    return ComponentInspectorView()
}

