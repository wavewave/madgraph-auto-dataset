module HEP.Automation.MadGraph.Dataset.Set20110412set1 where


import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.Cluster
import HEP.Automation.MadGraph.SetupType

import HEP.Automation.MadGraph.Model.Singlet

import HEP.Automation.MadGraph.Dataset.Common

import qualified Data.ByteString as B

processTTBar :: [Char]
processTTBar =  
  "\ngenerate P P > t t~ QED=99\n"

psetup_singlet_ttbar :: ProcessSetup Singlet
psetup_singlet_ttbar = PS {  
    mversion = MadGraph4
  , model = Singlet
  , process = processTTBar
  , processBrief = "ttbar" 
  , workname   = "411Singlet_TTBar"
  }

singletParamSet :: [ModelParam Singlet]
singletParamSet = [ SingletParam m g (0.28) 
                    | m <-[135.0, 140.0 .. 155.0] 
                    , g <- [1.0, 1.05 .. 2.00] ] 
          

psetuplist :: [ProcessSetup Singlet]
psetuplist = [ psetup_singlet_ttbar ]

sets :: [Int]
sets = [1]

singlettasklist :: ScriptSetup -> ClusterSetup -> [WorkSetup Singlet]
singlettasklist ssetup csetup =  
  [ WS ssetup (psetup_singlet_ttbar) 
       (rsetupGen p NoMatch NoUserCutDef NoPGS 10000 num) 
       csetup  
  | p <- singletParamSet , num <- sets     ]


totaltasklist :: ScriptSetup -> ClusterSetup -> [WorkSetup Singlet]
totaltasklist = singlettasklist 



          