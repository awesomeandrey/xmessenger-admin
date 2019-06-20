public without sharing virtual class CalloutExecutor {
    public HttpResponse sendRequest(HttpRequest req) {
        HttpResponse response = new Http().send(req);
        if (CalloutConstants.SC_FAILURE.contains(response.getStatusCode())) {
            throw new CalloutException(
                    String.format('Callout failure: {0} ({1} {2})', new List<Object>{
                            response.getBody(), response.getStatus(), response.getStatusCode()
                    }));
        }
        return response;
    }

    public HttpResponse sendRequest(String endpoint, String method, Object body) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod(method);
        req.setBody(this.serializeBody(body));
        req.setTimeout(CalloutConstants.DEFAULT_TIMEOUT);
        req.setHeader('Content-Type', CalloutConstants.DEFAULT_CONTENT_TYPE);
        return this.sendRequest(req);
    }

    protected virtual String serializeBody(Object body) {
        return JSON.serialize(body);
    }
}