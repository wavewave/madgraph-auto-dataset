module HEP.Automation.MadGraph.Dataset.Set20110421set1 where

import HEP.Storage.WebDAV

import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.SetupType

import HEP.Automation.MadGraph.Model.ZpHFull

import HEP.Automation.MadGraph.Dataset.Common
import HEP.Automation.MadGraph.Dataset.Processes


import qualified Data.ByteString as B

psetup_zphfull_TTtest :: ProcessSetup ZpHFull
psetup_zphfull_TTtest = PS {  
    mversion = MadGraph4
  , model = ZpHFull
  , process = preDefProcess TTBar
  , processBrief = "TT" 
  , workname   = "421ZpH_TT_test"
  }

zpHFullParamSet :: [ModelParam ZpHFull]
zpHFullParamSet = [ ZpHFullParam m g (0.28) 
                    | m <-[135.0], g <- [0.70] ] 
          

psetuplist :: [ProcessSetup ZpHFull]
psetuplist = [ psetup_zphfull_TTtest ]

sets :: [Int]
sets = [1]

zptasklist :: ScriptSetup -> ClusterSetup ZpHFull -> [WorkSetup ZpHFull]
zptasklist ssetup csetup =  
  [ WS ssetup (psetup_zphfull_TTtest) 
       (RS { param = p
           , numevent = 10000
           , machine = TeVatron 
           , rgrun   = Fixed
           , rgscale = 200.0
           , match   = NoMatch
           , cut     = DefCut 
           , pythia  = NoPYTHIA
           , usercut = NoUserCutDef
           , pgs     = NoPGS 
           , setnum  = num 
           })
       csetup  
       (WebDAVRemoteDir "mc/test/iwtest/test")
  | p <- zpHFullParamSet , num <- sets     ]


totaltasklist :: ScriptSetup -> ClusterSetup ZpHFull -> [WorkSetup ZpHFull]
totaltasklist = zptasklist 



          