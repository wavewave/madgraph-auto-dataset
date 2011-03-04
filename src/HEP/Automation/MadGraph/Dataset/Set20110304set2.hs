module HEP.Automation.MadGraph.Dataset.Set20110302set3 where


import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.Cluster
import HEP.Automation.MadGraph.SetupType

import HEP.Automation.MadGraph.Dataset.Common

my_ssetup :: ScriptSetup
my_ssetup = SS {
    scriptbase = "/home/wavewave/nfs/workspace/ttbar/mc_script/"
  , mg5base    = "/home/wavewave/nfs/montecarlo/MG_ME_V4.4.44/MadGraph5_v0_6_1/"
  , workbase   = "/home/wavewave/nfs/workspace/ttbar/mc/"
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

psetup_axi_ttbar01j :: ProcessSetup
psetup_axi_ttbar01j = PS {  
    mversion = MadGraph4
  , model = AxiGluon
  , process = processTTBar0or1jet 
  , processBrief = "ttbar01j"  
  , workname   = "302Axi1J"
  }

my_csetup :: ClusterSetup
my_csetup = CS { cluster = Parallel 6 }

axiparamset :: [Param]
axiparamset = [ AxiGluonParam mass 0.0 0.0 ga (-ga) 
              | mass <- [1000.0, 1800.0 .. 2400.0 ]  
              , ga   <- [0.0, 1.2 .. 4.0 ] ] 
          

psetuplist :: [ProcessSetup]
psetuplist = [ psetup_axi_ttbar01j ]

sets :: [Int]
sets = [1]

axitasklist :: [WorkSetup]
axitasklist =  [ WS my_ssetup (psetup_axi_ttbar01j) 
                              (rsetupGen p MLM NoUserCutDef NoPGS 20000 num) 
                              my_csetup  
                | p <- axiparamset 
                , num <- sets     ]

totaltasklist :: [WorkSetup]
totaltasklist = axitasklist 



          