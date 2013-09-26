-module(leptus_http2).

-export([routes/0]).
-export([get/2]).

routes() ->
    ["/users/:id", "/users/:id/interests", "/users/:id/profile"].

get("/users/:id", Req) ->
    Id = leptus_req:binding(id, Req),
    {200, ["aha, this is ", Id]};

get("/users/:id/interests", Req) ->
    Id = leptus_req:binding(id, Req),
    case Id of
        <<"s1n4">> ->
            {200, <<"Erlang and a lotta things else">>};
        <<"456">> ->
            {200, "art, photography..."};
        _ ->
            {404, <<"not found...">>}
    end;

get("/users/:id/profile", Req) ->
    Body = [
            {<<"id">>, leptus_req:binding(id, Req)},
            {<<"bio">>, <<"Erlanger">>},
            {<<"github">>, leptus_req:binding(id, Req)}
           ],
    {200, json, Body}.