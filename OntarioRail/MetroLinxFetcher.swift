import Foundation


func fetch<T: Codable>(_ urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
  guard let url = URL(string: urlString) else {
    completion(.failure(URLError(.badURL)))
    return
  }

  URLSession.shared.dataTask(with: url) { data, _, error in
    if let error = error {
      completion(.failure(error))
      return
    }

    guard let data = data else {
      completion(.failure(URLError(.cannotDecodeContentData)))
      return
    }

    do {
      let decodedData = try JSONDecoder().decode(T.self, from: data)
      completion(.success(decodedData))
    } catch {
      completion(.failure(error))
    }
  }.resume()
}




