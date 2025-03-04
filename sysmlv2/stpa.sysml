library package STPA {
  doc /* Systems Theoretic Process Analysis */

  private import ScalarValues::*;

  occurrence def Loss {
    doc  
     /* SysMLv2: Occurrence is the most general class of things 
      * that exist or happen in time and space.
      * 
      * STPA: A Loss involves something of value to stakeholders.
      * Losses may include a loss of human life or human injury,
      * property damage, environmental pollution, loss of mission,
      * loss of reputation, loss or leak of sensitive information,
      * or any other loss that is unacceptable to the stakeholders.
      */
    attribute priority: Integer default 0 {
      doc 
        /* Stakeholder view of importance (1 is most important). Because every 
         * STPA result is traceable to one or more losses, the analysis 
         * results can be easily ranked and prioritized based on the losses to 
         * which they refer. 
         */
    }
    ref isCausedBy : Hazard[1..*];
  }
  abstract state def EnvironmentalState {
    doc /* An environmental state that will cause a Hazard state 
         * to lead to a Loss. 
         */
  }
  state def Hazard {
    doc  
     /* SysMLv2: State is a specific condition or situation in which 
      * a system or part of a system exists.
      *
      * STPA: A hazard is a system state or set of conditions that,
      * together with a particular set of worst-case environmental
      * conditions (Environmental State), will lead to a loss.
      */
    ref whenEnvironmentStateIs : EnvironmentalState[1..*];
    ref isCausedBy : HazardousAction[1..*];
    ref leadsTo : Loss[1..*];
  }

  abstract item def ControlAction {
    doc 
      /* SysMLv2: Item is a general class of identifiable objects that may 
       * be acted on over time, but which do not necessarily perform 
       * actions themselves. Items can be used to represent inputs 
       * and outputs to actions such as water, fuel, electrical signals 
       * and data.
       *
       * STPA: A controller provides Control Actions to control some process 
       * and to enforce constraints on the behavior of the controlled 
       * process.
       */
  }
  abstract item def Feedback {
    doc /* Feedback is used to observe the controlled process. */
  }

  enum def VariationType {
    doc /* Control Action: 'Variation Type' */
    enum NotProviding;
    enum Providing;
    enum OutOfSequence;
  }

  item def HazardousAction :> ControlAction {
    doc
      /* A Hazardous Action is a control action that, in a particular 
       * context (Controller State) and worst-case environment, will 
       * lead to a hazard.
       * There are three ways (Variation Type) a control action can be 
       * hazardous:
          1. Not providing the control action leads to a hazard.
          2. Providing the control action leads to a hazard.
          3. Providing a potentially safe control action but too early, 
             too late, or in the wrong order.
      */
    attribute type : VariationType;
    ref whenControllerStateIs: SysML::StateUsage[1..*];
    ref variationOf : ControlAction;
    ref isCausedBy : LossScenario[1..*];
    ref leadsTo : Hazard[1..*];
  }

  enum def AdversityFlawType {
    doc /* Control Structure: 'Adversity Flaw Type' */
    enum Controller;
    enum ControlPath;
    enum ControlledProcess;
    enum FeedbackPath;
  }
  enum def AttackType {
    doc /* MITRE CAPEC: Meta-Attack Patterns */
    enum 'Communications: CAPEC-594: Traffic Injection';
    enum 'Software: CAPEC-549: Local Execution of Code';
    enum 'Supply Chain: CAPEC-438: Modification During Manufacture';
    enum 'Supply Chain: CAPEC-439: Manipulation During Distribution';
  }

  action def LossScenario {
    doc
     /* SysMLv2: Action represents a unit of behavior or activity that 
      * can be performed by a system or its parts.
      *
      * STPA: A loss scenario describes the causal factors (including 
      * 'Adversity Flaw Type' / 'Attack Pattern') that can lead to 
      * hazardous control actions and to hazards.
      */
    attribute type: AdversityFlawType;
    attribute attack : AttackType;
    ref leadsTo : HazardousAction[1..*];
  }
}