module HEP.Automation.MadGraph.Dataset.Set20110407set1 where


import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.Cluster
import HEP.Automation.MadGraph.SetupType

import HEP.Automation.MadGraph.Dataset.Common
import HEP.Automation.MadGraph.Dataset.SUSY

import HEP.Automation.MadGraph.Model.SM

import qualified Data.ByteString as B

processHW :: [Char]
processHW =  
  "\ngenerate P P > h w+ QED=99 @1\nadd process P P > h w- QED=99 @2" 

psetup_sm_hw :: ProcessSetup SM
psetup_sm_hw = PS {  
    mversion = MadGraph5
  , model = SM
  , process = processHW
  , processBrief = "hw"  
  , workname   = "407SM_HW"
  }

my_csetup :: ClusterSetup
my_csetup = CS { cluster = Parallel 3 }

smFullParamSet :: [ModelParam SM]
smFullParamSet = [ SMParam ]
          

psetuplist :: [ProcessSetup SM]
psetuplist = [ psetup_sm_hw ]

sets :: [Int]
sets = [1]

smtasklist :: [WorkSetup SM]
smtasklist =  [ WS my_ssetup (psetup_sm_hw) 
                     (rsetupGen p NoMatch NoUserCutDef NoPGS 20000 num) 
                     my_csetup  
                 | p <- smFullParamSet , num <- sets     ]



totaltasklist :: [WorkSetup SM]
totaltasklist = smtasklist 



          