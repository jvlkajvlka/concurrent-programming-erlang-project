-module(fifo).

-export([newFifo/0,
         notEmpty/1,
         popFromFifo/1,
         pushToFifo/2]).

newFifo() -> {[], []}.

pushToFifo({In, Out}, X) -> {[X | In], Out}.

popFromFifo({[], []}) -> erlang:error(empty);
popFromFifo({In, []}) ->
    popFromFifo({[], lists:reverse(In)});
popFromFifo({In, [H | T]}) -> {H, {In, T}}.

notEmpty({[], []}) -> false;
notEmpty({_, _}) -> true.
