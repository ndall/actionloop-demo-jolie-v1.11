/*
For now.
Service has to be named: Main
method has to be named: run
*/
// from console import Console
// from string_utils import StringUtils

service Main {    

    // embed Console as console
    // embed StringUtils as StringUtils

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
            response.greeting << greeting    
            // println@console(valueToPrettyString@StringUtils(response))()        
        }

    }
}