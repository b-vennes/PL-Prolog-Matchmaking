%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% submitted by: Branden Vennes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%
%
% finds one match for every man, woman, and location in the given lists
%
% in - MLIST - the list of men to match
% in - WLIST - the list of women to match
% in - LLIST - the list of locations to match
%
% out - the triple sets of found matches
%
%%%%
matchAll(MLIST,WLIST,LLIST,MATCHES) :-
    % get lengths for all the lists
    getLength(MLIST, MSIZE),
    getLength(WLIST, WSIZE),
    getLength(LLIST, LSIZE),
    % find the smallest of all the list lengths
    min_list([MSIZE, WSIZE, LSIZE], MIN),
    % find MIN number of matches in the given men, women, and location lists
    findMatch(MLIST, WLIST, LLIST, MIN, MATCHES).

%%%%
%
% finds matches for all but a given number of men, women, and locations
%
% in - MLIST - the list of men to match
% in - WLIST - the list of women to match
% in - LLIST - the list of locations to match
%
% out - the set of triples containing the matched man, woman, and location
%
%%%%
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
    matchMost(MLIST, WLIST, LLIST, NUMMATCHES, MATCHES).

%
% select a single element from the given list
% returns the selected element and a list of the unselected
%
% in - a list of elements to select one of
%
% out - the picked element
% out - the unpicked elements
%
selectOne([FIRST|REST], FIRST, REST).
selectOne([START|REST], PICKED, [START|UNPICKED]) :-
    selectOne(REST, PICKED, UNPICKED).

%
% given a list of men, women, and locations, determine all possible matches
% in - MLIST - the list of men to match
% in - WLIST - the list of women to match
% in - LLIST - the list of locations to match
% in - NUMMATCHES - the number of matchesto find in the smallest list
%
% out - the list of triples containing all the found matches
%
findMatch(_,_,_,0,[]). % stop when no more matches necessary
findMatch(MLIST, WLIST, LLIST, NUMMATCHES, [MATCH | SUBMATCHES]) :-
    % select one man, woman, and location
    selectOne(MLIST, M, MREST),
    selectOne(WLIST, W, WREST),
    selectOne(LLIST, L, LREST),
    % check that the man, woman, and location match
    getMatch(M,W,L, MATCH),
    % we found a match so we can decrement our counter for matches left to find
    NUMLEFT is NUMMATCHES - 1,
    % find NUMLEFT matches for the rest of the lists
    findMatch(MREST, WREST, LREST, NUMLEFT, SUBMATCHES).

%
% given a man, woman, and location, determines if a match
% 
% in - M - the man to check
% in - W - the woman to check
% in - L - the location to check
%
% out - a triple containing the man, woman, and location if they are a match
%
getMatch(M, W, L, [M,W,L]) :-
    likes(M,W),
    likes(W,L),
    likes(M,L).

%
% given a list, returns the list length
%
% in - the list to find the length of
%
% out - the length of the list
%
getLength([], 0).
getLength([_|TAIL], SIZE) :-
    % find length of tail
    getLength(TAIL, TAILSIZE),
    % add the size of the head element to the sizeof the tail
    SIZE is 1 + TAILSIZE.
    