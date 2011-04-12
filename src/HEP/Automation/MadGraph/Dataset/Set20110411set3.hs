module HEP.Automation.MadGraph.Dataset.Set20110411set3 where


import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.Cluster
import HEP.Automation.MadGraph.SetupType

import HEP.Automation.MadGraph.Model.ZpHFull

import HEP.Automation.MadGraph.Dataset.Common

import qualified Data.ByteString as B

processTZpLep :: [Char]
processTZpLep =  
  "\ngenerate P P > t zput QED=99, zput > b~ d, ( t > b w+, w+ > l+ vl ) @1 \nadd process P P > t~ zptu QED=99, (t~ > b~ w-, w- > l- vl~ ), zptu > b d~ @2 \n"

psetup_zphfull_TZpLep :: ProcessSetup ZpHFull
psetup_zphfull_TZpLep = PS {  
    mversion = MadGraph4
  , model = ZpHFull
  , process = processTZpLep
  , processBrief = "TZpLep" 
  , workname   = "411ZpH_TZpLep"
  }

zpHFullParamSet :: [ModelParam ZpHFull]
zpHFullParamSet = [ ZpHFullParam m g (0.28) 
                    | m <-[135.0, 140.0 .. 155.0] 
                    , g <- [0.70, 0.75 .. 1.40] ] 
          
psetuplist :: [ProcessSetup ZpHFull]
psetuplist = [ psetup_zphfull_TZpLep ]

sets :: [Int]
sets = [1]

zptasklist :: ScriptSetup -> ClusterSetup -> [WorkSetup ZpHFull]
zptasklist ssetup csetup =  
  [ WS ssetup (psetup_zphfull_TZpLep) 
       (rsetupGen p NoMatch NoUserCutDef NoPGS 10000 num) 
       csetup  
  | p <- zpHFullParamSet , num <- sets     ]


totaltasklist :: ScriptSetup -> ClusterSetup -> [WorkSetup ZpHFull]
totaltasklist = zptasklist 
