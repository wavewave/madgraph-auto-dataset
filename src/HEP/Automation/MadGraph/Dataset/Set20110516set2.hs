module HEP.Automation.MadGraph.Dataset.Set20110516set2 where

import HEP.Storage.WebDAV

import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
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
  , workname   = "428ZpH_TTBarSemiLep"
  }

zpHFullParamSet :: [ModelParam ZpHFull]
zpHFullParamSet = [ ZpHFullParam m g (0.28) 
                    | m <-[150.0]
                    , g <- [1.00] ] 
          

psetuplist :: [ProcessSetup ZpHFull]
psetuplist = [ psetup_zphfull_TTBarSemiLep ]

sets :: [Int]
sets = [1,2..80]  

zptasklist :: ScriptSetup -> ClusterSetup ZpHFull -> [WorkSetup ZpHFull]
zptasklist ssetup csetup =  
  [ WS ssetup (psetup_zphfull_TTBarSemiLep) 
       (RS { param = p
           , numevent = 10000
           , machine = TeVatron 
           , rgrun   = Fixed
           , rgscale = 200.0
           , match   = NoMatch
           , cut     = DefCut 
           , pythia  = RunPYTHIA
           , usercut = NoUserCutDef
           , pgs     = RunPGSNoTau
           , setnum  = num 
           })
       csetup  
       (WebDAVRemoteDir "mc/TeVatronFor3/ZpHFull0516Big")
  | p <- zpHFullParamSet , num <- sets     ]


totaltasklistEvery :: Int -> Int -> ScriptSetup -> ClusterSetup ZpHFull -> [WorkSetup ZpHFull]
totaltasklistEvery n r ssetup csetup = 
  let lst = zip [1..] (zptasklist ssetup csetup)
  in  map snd . filter (\(x,_)-> x `mod` n == r) $ lst 


