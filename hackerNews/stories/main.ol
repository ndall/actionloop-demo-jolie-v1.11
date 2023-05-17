/*
For now.
Service has to be named: Main
Method can be named anything
*/

from .hackerNews import HackerNewsMiddleLayer as HNMiddleLayer
from console import Console as console
from json_utils import JsonUtils
from string_utils import StringUtils as StringUtils

service Main {    

    embed HNMiddleLayer as HNMiddleLayer
    embed console as Console
    embed StringUtils as StringUtils
    embed JsonUtils as JsonUtils

    inputPort mainIp {
        location: "local"
        RequestResponse: run(undefined)(undefined)
    }

    //Important to be able to handle several requests
    execution: concurrent

    main{

        run(request)(response){
            getStories@HNMiddleLayer({newsCategory = request.newsCategory})(Hresponse)
            response.response << Hresponse
        }

    }
}