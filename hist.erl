-module(hist).
-export([new/1, update/3]).





new(Name) ->
	[{Name,inf}].




update(Node, N, History) ->

	%io:fwrite(" 21 ~w ~w ~w",[Node,N,History]),

	Tuple1=lists:keyfind(Node, 1, History),
	case Tuple1 of {Node,Cur}->

					   if N>Cur->
		   History1=lists:keydelete(Node, 1, History),
		   History2=[{Node,N}|History1],
		   {new,History2};
	   true->
		   old
	end;
		false->
			{new,[{Node,N}|History]}
	end.


