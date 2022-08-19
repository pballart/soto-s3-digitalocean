//
//  ContentLengthHeaderMiddleware.swift
//  
//
//  Created by Pau Ballart on 19/8/22.
//

import SotoCore

struct ContentLengthHeaderMiddleware: AWSServiceMiddleware {
    func chain(request: AWSRequest, context: AWSMiddlewareContext) throws -> AWSRequest {
        var mutableRequest = request
        mutableRequest.httpHeaders.replaceOrAdd(name: "content-length", value: "0")
        return mutableRequest
    }
}

