module GraphQL.UpdateLink exposing (updateLink, UpdateLinkResult)

import Task exposing (Task)
import Json.Decode exposing (..)
import Json.Encode exposing (encode)
import Http
import GraphQL exposing (apply, ID)

endpointUrl : String
endpointUrl =
    "http://localhost:4000/graphql"


type alias UpdateLinkResult =
    { updateLink :
        { linkEdge :
            { node :
                { id :        Maybe String
                , url :       Maybe String
                , title :     Maybe String
                , createdAt : Maybe String
                }
            }
        }
    }


updateLink : { id: String, title: String, url: String } -> Task Http.Error UpdateLinkResult
updateLink params =
    -- let graphQLQuery = """query queryLinks($queryParam: String!, $orderBy: String!, $orderDir: String!) { store { linkConnection(query: $queryParam, order_by: $orderBy, order_dir: $orderDir) { edges { node { id title url createdAt } } } } }""" in
    -- let graphQLQuery = """mutation updateLink($id: String!, $title: String!, $url: String!) { updateLink(input: {clientMutationId: "1", id: $id, title: $title, url: $url}) { linkEdge { node { id title url createdAt }}}}"""
    let graphQLQuery = """mutation updateLink($id:String!,$title:String!,$url:String!){updateLink(input:{clientMutationId:"1",id:$id,title:$title,url:$url}){linkEdge{node{id,title,url,createdAt}}}}"""
        graphQLParams =
            Json.Encode.object
                [ ("id",    Json.Encode.string params.id),
                  ("title", Json.Encode.string params.title),
                  ("url",   Json.Encode.string params.url)
                ]
    in
        GraphQL.query endpointUrl graphQLQuery "updateLink" (encode 0 graphQLParams) updateLinkResult

updateLinkResult: Decoder UpdateLinkResult
updateLinkResult =
    map UpdateLinkResult ("updateLink" :=
        (map (\linkEdge -> { linkEdge = linkEdge }) ("linkEdge" :=
        (map (\node -> { node = node }) ("node" :=
        (map (\id url title createdAt -> { id = id, url = url, title = title, createdAt = createdAt })
        (maybe ("id" := string))
        `apply` (maybe ("url" := string))
        `apply` (maybe ("title" := string))
        `apply` (maybe ("createdAt" := string))))))))
