//
//  NetworkClient.swift
//  PolitechDepartmentOfNatureManagement
//
//  Created by Demain Petropavlov on 09.09.2025.
//

import Foundation

enum NetworkClientError: LocalizedError {
    case httpStatusCode(Int, String?)
    case urlRequestError(Error)
    case urlSessionError
    case parsingError(String)
    case incorrectRequest(String)

    var errorDescription: String? {
        switch self {
        case .httpStatusCode(let code, let body):
            return "HTTP ошибка \(code). Тело: \(body ?? "нет данных")"
        case .urlRequestError(let err):
            return "Ошибка URLRequest: \(err.localizedDescription)"
        case .urlSessionError:
            return "Ошибка сессии URLSession"
        case .parsingError(let details):
            return "Ошибка декодинга JSON: \(details)"
        case .incorrectRequest(let msg):
            return "Некорректный запрос: \(msg)"
        }
    }
}

protocol NetworkClient {
    func send(request: NetworkRequest) async throws -> Data
    func send<T: Decodable>(request: NetworkRequest) async throws -> T
}

actor DefaultNetworkClient: NetworkClient {
    static let shared = DefaultNetworkClient()

    private let session: URLSession
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder

    init(
        session: URLSession = URLSession.shared,
        decoder: JSONDecoder = JSONDecoder(),
        encoder: JSONEncoder = JSONEncoder()
    ) {
        self.session = session
        self.decoder = decoder
        self.encoder = encoder
    }

    func send(request: NetworkRequest) async throws -> Data {
        let urlRequest = try create(request: request)

        // 🔍 Логируем запрос
        print("🌍 Запрос:", urlRequest.httpMethod ?? "?", urlRequest.url?.absoluteString ?? "nil")
        if let headers = urlRequest.allHTTPHeaderFields {
            print("📌 Headers:", headers)
        }
        if let body = urlRequest.httpBody,
           let bodyString = String(data: body, encoding: .utf8) {
            print("📦 Body:", bodyString)
        }

        do {
            let (data, response) = try await session.data(for: urlRequest)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkClientError.urlSessionError
            }

            if !(200 ..< 300).contains(httpResponse.statusCode) {
                let bodyString = String(data: data, encoding: .utf8)
                print("❌ HTTP ошибка: \(httpResponse.statusCode). Тело ответа:\n\(bodyString ?? "nil")")
                throw NetworkClientError.httpStatusCode(httpResponse.statusCode, bodyString)
            }

            print("✅ Ответ: \(httpResponse.statusCode), байт: \(data.count)")
            return data
        } catch {
            print("❌ Ошибка сети:", error)
            throw NetworkClientError.urlRequestError(error)
        }
    }

    func send<T: Decodable>(request: NetworkRequest) async throws -> T {
        let data = try await send(request: request)

        do {
            let decoded = try decoder.decode(T.self, from: data)
            return decoded
        } catch {
            let str = String(data: data, encoding: .utf8) ?? "nil"
            print("❌ Ошибка декодинга:", error)
            print("📄 Ответ сервера как строка:\n\(str)")
            throw NetworkClientError.parsingError(error.localizedDescription)
        }
    }

    // MARK: - Private

    private func create(request: NetworkRequest) throws -> URLRequest {
        guard let endpoint = request.endpoint else {
            throw NetworkClientError.incorrectRequest("Empty endpoint")
        }

        var urlRequest = URLRequest(url: endpoint)
        urlRequest.httpMethod = request.httpMethod.rawValue

        if let rawBody = request.rawBody {
            urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = rawBody
        } else if let dto = request.dto {
            do {
                let dtoEncoded = try encoder.encode(dto)
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                urlRequest.httpBody = dtoEncoded
            } catch {
                throw NetworkClientError.urlRequestError(error)
            }
        }

        return urlRequest
    }
}
