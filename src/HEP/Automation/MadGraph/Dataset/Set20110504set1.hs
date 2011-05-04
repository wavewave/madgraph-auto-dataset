module HEP.Automation.MadGraph.Dataset.Set20110504set1 where

import HEP.Storage.WebDAV

import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.SetupType

import HEP.Automation.MadGraph.Model.AxiGluon

import HEP.Automation.MadGraph.Dataset.Common
import HEP.Automation.MadGraph.Dataset.Processes


import qualified Data.ByteString as B

psetup_axi_TTBarSemiLep :: ProcessSetup AxiGluon
psetup_axi_TTBarSemiLep = PS {  
    mversion = MadGraph4
  , model = AxiGluon
  , process = preDefProcess TTBarSemiLep 
  , processBrief = "TTBarSemiLep" 
  , workname   = "504Axi_TTBarSemiLep"
  }

axiParamSet :: [ModelParam AxiGluon]
axiParamSet = [ AxiGluonParam { massAxiG = 140.0,  
                                gVq = 0.0,  
                                gVt = 0.0, 
                                gAq = 0.3,  
                                gAt = 1.2 } ]
              

psetuplist :: [ProcessSetup AxiGluon ]
psetuplist = [ psetup_axi_TTBarSemiLep ]

sets :: [Int]
sets = [1,2..80]

axitasklist :: ScriptSetup -> ClusterSetup AxiGluon -> [WorkSetup AxiGluon]
axitasklist ssetup csetup =  
  [ WS ssetup (psetup_axi_TTBarSemiLep) 
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
       (WebDAVRemoteDir "mc/TeVatronFor3/Axi0504Big")
  | p <- axiParamSet , num <- sets     ]

totaltasklistEvery = tasklistEvery axitasklist 

