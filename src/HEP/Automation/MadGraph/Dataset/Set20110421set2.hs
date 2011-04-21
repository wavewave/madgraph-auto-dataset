module HEP.Automation.MadGraph.Dataset.Set20110421set2 where

import HEP.Storage.WebDAV

import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.Cluster
import HEP.Automation.MadGraph.SetupType

import HEP.Automation.MadGraph.Model.ZpHFull

import HEP.Automation.MadGraph.Dataset.Common
import HEP.Automation.MadGraph.Dataset.Processes


import qualified Data.ByteString as B

psetup_zphfull_TTBarSemiLep :: ProcessSetup ZpHFull
psetup_zphfull_TTBarSemiLep = PS {  
    mversion = MadGraph4
  , model = ZpHFull
  , process = preDefProcess TTBarSemiLep
  , processBrief = "TTBarSemiLep" 
  , workname   = "421ZpH_TTBarSemiLep"
  }

zpHFullParamSet :: [ModelParam ZpHFull]
zpHFullParamSet = [ ZpHFullParam m g (0.28) 
                    | m <-[135.0, 140.0 .. 170.0 ]
                    , g <- [0.70, 0.75 .. 1.40] ] 
          

psetuplist :: [ProcessSetup ZpHFull]
psetuplist = [ psetup_zphfull_TTBarSemiLep ]

sets :: [Int]
sets = [1]

zptasklist :: ScriptSetup -> ClusterSetup -> [WorkSetup ZpHFull]
zptasklist ssetup csetup =  
  [ WS ssetup (psetup_zphfull_TTBarSemiLep) 
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
       (WebDAVRemoteDir "mc/TeVatronFor3/ZpHFull0421ScanTTBarSemiLep")
  | p <- zpHFullParamSet , num <- sets     ]


totaltasklistEvery :: Int -> Int -> ScriptSetup -> ClusterSetup -> [WorkSetup ZpHFull]
totaltasklistEvery n r ssetup csetup = 
  let lst = zip [1..] (zptasklist ssetup csetup)
  in  map snd . filter (\(x,_)-> x `mod` n == r) $ lst 


