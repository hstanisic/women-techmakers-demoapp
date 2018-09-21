//
//  Copyright © 2016 Zalando SE. All rights reserved.
//

import Foundation

final class TvShowServiceMock: ITvShowService {

    func fetchPopular(completion: @escaping (TvShowResult?) -> Void) {
        let result = fetchMockData()
        guard let mockData = result else {
            completion(nil)
            return
        }
        completion(mockData)
    }

    func search(withQuery query: String, completion: @escaping (TvShowResult?) -> Void) {
        let result = fetchMockData()
        guard let mockData = result else {
            completion(nil)
            return
        }
        mockData.items = mockData.items.filter {return $0.name.lowercased().contains(query.lowercased())}
        completion(mockData)
    }

    private func fetchMockData() -> TvShowResult? {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "TvShows", ofType: "json")!
        if let fileContent = try? Data(contentsOf: URL(string: path)!) {
            return try? JSONDecoder().decode(TvShowResult.self, from: fileContent)
        }
        return nil
    }
}
