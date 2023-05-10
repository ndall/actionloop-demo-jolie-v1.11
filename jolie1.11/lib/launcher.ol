from runtime import Runtime 
from file import File
from console import Console
from json_utils import JsonUtils
from string_utils import StringUtils

//Import users action
from .main__ import Main

service Mock {    

    embed Runtime as runtime
    embed File as file
    embed Console as console
    embed JsonUtils as JsonUtils
    embed StringUtils as StringUtils

    //Embed user action
    embed Main as Main

    init{
        looping = true
    }

    main{
        while(looping){ 

            myReadLine@console("in")(line)

            if(line == void){
                looping = false
            }else{
                getJsonValue@JsonUtils( line )( args )
                payload = {}
            
                foreach(key : args){
                    if(key == "value"){
                        payload << args.value
                    } else{
                        toUpperCase@StringUtils(key)(upperKey)
                        setenv@runtime({ key= "__OW_" + upperKey  value=args.(key)})()
                    }
                }
                
                //try

                run@Main(payload)(response)
                getJsonString@JsonUtils(response)(responseJson)

                //error handling here

                //write to fd3
                writeFile@file({filename = "/dev/fd/3" content=responseJson + "\n" append = 1} )()

                //writeFile@file({filename = "out.txt" content=responseJson + "\n"} )()
                //println@console(responseJson)()
            }
        }
    }
}
