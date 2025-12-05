% pex5.pl
% USAFA UFO Sightings 2024
%
% name: Jack Barnett
%
% Documentation: 
%

% define each cadet (who)
cadet(smith).
cadet(garcia).
cadet(chen).
cadet(jones).

% define each day (when)
day(tuesday).
day(wednesday).
day(thursday).
day(friday).

% define each object (what)
object(balloon).
object(kite).
object(fighter).
object(cloud).

solve :-
    day(SmithDay), day(GarciaDay), day(ChenDay), day(JonesDay), % define the variables for each person day we are solving for
    all_different([SmithDay, GarciaDay, ChenDay, JonesDay]),

    object(SmithObject), object(GarciaObject), object(ChenObject), object(JonesObject), % define the variables for each object we are solving for
    all_different([SmithObject, GarciaObject, ChenObject, JonesObject]),

    % associate the constants (cadets) with their vairbales
    Triples = [ [smith, SmithDay, SmithObject],  
                [garcia, GarciaDay, GarciaObject],
                [chen, ChenDay, ChenObject],
                [jones, JonesDay, JonesObject] ],

    % Rules:
    % C4C Smith did not see a weather balloon, nor kite.
    \+ member([smith, _, balloon], Triples),
    \+ member([smith, _, kite], Triples),

    % The one who saw the kite isnt C4C Garcia.
    \+ member([garcia, _, kite], Triples),

    % Fridays sighting was made by either C4C Chen or the one who saw the fighter aircraft.
    % member([chen, friday, _], Triples),
    % member([_, friday, fighter], Triples),

    % The kite was not sighted on Tuesday.
    \+ member([_, tuesday, kite], Triples),

    % Neither C4C Garcia nor C4C Jones saw the weather balloon.
    \+ member([garcia, _, balloon], Triples),
    \+ member([jones, _, balloon], Triples),

    % C4C Jones did not make their sighting on Tuesday.
    \+ member([jones, tuesday, _], Triples),

    % C4C Smith saw an object that turned out to be a cloud.
    member([jones, _, cloud], Triples),

    % The fighter aircraft was spotted on Friday
    member([_, friday, fighter], Triples),

    % The weather balloon was not spotted on Wednesday.
    \+ member([_, wednesday, balloon], Triples),

    
    tell(smith, SmithDay, SmithObject),
    tell(garcia, GarciaDay, GarciaObject),
    tell(chen, ChenDay, ChenObject),
    tell(jones, JonesDay, JonesObject).

    % Succeeds if all elements of the argument list are bound and different.
    % Fails if any elements are unbound or equal to some other element.
    all_different([H | T]) :- member(H, T), !, fail.
    all_different([_ | T]) :- all_different(T).
    all_different([_]).

    tell(X, Y, Z) :-
    write('C4C '), write(X), write(' on '), write(Y),
    write(' saw object '), write(Z), write('.'), nl.


% The query to get the answer(s) or that there is no answer
% ?- solve.


