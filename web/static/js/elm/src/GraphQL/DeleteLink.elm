module GraphQL.DeleteLink exposing (deleteLink, DeleteLinkResult)

import Task exposing (Task)
import Json.Decode exposing (..)
import Json.Encode exposing (encode)
import Http
import GraphQL exposing (apply, ID)

endpointUrl : String
endpointUrl =
    "http://localhost:4000/graphql"


type alias DeleteLinkResult =
    { deleteLink :
        { linkEdge :
            { node :
                { id : Maybe String
                , url : Maybe String
                , title : Maybe String
                , createdAt : Maybe String
                }
            }
        }
    }


deleteLink : { id: String } -> Task Http.Error DeleteLinkResult
deleteLink params =
    -- graphQLQuery = """mutation mutation { deleteLink(input: {id: "1"}) { linkEdge { node { id url title createdAt } } } }""" in
    let
        o  = "\""
        qa = """mutation mutation { deleteLink(input: {id: """
        qb = params.id
        qc = """}) { linkEdge { node { id url title createdAt } } } }"""
        graphQLQuery = qa ++ o ++ qb ++ o ++ qc
        graphQLParams =
            Json.Encode.object
                []
    in
    GraphQL.query endpointUrl graphQLQuery "mutation" (encode 0 graphQLParams) deleteLinkResult


deleteLinkResult: Decoder DeleteLinkResult
deleteLinkResult =
    map DeleteLinkResult ("deleteLink" :=
        (map (\linkEdge -> { linkEdge = linkEdge }) ("linkEdge" :=
        (map (\node -> { node = node }) ("node" :=
        (map (\id url title createdAt -> { id = id, url = url, title = title, createdAt = createdAt })
        (maybe ("id" := string))
        `apply` (maybe ("url" := string))
        `apply` (maybe ("title" := string))
        `apply` (maybe ("createdAt" := string))))))))
