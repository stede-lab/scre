library package FOREST {
  doc /* Framework for Operational Resilience
       *  in Engineering and System Test 
       */
  
  private import ScalarValues::*;
  private import CollectionFunctions::*;
  private import STPA::LossScenario;

  package Prevention {
    doc /* Defensive security focuses on 'preventing' attacks. */
    
    occurrence def AssuranceCase {
      doc /* A reasoned, auditable artifact created that supports
           * the contention that its top-level claim (or set of claims), 
           * is satisfied, including systematic argumentation and its 
           * underlying evidence and explicit assumptions that support 
           * the claim(s). 
           */
      ref definedBy : Claim[1..*];
      ref reducesLikelihoodOf : LossScenario[1..*];
    }
    occurrence def Claim {
      doc /* A statement (pattern) that needs to be supported by evidence 
           * and reasoning. 
           */
      ref isSupportedBy : Reasoning[1..*];
    }
    occurrence def Reasoning {
      doc /* An explanation of how the evidence supports the claim. */
      ref using : Evidence[1..*];
    }
    occurrence def Evidence {
      doc /* Data or information that supports the claim. */
    }
  }

  package Recovery {
    doc /* Resilience focuses on 'recovering' from abnormal system
         * behavior, which may be indicative of an attack. 
         */
    
    part def Sentinel {
      doc /* An architecural component that is responsible for 
           * evaluating a set of resilience cases.
           */
      ref evaluates : ResilienceCase[1..*];

      action def evaluate {
        for i in 1..evaluates->size() {
          
        }
      
      }

      requirement def <'SEN.1'> SentinelResilienceCases {
        doc /* The Sentinal shall continuously evaluate all 
             * assigned, enabled, resilience cases. */

        subject sentinel : Sentinel;

      }
    }

    
    abstract occurrence def ResilienceCase {
      doc /* A set of mechanisms for monitoring abnormal 
           * system behavior, which is indicative of a
           * Loss Scenario, and which is to be protected against 
           * via system reconfiguration using appropriate resilient 
           * modes of operation.
           */
      attribute enabled : Boolean = false;
      ref reducesConsequenceOf : LossScenario[1..*];
      ref detectsLossUsing : Monitor[1..*];
      ref reconfiguresUsing : ResilientMode[1..*];
      action def execute {

      }
    }

    item def Parameter {
      doc /* A FOREST-based measurement tracked over the system lifecyle. */
      attribute required : ScalarValue; /* system requirements target */
      attribute design : ScalarValue;   /* system design achieved     */
      attribute observed : ScalarValue; /* system test observed       */
    }

    abstract action def Monitor {
      doc /* A pattern for monitoring system behavior, using probes, in 
           * order to detect abnormal system behavior.
           */
      ref usingInputFrom : Probe[1..*];
      ref senseTime : Parameter;
      abstract action def sense {

      }
    }

    abstract part def Probe {
      doc /* An architectural component that collects and reports 
           * operational data from the system / mission of interest.
           */
      ref reportTo : Monitor[1..*];
    }

    abstract occurrence def ResilientMode {
      doc /* A pattern for an alternative mode of system operation which limits 
           * the system / mission impact of a particular set of Loss Scenarios.
           */
      abstract action def activate {

      }
      ref activateTime : Parameter;
    }
  }
}