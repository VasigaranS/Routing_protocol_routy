%% @author vasigarans
%% @doc @todo Add description to map.


-module(map).

%% ====================================================================
%% API functions
%% ====================================================================
-export([new/0,reachable/2,update/3,all_nodes/1]).


new()->
	[].

update(Node,List_link,Map)->
	Map2=lists:keydelete(Node, 1, Map),
	%{Node,List_link}.
	[{Node,List_link}|Map2].


reachable(Node,Map)->
	
	Tuple1=lists:keyfind(Node, 1, Map),
	Tuple1,
	if(Tuple1==false)->
		  [];
	true->{_,Y}=Tuple1,
	Y
	  end.
	

all_nodes(Map)->
	Map2=lists:flatmap((fun({X,Y})-> [X|Y] end),Map),
	remove_dups(Map2).



remove_dups([])    -> [];
remove_dups([H|T]) -> [H | [X || X <- remove_dups(T), X /= H]].


	
	

%% ====================================================================
%% Internal functions
%% ====================================================================


