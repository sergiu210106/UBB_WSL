import sys

print(sys.executable)

import pyswip
from pyswip.easy import Functor, Variable, Atom
from pyswip.prolog import PrologError
from pyswip import Prolog, registerForeign, call, PL_new_atom, PL_new_functor, PL_cons_functor_v
# from datetime import datetime
import datetime

monthnumbers = {datetime.date(1,x,1).strftime('%B'):x for x in range(1,13)}

holidays_lst = [
    datetime.date(2025,1,1),
    datetime.date(2025,1,2),
    datetime.date(2025,1,6),
    datetime.date(2025,1,7),
    datetime.date(2025,1,24),
]

def holidays(date, handle):

    control = pyswip.core.PL_foreign_control(handle)

    index = None
    return_value = False

    if control == pyswip.core.PL_FIRST_CALL:
        index = 0

    if control == pyswip.core.PL_REDO:
        last_index = pyswip.core.PL_foreign_context(handle)
        index = last_index + 1

    if index >= 0 and index < len(holidays_lst):
        date.unify(formatDate(holidays_lst[index]))
        return_value = pyswip.core.PL_retry(index)

    return return_value


def formatDate(date):
    retval = Atom(f'date({date.day}, "{date.strftime("%B")}", {date.year})')
    return retval

def diffDays(date1, date2, diff):
    def date(day, month, year):
        try:
            month = month.decode("utf-8")
        except Exception:
            pass
        return datetime.date(year,monthnumbers[month],day)

    numVariables = sum([int(isinstance(x,Variable)) for x in [date1, date2, diff]])

    if numVariables == 0:
        date1 = eval(str(date1))
        date2 = eval(str(date2))
        return (date2-date1).days == diff
    elif numVariables == 1:
        if isinstance(diff,Variable):
            date1 = eval(str(date1))
            date2 = eval(str(date2))
            diff.value = (date2-date1).days
            return True
        elif isinstance(date1,Variable):
            date2 = eval(date2.value)
            new_date = date2-datetime.timedelta(days=diff)
            date1.unify(formatDate(new_date))
            return True
        elif isinstance(date2,Variable):
            date1 = eval(date1.value)
            new_date = date1+datetime.timedelta(days=diff)
            date2.unify(formatDate(new_date))
            return True
    else:
        raise PrologError("Not sufficienty instanciated")

def daysDiff(date1, date2):
    def date(day, month, year):
        try:
            month = month.decode("utf-8")
        except Exception:
            pass
        return datetime.date(year,monthnumbers[month],day)
    date1 = eval(str(date1))
    date2 = eval(str(date2))
    return (date2-date1).days


if __name__ == "__main__":

    registerForeign(diffDays)
    registerForeign(holidays, arity=1, flags=pyswip.core.PL_FA_NONDETERMINISTIC)

    Prolog.consult("example_2.pl")
    print('-'*80)

    for x in Prolog.query('successor(date(31,"December",2024),X)'):
        print(x)
    print('-'*80)

    # for x in Prolog.query('X, date(1,"December",2024),30)'):
    #     print(x)

    for x in Prolog.query('diffDays(date(31,"December",2024), date(1,"December",2024),X)'):
        print(x)
    print('-'*80)

    for x in Prolog.query('diffDays(X, date(1,"December",2024),-30)'):
        print(x)
    print('-'*80)

    for x in Prolog.query('diffDays(date(31,"December",2024), X,-30)'):
        print(x)
    print('-'*80)

    for x in Prolog.query('diffDays(date(31,"December",2024), date(1,"December",2024),-30)'):
        print(x)
    print('-'*80)

    for x in Prolog.query('diffDays(date(1,"December",2024), date(31,"December",2024),X)'):
        print(x)
    print('-'*80)

    for x in Prolog.query('diffDays(date(1,"December",2024), date(31,"December",2024),30)'):
        print(x)
    print('-'*80)

    for x in Prolog.query('diffDays(date(1,"December",2024), date(31,"December",2024),0)'):
        print(x)
    print('-'*80)

    for x in Prolog.query('daysFromDate(date(1,"December",2024), 30, date(31,"December",2024))'):
        print(x)
    print('-'*80)

    for x in Prolog.query('daysFromDate(X, 30, date(31,"December",2024))'):
        print(x)
    print('-'*80)

    for x in Prolog.query('daysFromDate(date(1,"December",2024), X, date(31,"December",2024))'):
        print(x)
    print('-'*80)

    for x in Prolog.query('daysFromDate(date(1,"December",2024), 30, X)'):
        print(x)
    print('-'*80)

    for x in Prolog.query('weekday(date(1,"December",1) ,X)'):
        print(x)
    print('-'*80)

    for x in Prolog.query('holidays(X)'):
        print(x)
    print('-'*80)

    for x in Prolog.query('holidays(X), diffDays(date(4,"November",2024), X, Y), weekday(X,Z)'):
        print(x)
    print('-'*80)