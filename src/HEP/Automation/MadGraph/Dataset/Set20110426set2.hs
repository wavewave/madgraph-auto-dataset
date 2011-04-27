module HEP.Automation.MadGraph.Dataset.Set20110426set2 where

import HEP.Storage.WebDAV

import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.Util
import HEP.Automation.MadGraph.SetupType

import HEP.Automation.MadGraph.Model.ZpHFull

import HEP.Automation.MadGraph.Dataset.Common
import HEP.Automation.MadGraph.Dataset.Processes

import Control.Applicative

import qualified Data.ByteString as B

psetup_zphfull_SingleTZpLep :: ProcessSetup ZpHFull
psetup_zphfull_SingleTZpLep = PS {  
    mversion = MadGraph4
  , model = ZpHFull
  , process = preDefProcess SingleTZpLep
  , processBrief = "SingleTZpSemiLep" 
  , workname   = "426ZpH_SingleTZpSemiLep"
  }

zpHFullParamSet :: [ModelParam ZpHFull]
zpHFullParamSet = [ ZpHFullParam m g (0.28) 
                    | m <-[135.0, 140.0 .. 170.0 ]
                    , g <- [0.70, 0.75 .. 1.40] ] 
          

psetuplist :: [ProcessSetup ZpHFull]
psetuplist = [ psetup_zphfull_SingleTZpSemiLep ]

sets :: [Int]
sets = [1]

zptasklist :: ScriptSetup -> ClusterSetup ZpHFull -> [WorkSetup ZpHFull]
zptasklist ssetup csetup =
  [ WS ssetup (psetup_zphfull_SingleTZpSemiLep) 
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
       (WebDAVRemoteDir "mc/TeVatronFor3/ZpHFull0426ScanSingleTZpSemiLep")
  | p <- zpHFullParamSet , num <- sets     ]

totaltasklistEvery :: Int -> Int -> ScriptSetup -> ClusterSetup ZpHFull -> [WorkSetup ZpHFull]
totaltasklistEvery n r ssetup csetup = 
  let lst = zip [1..] (zptasklist ssetup csetup)
  in  map snd . filter (\(x,_)-> x `mod` n == r) $ lst 

{-
totaltasklist ::  ScriptSetup -> ClusterSetup ZpHFull -> [WorkSetup ZpHFull]
totaltasklist ssetup _csetup = 
  let lst' = zptasklistEvery 4 2 ssetup 
      mycsetup :: WorkSetup ZpHFull -> ClusterSetup ZpHFull 
      mycsetup x = CS (Cluster (head lst) (md5naming x) )
      g f = let w = f c 
                c = mycsetup w
            in  w
      lst = map g lst'
  in  lst 


totaltasklistcluster :: ScriptSetup -> ClusterSetup ZpHFull -> ClusterWork ZpHFull 
totaltasklistcluster ssetup csetup = 
  let lst = totaltasklist ssetup csetup 
  in  ClusterWork (head lst) lst 

-}


