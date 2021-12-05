%% @author vasigarans
%% @doc @todo Add description to interfaces.


-module(intf).

%% ====================================================================
%% API functions
%% ====================================================================
-export([new/0,add/4,remove/2,ref/2,name/2,list/1,list/2,lookup/2,broadcast/2]).

new()->
	[].

add(Name, Ref, Pid, Intf) ->
    case lists:member({Name, Ref, Pid}, Intf) of
	true ->
	    Intf;
	false ->
	    [{Name, Ref, Pid} | Intf]
    end.

remove(Name, Intf) ->
    lists:keydelete(Name, 1, Intf).

lookup(Name, Intf)->
	Temp_tuple=lists:keyfind(Name,1,Intf),
	case Temp_tuple of {Name,_,Pid}->
						   {ok,Pid};
		false->
			notfound
	end.

ref(Name, Intf) ->
	Temp_tuple=lists:keyfind(Name,1,Intf),
	case Temp_tuple of {Name,Ref,_}->
						   Ref;
		false->
			notfound
	end.

name(Ref, Intf) ->
	Temp_tuple=lists:keyfind(Ref,2,Intf),
	case Temp_tuple of {Name,Ref,_}->
						   Name;
		false->
			notfound
	end.
	

list(Intf)->
	list(Intf,[]).

list([],A)->
	A;

list([H|T],A)->
	{Name,_,_}=H,
	list(T,[Name|A]).




broadcast(Message, Intf) ->
%io:fwrite("~w~n",[Message]),
%io:fwrite("~w~n",[Intf]),
    lists:foreach(fun({_,_,Pid}) ->
			  Pid ! Message end,
		  Intf).


	

%% ====================================================================
%% Internal functions
%% ====================================================================


