module HEP.Automation.MadGraph.Dataset.Set20110411set1 where

import HEP.Storage.WebDAV

import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.SetupType

import HEP.Automation.MadGraph.Model.ZpHFull

import HEP.Automation.MadGraph.Dataset.Common

import qualified Data.ByteString as B

processTTBar :: [Char]
processTTBar =  
  "\ngenerate P P > t t~ QED=99\n"

psetup_zphfull_ttbar :: ProcessSetup ZpHFull
psetup_zphfull_ttbar = PS {  
    mversion = MadGraph4
  , model = ZpHFull
  , process = processTTBar
  , processBrief = "ttbar" 
  , workname   = "411ZpH_TTBar"
  }

zpHFullParamSet :: [ModelParam ZpHFull]
zpHFullParamSet = [ ZpHFullParam m g (0.28) 
                    | m <- ([135.0, 140.0 .. 155.0] ++ [160.0, 165.0, 170.0 ])
                    , g <- [0.70, 0.75 .. 1.40] ] 
          

psetuplist :: [ProcessSetup ZpHFull]
psetuplist = [ psetup_zphfull_ttbar ]

sets :: [Int]
sets = [1]

zptasklist :: ScriptSetup -> ClusterSetup ZpHFull -> [WorkSetup ZpHFull]
zptasklist ssetup csetup =  
  [ WS ssetup (psetup_zphfull_ttbar) 
       (rsetupGen p NoMatch NoUserCutDef NoPGS 10000 num) 
       csetup  
       (WebDAVRemoteDir "mc/TeVatronFor3/ZpHFull0411ScanTTBar")
  | p <- zpHFullParamSet , num <- sets     ]


totaltasklist :: ScriptSetup -> ClusterSetup ZpHFull -> [WorkSetup ZpHFull]
totaltasklist = zptasklist 



          