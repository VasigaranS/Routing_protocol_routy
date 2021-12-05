%% @author vasigarans
%% @doc @todo Add description to dijkstra.


-module(dijkstra).

%% ====================================================================
%% API functions
%% ====================================================================
-export([entry/2,replace/4,table/2,update/4,iterate/3,route/2]).


entry(Node,Sorted)->
	Tuple1=lists:keyfind(Node, 1, Sorted),
	if(Tuple1==false)->
		  0;
	true->{_,Y,_}=Tuple1,
		  Y
	  end.
	
	



replace(Node,N,Gateway,Sorted)->
	Sorted2=lists:keydelete(Node, 1, Sorted),
	lists:keysort(2,[{Node,N,Gateway}|Sorted2]).



	
update(Node,N,Gateway,Sorted)->
	Cur_length=entry(Node,Sorted),
	if(N<Cur_length)->
		  replace(Node,N,Gateway,Sorted);
	  true->
		  Sorted
	end.



iterate(Sorted,Map,Table)->
			%	io:fwrite("~w~n",[Sorted]),
			%io:fwrite("~w~n",[Table]),
	case Sorted of []->
					   Table;
		[{_,inf,_}|_]->
			%io:fwrite("here Format"),
			Table;
		[Head|Tail]->

			{Node,Length,Gateway}=Head,
			Temp_tuple=lists:keyfind(Node, 1, Map),
			case Temp_tuple of
				{_,Links}->
					New_sorted=lists:foldl(fun(X,Y)-> update(X,Length+1,Gateway,Y) end, Tail, Links);
				false->
					New_sorted=Tail
			end,
			iterate (New_sorted,Map,[{Node,Gateway}|Table])
		end.


table(Gateways,Map)->
	All_nodes=map:all_nodes(Map),
	Sortlist=lists:keysort(2,lists:map(fun(Node)->
											 case lists:member(Node, Gateways) of 
												 true->
													 {Node,0,Node};
												 false->
													 {Node,inf,unknown}
											 end
									   end,All_nodes)),
	iterate(Sortlist,Map,[]).
						
		
route(Node, Table) ->
    case lists:keyfind(Node,1,Table) of
	{_, Gateway} ->
	    {ok, Gateway};
	false ->
	    notfound
    end.



%% ====================================================================
%% Internal functions
%% ====================================================================


