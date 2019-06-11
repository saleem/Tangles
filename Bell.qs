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
        using ((q0, q1) = (Qubit(), Qubit())) {
            for (test in 1..count) {
                Set (initial, q0);
                Set (Zero, q1);
                H(q0);
                CNOT(q0, q1);
                let res = M (q0);

                if (M(q1) == res) {
                    set agree += 1;
                }

                if (res == One) {
                    set aliveCount += 1;
                }
            }
            Set(Zero, q0);
            Set(Zero, q1);
        }
        return (count-aliveCount, aliveCount, agree);
    }
}
