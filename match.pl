%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% submitted by: Branden Vennes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% all of your changes should be made in this file

% main relation
% dummied up for now: only considers matchint the first elements in each
% respective list, the second elements, etc.
matchAll(MLIST,WLIST,LLIST,FIRST) :-
    % take the first match from all possible match sets
    findall(MATCHES, findMatch(MLIST, WLIST, LLIST, MATCHES), [FIRST|_]).

% select a single element from the given list
% returns the selected element and a list of the unselected
selectOne([FIRST|REST], FIRST, REST).
selectOne([START|REST], PICKED, [START|UNPICKED]) :-
    selectOne(REST, PICKED, UNPICKED).

% given a list of men, women, and locations, determine all possible matches
findMatch([],[],[],[]).
findMatch([],_,_,[]).
findMatch(_,[],_,[]).
findMatch(_,_,[],[]).
findMatch(MLIST, WLIST, LLIST, [MATCH | SUBMATCHES]) :-
    selectOne(MLIST, M, MREST),
    selectOne(WLIST, W, WREST),
    selectOne(LLIST, L, LREST),
    getMatch(M,W,L, MATCH), % make sure that they match nicely
    findMatch(MREST, WREST, LREST, SUBMATCHES). % recursively find matches for the rest of the list

% given a man, woman, and location, determines if a match
getMatch(M, W, L, [M,W,L]) :-
    likes(M,W),
    likes(W,L),
    likes(M,L).