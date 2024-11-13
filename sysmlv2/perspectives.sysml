library package 'SCRE Perspectives' {
  doc /* SCRE Stakeholders, Concerns, Viewpoints and Views*/
  private import Views::*;
  private import STPA::*;
  private import KerML::Element::*;

  package <'SS'> 'SCRE Stakeholders' {
    part def 'Systems Engineer';
    part def 'System Operator';
    part def 'Security Analyst';
    part def 'System Test';
  }

  package <'SC'> 'SCRE Concerns' {
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
    view def 'Hazard Analysis View' {
      view def 'Loss View' {
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
  }
  package <'SR'> 'SCRE Renderings' {
    rendering asLossTable :> asElementTable {
      view :>> columnView = (
          (KerML::Element::shortName, ":", KerML::Element::declaredName),
          KerML::Element::documentation,
          STPA::Loss::priority,
          STPA::Loss::isCausedBy) {
        render asTextualNotation;
      }
    }
    rendering asHazardTable :> asElementTable {
      view :>> columnView = (
          KerML::Element::shortName,
          KerML::Element::declaredName,
          KerML::Element::documentation,
          STPA::Hazard::leadsTo,
          STPA::Hazard::isCausedBy) {
        render asTextualNotation;
      }
    }
  }
}