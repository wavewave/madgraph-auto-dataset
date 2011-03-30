module HEP.Automation.MadGraph.Dataset.SUSY where


import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.Cluster
import HEP.Automation.MadGraph.SetupType

my_ssetup :: ScriptSetup
my_ssetup = SS {
    scriptbase = "/Users/iankim/mac/workspace/ttbar/mc_script/"
  , mg5base    = "/Users/iankim/mac/montecarlo/MG_ME_V4.4.44/MadGraph5_v0_6_1/"
  , workbase   = "/Users/iankim/mac/workspace/ttbar/mc/"
  }
