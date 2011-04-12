module HEP.Automation.MadGraph.Dataset.Set20110411set4 where


import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.Cluster
import HEP.Automation.MadGraph.SetupType

import HEP.Automation.MadGraph.Model.ZpHFull

import HEP.Automation.MadGraph.Dataset.Common

import qualified Data.ByteString as B

processTTBarSemiZpXSec :: [Char]
processTTBarSemiZpXSec =  
  "\ngenerate P P > t t~ QED=99, t > b w+, t~ > u~ zput @1 \nadd process P P > t t~ QED=99, t > u zptu, t~ > b~ w- @2 \n"

psetup_zphfull_TTBarSemiZpXSec :: ProcessSetup ZpHFull
psetup_zphfull_TTBarSemiZpXSec = PS {  
    mversion = MadGraph4
  , model = ZpHFull
  , process = processTTBarSemiZpXSec
  , processBrief = "TTBarSemiZpXSec" 
  , workname   = "411ZpH_TTBarSemiZpXSec"
  }

zpHFullParamSet :: [ModelParam ZpHFull]
zpHFullParamSet = [ ZpHFullParam m g (0.28) 
                    | m <-[135.0, 140.0 .. 155.0] 
                    , g <- [0.70, 0.75 .. 1.40] ] 
          
psetuplist :: [ProcessSetup ZpHFull]
psetuplist = [ psetup_zphfull_TTBarSemiZpXSec ]

sets :: [Int]
sets = [1]

zptasklist :: ScriptSetup -> ClusterSetup -> [WorkSetup ZpHFull]
zptasklist ssetup csetup =  
  [ WS ssetup (psetup_zphfull_TTBarSemiZpXSec) 
       (rsetupGen p NoMatch NoUserCutDef NoPGS 10000 num) 
       csetup  
  | p <- zpHFullParamSet , num <- sets     ]


totaltasklist :: ScriptSetup -> ClusterSetup -> [WorkSetup ZpHFull]
totaltasklist = zptasklist 
