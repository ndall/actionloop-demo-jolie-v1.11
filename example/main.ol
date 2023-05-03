/*
For now.
Service has to be named: Main
method has to be named: run
*/

service Main {    

    inputPort mainIp {
        location: "local"
        RequestResponse: run(undefined)(undefined)
    }

    main{

        run(request)(response){
            if(is_defined(request.name)){
                name = request.name
            }else{
                name = "Stranger"
            }
            greeting = "Hello " + name
            response.greeting = greeting            
        }

    }
}