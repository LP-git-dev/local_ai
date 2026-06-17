using { /Verse.org/Simulation }

sort_array(Values:[]int):[]int =
    var Sorted:[]int = Values
    var I:int = 0

    loop:
        if (I >= Length(Sorted)):
            break

        var J:int = 0
        loop:
            if (J >= Length(Sorted) - 1):
                break

            if (Sorted[J] > Sorted[J + 1]):
                var Temp:int = Sorted[J]
                set Sorted[J] = Sorted[J + 1]
                set Sorted[J + 1] = Temp

            set J = J + 1

        set I = I + 1

    return Sorted
