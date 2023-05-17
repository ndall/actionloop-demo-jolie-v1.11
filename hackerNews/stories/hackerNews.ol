from console import Console

/*
TEST CALLS:

curl http://localhost:8000/getItem?id=8864
curl http://localhost:8000/getStories?newsCategory=new

*/


//Types
type ListStoriesResponse { _*: int}
type NewsCategory {newsCategory: string}
type ItemId { id: int }


//Interface for our different API endpoints
interface HackerNewsI {
    RequestResponse:
        getStories ( NewsCategory )( ListStoriesResponse ),
        getItem ( ItemId ) ( undefined )
}

service HackerNewsMiddleLayer{
    embed Console as console

    execution: concurrent

    outputPort HackerNewsOutput {
        //Base location
        location: "socket://hacker-news.firebaseio.com:443"
        protocol: https {
            // debug = true;
            // debug.showContent = true
            osc << {
                //Endpoints
                stories << {
                    alias = "v0/%{story}stories.json"
                    method = "get"
                }
                item << {
                    alias = "v0/item/%{itemid}.json"
                    method = "get"
                }
            }
        }
        RequestResponse: stories, item
    }

    //Listening on this location
    inputPort HackerNewsInput {
        location: "local"
        interfaces: HackerNewsI
    }

    main
    {
        //Get stories for chosen news category to caller
        [getStories( request ) (response) {
            //Replace placeholder and get stories for the chosen news category from HackerNews
            stories@HackerNewsOutput( {story = request.newsCategory} )( stories )

            response << stories
        }]

        //Get item by id to caller
        [getItem ( request )(response){
            //Replace placeholder and get item by id from HackerNews
            item@HackerNewsOutput( {itemid = request.id} ) (item)

            //Lines to make kids array work properly since jolie convert an array of one element into an integer type. 
            if(#item.kids == 1){
                item.kids._ = item.kids
            }

            response << item
        }]
    }
}