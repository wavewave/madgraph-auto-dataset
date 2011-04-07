module HEP.Automation.MadGraph.Dataset.Set20110307set2 where


import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.Cluster
import HEP.Automation.MadGraph.SetupType

import HEP.Automation.MadGraph.Dataset.Common
import HEP.Automation.MadGraph.Dataset.SUSY

import HEP.Automation.MadGraph.Model.ZpH

{-
my_ssetup :: ScriptSetup
my_ssetup = SS {
    scriptbase = "/home/wavewave/nfs/workspace/ttbar/mc_script/"
  , mg5base    = "/home/wavewave/nfs/montecarlo/MG_ME_V4.4.44/MadGraph5_v0_6_1/"
  , workbase   = "/home/wavewave/nfs/workspace/ttbar/mc/"
  }
-}

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

psetup_zp_ttbar01j :: ProcessSetup ZpH
psetup_zp_ttbar01j = PS {  
    mversion = MadGraph4
  , model = ZpH
  , process = processTTBar0or1jet 
  , processBrief = "ttbar01j"  
  , workname   = "307ZpH1J"
  }

my_csetup :: ClusterSetup
my_csetup = CS { cluster = Parallel 3 }

zpparamset :: [ModelParam ZpH]
zpparamset = [ ZpHParam mass g | mass <- [400.0] , g <- [1.75] ] 
          

psetuplist :: [ProcessSetup ZpH]
psetuplist = [ psetup_zp_ttbar01j ]

sets :: [Int]
sets = [1..10]

zptasklist :: [WorkSetup ZpH]
zptasklist =  [ WS my_ssetup (psetup_zp_ttbar01j) 
                              (rsetupGen p MLM (UserCutDef ucut) RunPGS 100000 num) 
                              my_csetup  
                | p <- zpparamset 
                , num <- sets     ]

totaltasklist :: [WorkSetup ZpH]
totaltasklist = zptasklist 



          