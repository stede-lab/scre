library package 'SCRE Perspectives' {
  doc /* SCRE Stakeholders, Concerns, Viewpoints and Views*/
  private import Views::*;
  private import STPA::*;
  private import KerML::Element::*;
  private import ScalarValues::*;
  private import Metadata::*;

  metadata def <'SMD'> 'SCRE MetaData' {
    doc /* SCRE Tooling */
    attribute displayName : String;
  }

  package <'SS'> 'SCRE Stakeholders' {
    doc /* A stakeholder is a person, organization or
         * other entity with concerns to be addressed.
         */
    part def 'Systems Engineer';
    part def 'System Operator';
    part def 'Security Analyst';
    part def 'System Test';
  }

  package <'SC'> 'SCRE Concerns' {
    doc /* A concern is a specific topic that one or more
         * stakeholders desire to be addressed.
         */
    concern 'System Control Structure' {
      stakeholder se : SS::'Systems Engineer';
    }
    concern 'Hazardous Actions' {
      stakeholder so : SS::'System Operator';
    }
    concern 'Loss Scenarios' {

    }
    concern 'Sentinel Scenarios' {

    }
    concern 'Assurance Cases' {

    }
    concern 'Resilience Requirements' {

    }
    concern 'Resilience Test Plan' {

    }
  }
  package <'SVP'> 'SCRE Viewpoints' {
    doc /* A viewpoint is a requirement to present information from a model 
         * in a view that addresses certain stakeholder concerns.
         * 
         * A viewpoint frames the concerns that will be
         * addressed by a view that satisfies the viewpoint.
         */
    viewpoint 'System Description' {
      frame SC::'System Control Structure';
      }
    viewpoint 'Hazard Analysis' {
      frame SC::'Hazardous Actions';
    }
    viewpoint 'Loss Scenario Assessment' {
      
    }
    viewpoint 'Resilience Architecture' {

    }
    viewpoint 'Verification and Test Assessment' {

    }
  }
  package <'SV'> 'SCRE Views' {
    doc /* A view definition specifies how information can be extracted
         * from a model in order to satisfy one or more viewpoints.
         * 
         * A view definition can filter the elements to be included in the
         * views it specifies.
         */
    view def <'HAV'> 'Hazard Analysis View' {
      view def <'LV'> 'Loss View' {
        filter @STPA::Loss;
      }
      view def 'Hazard View' {
        filter @STPA::Hazard;
      }
      view def 'Hazardous Action View' {
        filter @STPA::HazardousAction;
      }
      satisfy SVP::'Hazard Analysis';
    }
    view 'SCRE Id' {
      @SMD {displayName = "ID";}
      filter @KerML::Element::shortName;
    }
    view 'SCRE Name' {
      @SMD {displayName = "Name";}
      filter @KerML::Element::declaredName;
    }
  }
  package <'SR'> 'SCRE Renderings' {
    doc /* The Views library package includes four basic kinds of rendering: 
         * asTreeDiagram, asInterconnectionDiagram, asTextualNotation 
         * and asElementTable.
         * Specialized kinds of renderings can be defined*/
    rendering asLossTable :> asElementTable {
      view :>> columnView = (
          (SV::'SCRE Id', ":", SV::'SCRE Name'),
          KerML::Element::documentation,
          STPA::Loss::priority,
          STPA::Loss::isCausedBy) {
        render asTextualNotation;
      }
    }
    rendering asHazardTable :> asElementTable {
      view :>> columnView = (
          (SV::'SCRE Id', ":", SV::'SCRE Name'),
          KerML::Element::documentation,
          STPA::Hazard::leadsTo,
          STPA::Hazard::isCausedBy) {
        render asTextualNotation;
      }
    }
  }
}