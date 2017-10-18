%%%-------------------------------------------------------------------
%%% @author LFigueroa
%%% @copyright (C) 2017, <HAUS PROJECT>
%%% @doc This class is the server itself with all the functions to start
%%%      a process and close if asked.
%%% @end
%%% Created : 11. Oct 2017 16:27
%%%-------------------------------------------------------------------

-module(erlServer_server).

-export([init/0]).

-define(Port, 8080). %% Defining the port used.

%%====================================================================
%% API functions
%%====================================================================

init() ->
	start().

start_server() ->
 io:format("Server started.~n"),
 {ok, ServerSocket} = gen_tcp:listen(?Port, [binary, {packet, 0}, % packet, raw
   {reuseaddr, true}, {active, true}]),
  io:format("~p", [ServerSocket]),
    server_loop(ServerSocket).

server_loop(ServerSocket) ->
 {ok, Socket} = gen_tcp:accept(ServerSocket),
  Pid = spawn(fun() -> handle_client(Socket) end),
  inet:setopts(Socket, [{packet, 0}, binary, %% To change between active and passive modes when listening to messages.
    {nodelay, true}, {active, true}]),
  gen_tcp:controlling_process(Socket, Pid), %% Let this PID guy take over my socket,
  %% He will be able to read and receive messages - Change ownership
  server_loop(ServerSocket).

handle_client(Socket) ->
 receive
%%   {tcp_closed, Socket, <<"quit">>} ->
%%     gen_tcp:close(socket); %% To close the connection when quit is typed. MAYBE NOT NEEDED
   {tcp, Socket, Request} ->
     io:format("received: ~s~n", [Request]),
     handle_client(Socket)
 end.

handle_message() ->
{ok, Msg} = gen_tcp:recv(Socket, Message),
Pid ! gen_tcp:send(Socket, Message).
