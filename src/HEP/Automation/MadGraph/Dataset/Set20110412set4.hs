module HEP.Automation.MadGraph.Dataset.Set20110412set4 where

import HEP.Storage.WebDAV

import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.SetupType

import HEP.Automation.MadGraph.Model.Six

import HEP.Automation.MadGraph.Dataset.Common

import qualified Data.ByteString as B

processTTBar :: [Char]
processTTBar =  
  "\ngenerate P P > t t~ QED=99\n"

psetup_six_ttbar :: ProcessSetup Six
psetup_six_ttbar = PS {  
    mversion = MadGraph5
  , model = Six
  , process = processTTBar
  , processBrief = "ttbar" 
  , workname   = "412Six_TTBar"
  }

sixParamSet :: [ModelParam Six]
sixParamSet = [ SixParam m g  
                    | m <-[135.0, 140.0 .. 155.0] 
                    , g <- [0.20, 0.25 .. 1.40] ] 
          

psetuplist :: [ProcessSetup Six]
psetuplist = [ psetup_six_ttbar ]

sets :: [Int]
sets = [1]

sixtasklist :: ScriptSetup -> ClusterSetup Six -> [WorkSetup Six]
sixtasklist ssetup csetup =  
  [ WS ssetup (psetup_six_ttbar) 
       (rsetupGen p NoMatch NoUserCutDef NoPGS 10000 num) 
       csetup  
       (WebDAVRemoteDir "mc/TeVatronFor3/Six0412ScanTTBar")
  | p <- sixParamSet , num <- sets     ]


totaltasklist :: ScriptSetup -> ClusterSetup Six -> [WorkSetup Six]
totaltasklist = sixtasklist 



          