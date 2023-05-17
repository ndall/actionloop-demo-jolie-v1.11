/*
For now.
Service has to be named: Main
Method can be named anything
*/

service Main {    

    inputPort mainIp {
        location: "local"
        RequestResponse: run(undefined)(undefined)
    }

    //Important to be able to handle several requests
    execution: concurrent

    main{

        run(request)(response){
            if(is_defined(request.name)){
                name = request.name
            }else{
                name = "Stranger"
            }
            greeting = "Hello " + name
            response.greeting << greeting    
        }

    }
}