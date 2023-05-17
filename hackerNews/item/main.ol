/*
For now.
Service has to be named: Main
Method can be named anything
*/

from .hackerNews import HackerNewsMiddleLayer as HNMiddleLayer
from console import Console as console

service Main {    

    embed HNMiddleLayer as HNMiddleLayer
    embed console as Console

    inputPort mainIp {
        location: "local"
        RequestResponse: run(undefined)(undefined)
    }

    //Important to be able to handle several requests
    execution: concurrent

    main{

        run(request)(response){
            getItem@HNMiddleLayer({id = request.id})(HNresponse)
            response << HNresponse
        }

    }
}