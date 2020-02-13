#| ___
a--|  \
   |   |--out
b--|__/

a, b = (0, 1) ->
a, b = (1, 1) -> (set-signal! out 1)
a, b = (1, 0) -> (set-signal! out 1) (set-signal! out 0)

The agenda has the two segments represented above. If we use a LIFO system, the output first change to 0 and then changed to 1, which is incorrect.
