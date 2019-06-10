namespace Quantum.Bell
{
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

    operation Set (desired: Result, q1: Qubit) : Unit {
        if (desired != M(q1)) {
            X(q1);
        }
    }

    operation BellTest (count : Int, initial: Result) : (Int, Int) {

        mutable numOnes = 0;
        using (qubit = Qubit()) {

            for (test in 1..count) {
                Set (initial, qubit);
                H(qubit);
                let res = M (qubit);

                if (res == One) {
                    set numOnes += 1;
                }
            }
            Set(Zero, qubit);
        }
        return (count-numOnes, numOnes);
    }
}
