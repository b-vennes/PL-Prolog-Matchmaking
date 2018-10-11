%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% submitted by: Branden Vennes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% all of your changes should be made in this file

% main relation
% dummied up for now: only considers matchint the first elements in each
% respective list, the second elements, etc.
matchAll(MLIST,WLIST,LLIST,MATCHES) :-
    % get lengths for all the lists
    getLength(MLIST, MSIZE),
    getLength(WLIST, WSIZE),
    getLength(LLIST, LSIZE),
    % find the smallest of all the list lengths
    min_list([MSIZE, WSIZE, LSIZE], MIN),
    % take the first match from all possible match sets
    findMatch(MLIST, WLIST, LLIST, MIN, MATCHES),
    !.

matchMost(MLIST,WLIST,LLIST,UNMATCHEDNUM,MATCHES) :-
    % getlengths for all the lists
    getLength(MLIST, MSIZE),
    getLength(WLIST, WSIZE),
    getLength(LLIST, LSIZE),
    % find the smallest of all the list lengths
    min_list([MSIZE, WSIZE, LSIZE], MIN),
    % the number of matches to find is the smallest list length - the number to not match
    NUMMATCHES is MIN - UNMATCHEDNUM,
    findMatch(MLIST, WLIST, LLIST, NUMMATCHES, MATCHES),
    !.


% select a single element from the given list
% returns the selected element and a list of the unselected
selectOne([FIRST|REST], FIRST, REST).
selectOne([START|REST], PICKED, [START|UNPICKED]) :-
    selectOne(REST, PICKED, UNPICKED).

% given a list of men, women, and locations, determine all possible matches
findMatch(_,_,_,0,[]). % stop when no more matches necessary
findMatch(MLIST, WLIST, LLIST, NUMMATCHES, [MATCH | SUBMATCHES]) :-
    selectOne(MLIST, M, MREST),
    selectOne(WLIST, W, WREST),
    selectOne(LLIST, L, LREST),
    getMatch(M,W,L, MATCH), % make sure that they match nicely
    NUMLEFT is NUMMATCHES - 1,
    findMatch(MREST, WREST, LREST, NUMLEFT, SUBMATCHES). % recursively find matches for the rest of the list


% given a man, woman, and location, determines if a match
getMatch(M, W, L, [M,W,L]) :-
    likes(M,W),
    likes(W,L),
    likes(M,L).

% given a list, returns the list length
getLength([], 0).
getLength([_|TAIL], SIZE) :-
    getLength(TAIL, TAILSIZE),
    SIZE is 1 + TAILSIZE.
    