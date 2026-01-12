month("January").
month("February").
month("March").
month("April").
month("May").
month("June").
month("July").
month("August").
month("September").
month("October").
month("November").
month("December").

month("January",1).
month("February",2).
month("March",3).
month("April",4).
month("May",5).
month("June",6).
month("July",7).
month("August",8).
month("September",9).
month("October",10).
month("November",11).
month("December",12).

isMember([H|_], H).
isMember([_|T], H) :- isMember(T, H).

date(D,M,Y):- D > 0, D < 29, month(M), integer(Y),!.
date(D,M,Y):- D > 0, D < 31, month(M,N), isMember([4,6,9,11],N), integer(Y),!.
date(D,M,Y):- D > 0, D < 32, month(M,N), isMember([1,3,5,7,8,10,12],N), integer(Y),!.
date(29,"February",Y):- Y mod 400 =:= 0, !.
date(29,"February",Y):- Y mod 4 =:= 0, Y mod 100 =\= 0.

less(date(_,_,Y1), date(_,_,Y2)):- Y1 < Y2, !.
less(date(_,M1,Y), date(_,M2,Y)):- month(M1,N1), month(M2,N2), N1 < N2, !.
less(date(D1,M,Y), date(D2,M,Y)):- D1 < D2.

successor(date(D,M,Y), date(DD,M,Y)):- date(D,M,Y), DD is D+1, date(DD,M,Y), !.
successor(date(D,M,Y), date(1,MM,Y)):- date(D,M,Y), month(M,N), NN is N + 1, month(MM,NN), date(1,MM,Y), !.
successor(date(D,M,Y), date(1,"January",YY)):- date(D,M,Y), YY is Y+1.

predecessor(date(D,M,Y), date(DD,M,Y)):- date(D,M,Y), DD is D-1, date(DD,M,Y), !.
predecessor(date(D,M,Y), date(31,MM,Y)):- date(D,M,Y), month(M,N), NN is N - 1, month(MM,NN), date(31,MM,Y), !.
predecessor(date(D,M,Y), date(30,MM,Y)):- date(D,M,Y), month(M,N), NN is N - 1, month(MM,NN), date(30,MM,Y), !.
predecessor(date(D,M,Y), date(29,MM,Y)):- date(D,M,Y), month(M,N), NN is N - 1, month(MM,NN), date(29,MM,Y), !.
predecessor(date(D,M,Y), date(28,MM,Y)):- date(D,M,Y), month(M,N), NN is N - 1, month(MM,NN), date(28,MM,Y), !.
predecessor(date(D,M,Y), date(31,"December",YY)):- date(D,M,Y), YY is Y-1.

%diffDays(Date1, Date2, Diff):- py_call(example_2:daysDiff(Date1, Date2), Diff).
%diffDays(Date1, Date1, 0).
%diffDays(Date1, Date2, Diff):- less(Date1, Date2), successor(Date1, D1), diffDays(D1, Date2, Diff1), Diff is Diff1 + 1.
%diffDays(Date1, Date2, Diff):- less(Date2, Date1), predecessor(Date1, D1), diffDays(D1, Date2, Diff1), Diff is Diff1 - 1.

daysFromDate(Date1, Diff, Date2):- diffDays(Date1, Date2, Diff).

weekday("Monday"):-!.
weekday("Tuesday"):-!.
weekday("Wednesday"):-!.
weekday("Thursday"):-!.
weekday("Friday"):-!.
weekday("Saturday"):-!.
weekday("Sunday"):-!.

weekday("Monday",1):-!.
weekday("Tuesday",2):-!.
weekday("Wednesday",3):-!.
weekday("Thursday",4):-!.
weekday("Friday",5):-!.
weekday("Saturday",6):-!.
weekday("Sunday",7):-!.

weekday(date(4,"November",2025),"Tuesday"):-!.
weekday(Date,DayName):- diffDays(Date,date(4,"November",2025),Diff), DayNumber is (abs(Diff) mod 7)+1, write(DayNumber), write(" "), weekday(DayName,DayNumber).

goal:-weekday(date(24,"December",2025) ,X), write(X), fail.