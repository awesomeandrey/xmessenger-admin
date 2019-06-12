public class CalloutConstants {
    public final static Integer SC_OK = 200;
    public final static Integer SC_BAD_REQUEST = 400;

    public final static Set<Integer> SC_FAILURE = new Set<Integer>{
            SC_BAD_REQUEST // Bad request;
            , 401 // Unauthorized;
            , 403 // Forbidden;
            , 415 // Unsupported Media type;
            , 500 // Server error;
    };

    public final static String ENDPOINT = 'callout:API_Server';
    public final static String DEFAULT_CONTENT_TYPE = 'application/json;charset=utf-8';
    public final static Integer DEFAULT_TIMEOUT = 10 * 1000;
}