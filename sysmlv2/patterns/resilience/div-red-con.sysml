library package <'DRC'> DiverseRedundantConnection {
  doc /* */
  
  private import FOREST::Recovery::ResilientMode;

  abstract connection def DRConnection :> ResilientMode {
    doc /* Diverse Redundant Connection Resilient Mode */
  }

}