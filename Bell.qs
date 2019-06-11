namespace Quantum.Tangles
{
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

    operation Set (desired: Result, q1: Qubit) : Unit {
        if (desired != M(q1)) {
            X(q1);
        }
    }

    operation TanglesTest (count : Int, initial: Result) : (Int, Int, Int) {
        mutable aliveCount = 0;
        mutable agree = 0;
        using ((qAtomicState, qFelineLife) = (Qubit(), Qubit())) {
            for (test in 1..count) {
                Set (initial, qAtomicState);
                Set (Zero, qFelineLife);
                H(qAtomicState);
                // Tangle the cat's life with the atomic state:
                CNOT(qAtomicState, qFelineLife);
                let res = M (qAtomicState);

                if (M(qFelineLife) == res) {
                    set agree += 1;
                }

                if (res == One) {
                    set aliveCount += 1;
                }
            }
            Set(Zero, qAtomicState);
            Set(Zero, qFelineLife);
        }
        return (count-aliveCount, aliveCount, agree);
    }
}
