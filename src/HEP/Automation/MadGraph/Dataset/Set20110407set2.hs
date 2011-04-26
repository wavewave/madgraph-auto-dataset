module HEP.Automation.MadGraph.Dataset.Set20110407set2 where

import HEP.Storage.WebDAV

import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.SetupType

import HEP.Automation.MadGraph.Model.ZpHFull

import HEP.Automation.MadGraph.Dataset.Common

import qualified Data.ByteString as B

processTopZpDecay :: [Char]
processTopZpDecay =  
  "\ngenerate P P > t zput QED=99, t > b w+, zput > b~ d @1 \nadd process P P > t~ zptu QED=99, zptu > b d~, t~ > b~ w- @2\n"

psetup_zphfull_TopZpDecay :: ProcessSetup ZpHFull
psetup_zphfull_TopZpDecay = PS {  
    mversion = MadGraph4
  , model = ZpHFull
  , process = processTopZpDecay
  , processBrief = "TopZpDecay" 
  , workname   = "407ZpH_TopZpDecay"
  }

zpHFullParamSet :: [ModelParam ZpHFull]
zpHFullParamSet = [ ZpHFullParam m g g 
                    | m <-[150.0] 
                    , g <- [0.7*sqrt 2] ] 
          

psetuplist :: [ProcessSetup ZpHFull]
psetuplist = [ psetup_zphfull_TopZpDecay ]

sets :: [Int]
sets = [1]

zptasklist :: ScriptSetup -> ClusterSetup ZpHFull -> [WorkSetup ZpHFull]
zptasklist ssetup csetup =  
  [ WS ssetup (psetup_zphfull_TopZpDecay) 
       (rsetupGen p NoMatch NoUserCutDef NoPGS 20000 num) 
       csetup  
       (WebDAVRemoteDir undefined) 
  | p <- zpHFullParamSet , num <- sets     ]


totaltasklist :: ScriptSetup -> ClusterSetup ZpHFull -> [WorkSetup ZpHFull]
totaltasklist = zptasklist 



          