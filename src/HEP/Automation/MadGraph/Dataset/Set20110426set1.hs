module HEP.Automation.MadGraph.Dataset.Set20110426set1 where

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

zptasklistEvery :: Int -> Int -> ScriptSetup -> [ClusterSetup ZpHFull -> WorkSetup ZpHFull]
zptasklistEvery n r ssetup =   
  let lst = zip [1..] (zptasklist ssetup)
  in  map snd . filter (\(x,_)-> x `mod` n == r) $ lst     

zptasklist :: ScriptSetup -> [ClusterSetup ZpHFull -> WorkSetup ZpHFull]
zptasklist ssetup =
  [ \csetup -> WS ssetup (psetup_zphfull_TTBarSemiLep) 
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




