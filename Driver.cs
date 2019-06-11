using System;

using Microsoft.Quantum.Simulation.Core;
using Microsoft.Quantum.Simulation.Simulators;

using Quantum.Tangles;

namespace Quantum.Tangles
{
    class Driver
    {
        static void Main(string[] args)
        {
            using (var qsim = new QuantumSimulator())
            {
               Result[] initials = new Result[] { Result.Zero, Result.One};
               foreach (Result initial in initials)
               {
                   var res = TanglesTest.Run(qsim, 1000, initial).Result;
                   var (deadCount, aliveCount, agree) = res;
                   System.Console.WriteLine($"Init: {initial, -4} Deaths = {deadCount, -4}, Lives = {aliveCount, -4} agree={agree,-1}");
               }
            }
        }
    }
}