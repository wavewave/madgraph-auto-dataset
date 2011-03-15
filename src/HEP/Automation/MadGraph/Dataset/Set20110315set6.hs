module HEP.Automation.MadGraph.Dataset.Set20110315set6 where


import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.Cluster
import HEP.Automation.MadGraph.SetupType

import HEP.Automation.MadGraph.Dataset.Common

my_ssetup :: ScriptSetup
my_ssetup = SS {
    scriptbase = "/nobackup/iankim/nfs/workspace/ttbar/mc_script/"
  , mg5base    = "/nobackup/iankim/montecarlo/MG_ME_V4.4.44/MadGraph5_v0_6_1/"
  , workbase   = "/nobackup/iankim/nfs/workspace/ttbar/mc/"
  }


processTTBar0or1jet :: [Char]
processTTBar0or1jet =  
  "\ngenerate P P > t t~  QED=99 @1 \nadd process P P > t t~ J QED=99 @2 \n"

psetup_six_ttbar01j :: ProcessSetup
psetup_six_ttbar01j = PS {  
    mversion = MadGraph5
  , model = Six
  , process = processTTBar0or1jet 
  , processBrief = "ttbar01j"  
  , workname   = "315Six1J"
  }

my_csetup :: ClusterSetup
my_csetup = CS { cluster = Parallel 10 }

sixparamset :: [Param]
sixparamset = [ SixParam mass g 
                    | mass <- [500.0] -- .. 800.0 ]  
                    , g   <- [0.6, 0.8 .. 4.0 ] ] 
          

psetuplist :: [ProcessSetup]
psetuplist = [ psetup_six_ttbar01j ]

sets :: [Int]
sets = [1]

sixtasklist :: [WorkSetup]
sixtasklist =  [ WS my_ssetup (psetup_six_ttbar01j) 
                        (rsetupGen p MLM NoUserCutDef NoPGS 20000 num) 
                        my_csetup  
                 | p <- sixparamset , num <- sets     ]

totaltasklist :: [WorkSetup]
totaltasklist = sixtasklist 



          