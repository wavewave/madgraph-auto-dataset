module HEP.Automation.MadGraph.Dataset.Set20110316set9 where


import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.Cluster
import HEP.Automation.MadGraph.SetupType

import HEP.Automation.MadGraph.Dataset.Common

my_ssetup :: ScriptSetup
my_ssetup = SS {
    scriptbase = "/nobackup/iankim/nfs/workspace/ttbar/mc_script2/"
  , mg5base    = "/nobackup/iankim/montecarlo/MG_ME_V4.4.44/MadGraph5_v0_6_1/"
  , workbase   = "/nobackup/iankim/nfs/workspace/ttbar/mc/"
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

psetup_six_ttbar01j :: ProcessSetup
psetup_six_ttbar01j = PS {  
    mversion = MadGraph5
  , model = Six
  , process = processTTBar0or1jet 
  , processBrief = "ttbar01j"  
  , workname   = "316Six1JBig2"
  }

my_csetup :: ClusterSetup
my_csetup = CS { cluster = Parallel 10 }

sixparamset :: [Param]
sixparamset = [ SixParam mass g 
                    | mass <- [1400.0] 
                    , g   <- [4.0]  ] 
          

psetuplist :: [ProcessSetup]
psetuplist = [ psetup_six_ttbar01j ]

sets :: [Int]
sets = [41..50]

sixtasklist :: [WorkSetup]
sixtasklist =  [ WS my_ssetup (psetup_six_ttbar01j) 
                        (rsetupGen p MLM (UserCutDef ucut) RunPGS 100000 num) 
                        my_csetup  
                 | p <- sixparamset , num <- sets     ]

totaltasklist :: [WorkSetup]
totaltasklist = sixtasklist 



          