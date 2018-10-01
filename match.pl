%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% submitted by: Branden Vennes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% all of your changes should be made in this file

% main relation
% dummied up for now: only considers matchint the first elements in each
% respective list, the second elements, etc.
matchAll([],[],[],[]).
matchAll(MLIST,WLIST,LLIST,[[A,B,C]|SOLUTION]) :-
    selectOne(MLIST,A,AREST),
    selectOne(WLIST,B,BREST),
    selectOne(LLIST,C,CREST),
    likes(A,B),
    likes(A,C),
    likes(B,C),
    matchAll(AREST,BREST,CREST,SOLUTION).

selectOne([FIRST|REST], FIRST, REST).
selectOne([START|REST], PICKED, [START|UNPICKED]) :-
    selectOne(REST, PICKED, UNPICKED).


