module GraphQL.Hoho exposing (mutation, MutationResult)

import Task exposing (Task)
import Json.Decode exposing (..)
import Json.Encode exposing (encode)
import Http
import GraphQL exposing (apply, ID)

endpointUrl : String
endpointUrl =
    "http://localhost:4000/graphql"


type alias MutationResult =
    { createLink :
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


mutation : { title: String, url: String } -> Task Http.Error MutationResult
mutation params =
    let
        o  = "\""
        qa = """mutation mutation { createLink(input: {clientMutationId: "1", title: """
        qb = params.title
        qc = """, url: """
        qd = params.url
        qe = """}) { linkEdge { node { id url title createdAt } } } }"""
        graphQLQuery = qa ++ o ++ qb ++ o ++ qc ++ o ++ qd ++ o ++ qe
        graphQLParams =
            Json.Encode.object
                [
                ]
    in
    GraphQL.query endpointUrl graphQLQuery "mutation" (encode 0 graphQLParams) mutationResult


mutationResult : Decoder MutationResult
mutationResult =
    map MutationResult ("createLink" :=
        (map (\linkEdge -> { linkEdge = linkEdge }) ("linkEdge" :=
        (map (\node -> { node = node }) ("node" :=
        (map (\id url title createdAt -> { id = id, url = url, title = title, createdAt = createdAt }) (maybe ("id" := string))
        `apply` (maybe ("url" := string))
        `apply` (maybe ("title" := string))
        `apply` (maybe ("createdAt" := string))))))))
