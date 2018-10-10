%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% submitted by: Branden Vennes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% all of your changes should be made in this file

% main relation
% dummied up for now: only considers matchint the first elements in each
% respective list, the second elements, etc.
matchAll(MLIST,WLIST,LLIST,MATCHLIST) :-
    findall(MATCHES, findMatch(MLIST, WLIST, LLIST, MATCHES), MATCHLIST).

% relation to select a single element from the given list
% returns the selected element and a list of the unselected
selectOne([FIRST|REST], FIRST, REST).
selectOne([START|REST], PICKED, [START|UNPICKED]) :-
    selectOne(REST, PICKED, UNPICKED).

findMatch(MLIST, WLIST, LLIST, MATCH) :-
    selectOne(MLIST, M, MREST),
    selectOne(WLIST, W, WREST),
    selectOne(LLIST, L, LREST),
    getMatch(M,W,L, MATCH).

getMatch(M, W, L, [M,W,L]) :-
    likes(M,W),
    likes(W,L),
    likes(M,L).