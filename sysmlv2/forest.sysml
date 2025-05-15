library package FOREST {
  doc /* Framework for Operational Resilience
       *  in Engineering and System Test 
       */
  
  private import ScalarValues::*;
  private import STPA::LossScenario;

  package Prevention {
    doc /* Defensive security focuses on 'preventing' attacks. */
    
    abstract item def AssuranceCase {
      doc /* A reasoned, auditable artifact created that supports
           * the contention that its top-level claim (or set of claims), 
           * is satisfied, including systematic argumentation and its 
           * underlying evidence and explicit assumptions that support 
           * the claim(s). 
           */
      ref definedBy : Claim[1..*];
      ref reducesLikelihoodOf : LossScenario[1..*];
    }
    abstract item def Claim {
      doc /* A statement (pattern) that needs to be supported by evidence 
           * and reasoning. 
           */
      ref isSupportedBy : Reasoning[1..*];
    }
    abstract item def Reasoning {
      doc /* An explanation of how the evidence supports the claim. */
      ref using : Evidence[1..*];
    }
    abstract item def Evidence {
      doc /* Data or information that supports the claim. */
    }
  }

  package Recovery {
    doc /* Resilience focuses on 'recovering' from abnormal system
         * behavior, which may be indicative of an attack. 
         */
    
    abstract part def Sentinel {
      doc /* An architecural component that is responsible for 
           * evaluating a set of resilience cases.
           */
      ref evaluates : ResilienceCase[1..*];
    }
    
    abstract item def ResilienceCase {
      doc /* A set of mechanisms for monitoring abnormal 
           * system behavior, which is indicative of a
           * Loss Scenario, and which is to be protected against 
           * via system reconfiguration using appropriate resilient 
           * modes of operation.
           */
      ref reducesConsequenceOf : LossScenario[1..*];
      ref detectsLossUsing : Monitor[1..*];
      ref reconfiguresUsing : ResilientMode[1..*];
    }

    abstract action def Monitor {
      doc /* */
    }

    abstract part def Probe {
      doc /* */

    }
    abstract occurrence def ResilientMode {
      doc /* */
    }
  }
}