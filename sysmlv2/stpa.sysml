library package STPA {
  doc /* Systems Theoretic Process Analysis */

  private import ScalarValues::*;

  item def Loss {
    doc  
      /* A Loss involves something of value to stakeholders.
      * Losses may include a loss of human life or human injury,
      * property damage, environmental pollution, loss of mission,
      * loss of reputation, loss or leak of sensitive information,
      * or any other loss that is unacceptable to the stakeholders.
      */
    attribute priority: Integer;
    ref isCausedBy : Hazard[1..*];
  }

  item def Hazard {
    doc  
      /* A hazard is a system state or set of conditions that,
      * together with a particular set of worst-case environmental
      * conditions (Environment State), will lead to a loss.
      */
    ref whenEnvironmentStateIs : SysML::StateUsage[1..*];
    ref isCausedBy : HazardousAction[1..*];
    ref leadsTo : Loss[1..*];
  }

  abstract item def ControlAction {
    doc /* A controller provides Control Actions to control some process 
        *  and to enforce constraints on the behavior of the controlled 
        *  process.
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

  item def HazardousAction {
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

  item def LossScenario {
    doc
      /* A loss scenario describes the causal factors (including 
      * 'Adversity Flaw Type' / 'Attack Pattern') that can lead to 
      *  the hazardous control actions and to hazards.
      */
    attribute type: AdversityFlawType;
    attribute attack : AttackType;
    ref leadsTo : HazardousAction[1..*];
  }
}