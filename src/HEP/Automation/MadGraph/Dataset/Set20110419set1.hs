module HEP.Automation.MadGraph.Dataset.Set20110419set1 where

import HEP.Storage.WebDAV

import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.Cluster
import HEP.Automation.MadGraph.SetupType

import HEP.Automation.MadGraph.Model.ZpH

import HEP.Automation.MadGraph.Dataset.Common
import HEP.Automation.MadGraph.Dataset.Processes


psetup_zp_ttbarsemilep :: ProcessSetup ZpH
psetup_zp_ttbarsemilep = PS {  
    mversion = MadGraph4
  , model = ZpH
  , process = preDefProcess TTBarSemiLep
  , processBrief = "ttbarsemilep"  
  , workname   = "419ZpHTTSemiLep"
  }

zpparamset :: [ModelParam ZpH]
zpparamset = [ ZpHParam mass g | mass <- [400.0] , g <- [1.75] ] 
          

psetuplist :: [ProcessSetup ZpH]
psetuplist = [ psetup_zp_ttbarsemilep ]

sets :: [Int]
sets = [ 1..10 ]

zptasklist :: ScriptSetup -> ClusterSetup -> [WorkSetup ZpH]
zptasklist ssetup csetup =  
  [ WS ssetup (psetup_zp_ttbarsemilep) 
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
       (WebDAVRemoteDir "mc/TeVatronTau/Zp0419TTBarSemiLep")
  | p <- zpparamset 
  , num <- sets     ]

totaltasklist :: ScriptSetup -> ClusterSetup -> [WorkSetup ZpH]
totaltasklist = zptasklist 



          