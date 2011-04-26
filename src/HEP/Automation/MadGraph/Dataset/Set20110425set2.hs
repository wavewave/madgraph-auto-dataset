module HEP.Automation.MadGraph.Dataset.Set20110425set2 where

import HEP.Storage.WebDAV

import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.SetupType

import HEP.Automation.MadGraph.Model.ZpHFull

import HEP.Automation.MadGraph.Dataset.Common
import HEP.Automation.MadGraph.Dataset.Processes


import qualified Data.ByteString as B

psetup_zphfull_TTBar :: ProcessSetup ZpHFull
psetup_zphfull_TTBar = PS {  
    mversion = MadGraph4
  , model = ZpHFull
  , process = preDefProcess TTBar
  , processBrief = "TTBar" 
  , workname   = "425SMusingZpH_TTBar"
  }

zpHFullParamSet :: [ModelParam ZpHFull]
zpHFullParamSet = [ ZpHFullParam m g (0.28) 
                    | m <-[150.0]
                    , g <- [0.0] ] 
          

psetuplist :: [ProcessSetup ZpHFull]
psetuplist = [ psetup_zphfull_TTBar ]

sets :: [Int]
sets = [1..10]

zptasklist :: ScriptSetup -> [ ClusterSetup ZpHFull -> WorkSetup ZpHFull ]
zptasklist ssetup = [ \csetup -> WS ssetup (psetup_zphfull_TTBar) 
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
                                 (WebDAVRemoteDir "mc/TeVatronFor3/SMusingZp0425TTBarSemiLep")
                    | p <- zpHFullParamSet , num <- sets     ]


totaltasklist ::  ScriptSetup -> ClusterSetup ZpHFull -> [WorkSetup ZpHFull]
totaltasklist ssetup _csetup = 
  let lst' = zptasklist ssetup 
      mycsetup :: WorkSetup ZpHFull -> ClusterSetup ZpHFull 
      mycsetup x = CS (Cluster (head lst) (defaultClusterNamingFunction (head lst) x) )
      g f = let w = f c 
                c = mycsetup w
            in  w
      lst = map g lst'
  in  lst 

totaltasklistcluster :: ScriptSetup -> ClusterSetup ZpHFull -> ClusterWork ZpHFull 
totaltasklistcluster ssetup csetup = 
  let lst = totaltasklist ssetup csetup
  in  ClusterWork (head lst) lst 

