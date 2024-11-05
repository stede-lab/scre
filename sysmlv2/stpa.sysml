library package STPA {
  doc /* Systems Theoretic Process Analysis */

  private import ScalarValues::*;

  item def Loss {
    doc  /* A Loss involves something of value to stakeholders.
          * Losses may include a loss of human life or human injury,
          * property damage, environmental pollution, loss of mission,
          * loss of reputation, loss or leak of sensitive information,
          * or any other loss that is unacceptable to the stakeholders.
          */
    attribute title: String;
    attribute priority: Integer;
    ref isCausedBy : Hazard[1..*];
  }

  abstract state def EnvironmentalStates;
  abstract state environmentalStates : EnvironmentalStates;

  abstract item def EnvironmentalItem;
  abstract item environmentalItem : EnvironmentalItem {
    exhibit environmentalStates;
  }

  item def Hazard {
    doc  /* A hazard is a system state or set of conditions that,
          * together with a particular set of worst-case environmental
          * conditions (Environmental State), will lead to a loss.
          */
    attribute title: String;
    ref isCausedBy : HazardousAction[1..*];
    ref leadsTo : Loss[1..*];
  }

  abstract item def ControlAction;
  abstract message controlAction of ControlAction;
  abstract item def FeedBack;
  abstract message feedback of FeedBack;

  enum def VariationType {
    doc /* Control Action variation type */
    enum NotProviding;
    enum Providing;
    enum OutOfSequence;
  }

  item def HazardousAction {
    attribute title : String;
    attribute type : VariationType;
    ref variationOf : ControlAction;
    ref isCausedBy : LossScenario[1..*];
    ref leadsTo : Hazard[1..*];
  }

  item def LossScenario {
    attribute title : String;
    ref leadsTo : HazardousAction[1..*];
  }
}