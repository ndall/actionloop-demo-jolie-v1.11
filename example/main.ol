/*
For now.
Service has to be named: Main
Method can be named anything
*/

from .hello import Main as Main2

service Main {    

    embed Main2 as helloMain

    inputPort mainIp {
        location: "local"
        RequestResponse: run(undefined)(undefined)
    }

    //Important to be able to handle several requests
    execution: concurrent

    main{

        run(request)(response){
            run@helloMain(request)(responseImport)
            response << responseImport
        }

    }
}