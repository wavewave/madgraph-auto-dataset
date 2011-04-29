module HEP.Automation.MadGraph.Dataset.Set20110428set2 where

import HEP.Storage.WebDAV

import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.SetupType

import HEP.Automation.MadGraph.Model.ZpHFull

import HEP.Automation.MadGraph.Dataset.Common
import HEP.Automation.MadGraph.Dataset.Processes


import qualified Data.ByteString as B

psetup_zphfull_TTBarSemiZp :: ProcessSetup ZpHFull
psetup_zphfull_TTBarSemiZp = PS {  
    mversion = MadGraph4
  , model = ZpHFull
  , process = preDefProcess TTBarSemiZp 
  , processBrief = "TTBarSemiZp" 
  , workname   = "428ZpH_TTBarSemiZp"
  }

zpHFullParamSet :: [ModelParam ZpHFull]
zpHFullParamSet = [ ZpHFullParam m g (0.28) 
                    | m <-[140.0]
                    , g <- [0.90] ] 
          

psetuplist :: [ProcessSetup ZpHFull]
psetuplist = [ psetup_zphfull_TTBarSemiZp ]

sets :: [Int]
sets = [102,103..200] -- [101]

zptasklist :: ScriptSetup -> ClusterSetup ZpHFull -> [WorkSetup ZpHFull]
zptasklist ssetup csetup =  
  [ WS ssetup (psetup_zphfull_TTBarSemiZp) 
       (RS { param = p
           , numevent = 10000
           , machine = TeVatron 
           , rgrun   = Fixed
           , rgscale = 200.0
           , match   = NoMatch
           , cut     = DefCut 
           , pythia  = RunPYTHIA
           , usercut = NoUserCutDef
           , pgs     = RunPGS 
           , setnum  = num 
           })
       csetup  
       (WebDAVRemoteDir "mc/TeVatronFor3/ZpHFull0428Big")
  | p <- zpHFullParamSet , num <- sets     ]


totaltasklistEvery :: Int -> Int -> ScriptSetup -> ClusterSetup ZpHFull -> [WorkSetup ZpHFull]
totaltasklistEvery n r ssetup csetup = 
  let lst = zip [1..] (zptasklist ssetup csetup)
  in  map snd . filter (\(x,_)-> x `mod` n == r) $ lst 


