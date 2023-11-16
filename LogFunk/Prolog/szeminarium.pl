%kicsereli az i. elemet
replace_elem([], _, _, []).

replace_elem([_H|T], 1, New, [New|T]):-
    !.

replace_elem([H|T], Index, New, [H|T2]):-
    %Index>1,
    Index2 is Index - 1,
    replace_elem(T, Index2, New, T2).

% -----------------------------------------
%i. elem = az elso i elem osszege
integral_list([], _, []).

integral_list([H|T], Acc, [Acc2|T2]):-
    Acc2 is Acc + H,
    integral_list(T, Acc2, T2).

integral_list(L1, L2):-
    integral_list(L1, 0, L2).

% -----------------------------------------
%osszefesules, novekvo sorrendben
merge_list([], L1, L1):-
    !.

merge_list(L1, [], L1).

merge_list([H|T1], [H2|T2], [H|T3]):-
    H =< H2,
    merge_list(T1, [H2|T2], T3),
    !.

merge_list(L, [H2|T2], [H2|T3]):-
    merge_list(L, T2, T3).

% -----------------------------------------
%lista egyszerusites
compress([], []).

compress([H|T], Er):-
    compress(T, H, Er).

compress([], E, [E]).

compress([H|T], E, [E|Er]):-
    H\=E,
    compress(T, H, Er),
    !.

compress([H|T], H, Er):-
    compress(T, H, Er).

% -----------------------------------------
%variacio
varnk(_, 0, []):-!.

varnk(L, Szam, [S|T]):-
    select2(S, L, M),
    Szam2 is Szam-1,
    varnk(M, Szam2, T).

select2(H, [H|T], T).

select2(E, [H|T], [H|T2]):-
    select2(E, T, T2).

% -----------------------------------------










