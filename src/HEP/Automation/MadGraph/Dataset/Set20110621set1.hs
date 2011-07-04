module HEP.Automation.MadGraph.Dataset.Set20110621set1 where

import HEP.Storage.WebDAV.Type

import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.SetupType

import HEP.Automation.MadGraph.Model.AxiGluon

import HEP.Automation.MadGraph.Dataset.Processes

import HEP.Automation.JobQueue.JobType

psetup_axi_WGDijet :: ProcessSetup AxiGluon
psetup_axi_WGDijet = PS {  
    mversion = MadGraph4
  , model = AxiGluon
  , process = preDefProcess WGDijet
  , processBrief = "WGDijet" 
  , workname   = "621Axi_WGDijet"
  }

axiParamSet :: [ModelParam AxiGluon]
axiParamSet = [ AxiGluonParam { massAxiG = 140.0,  
                                gVq = 0.0,  
                                gVt = 0.0, 
                                gAq = 0.3,  
                                gAt = 1.2 } ]
              

psetuplist :: [ProcessSetup AxiGluon ]
psetuplist = [ psetup_axi_WGDijet ]

sets :: [Int]
sets = [1,2..80]

eventsets :: [EventSet]
eventsets =  
  [ EventSet  (psetup_axi_WGDijet) 
              (RS { param = p
                  , numevent = 100
                  , machine = TeVatron 
                  , rgrun   = Fixed
                  , rgscale = 200.0
                  , match   = NoMatch
                  , cut     = DefCut 
                  , pythia  = RunPYTHIA
                  , usercut = NoUserCutDef
                  , pgs     = RunPGSNoTau
                  , jetalgo = KTJet 0.5
                  , setnum  = num 
                  })
   | p <- axiParamSet , num <- sets     ]

webdavdir :: WebDAVRemoteDir
webdavdir = WebDAVRemoteDir "test/testjqueue"
