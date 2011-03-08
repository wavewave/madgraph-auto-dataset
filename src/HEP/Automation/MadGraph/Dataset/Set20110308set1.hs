module HEP.Automation.MadGraph.Dataset.Set20110308set1 where


import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.Cluster
import HEP.Automation.MadGraph.SetupType

import HEP.Automation.MadGraph.Dataset.Common

my_ssetup :: ScriptSetup
my_ssetup = SS {
    scriptbase = "/Users/iankim/mac/workspace/ttbar/mc_script/"
  , mg5base    = "/Users/iankim/mac/montecarlo/MG_ME_V4.4.44/MadGraph5_v0_6_1/"
  , workbase   = "/Users/iankim/mac/workspace/ttbar/mc/"
  }

ucut :: UserCut
ucut = UserCut { 
    uc_metcut    = 15.0 
  , uc_etacutlep = 1.2 
  , uc_etcutlep  = 18.0
  , uc_etacutjet = 2.5
  , uc_etcutjet  = 15.0 
}

processTTBar0or1jet :: [Char]
processTTBar0or1jet =  
  "\ngenerate P P > t t~  QED=99 @1 \nadd process P P > t t~ J QED=99 @2 \n"

psetup_trip_ttbar01j :: ProcessSetup
psetup_trip_ttbar01j = PS {  
    mversion = MadGraph5
  , model = Trip
  , process = processTTBar0or1jet 
  , processBrief = "ttbar01j"  
  , workname   = "308Trip1J"
  }

my_csetup :: ClusterSetup
my_csetup = CS { cluster = Parallel 3 }

tripparamset :: [Param]
tripparamset = [ TripParam mass g 
              | mass <- [600.0]  
              , g   <- [4.0] ] 
          

psetuplist :: [ProcessSetup]
psetuplist = [ psetup_trip_ttbar01j ]

sets :: [Int]
sets = [1..50]

triptasklist :: [WorkSetup]
triptasklist =  [ WS my_ssetup (psetup_trip_ttbar01j) 
                              (rsetupGen p MLM (UserCutDef ucut) RunPGS 100000 num) 
                              my_csetup  
                | p <- tripparamset 
                , num <- sets     ]

totaltasklist :: [WorkSetup]
totaltasklist = triptasklist 



          