module HEP.Automation.MadGraph.Dataset.Set20110702set4 where

import HEP.Storage.WebDAV.Type

import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.SetupType

import HEP.Automation.MadGraph.Model.AxiGluon

import HEP.Automation.MadGraph.Dataset.Processes

import HEP.Automation.JobQueue.JobType

psetup_axi_TTBar0or1J :: ProcessSetup AxiGluon
psetup_axi_TTBar0or1J = PS {  
    mversion = MadGraph4
  , model = AxiGluon
  , process = preDefProcess TTBar0or1J
  , processBrief = "TTBar0or1J" 
  , workname   = "701Axi_TTBar0or1J"
  }

axiParamSet :: [ModelParam AxiGluon]
axiParamSet = [ AxiGluonParam mass 0.0 0.0 ga (-ga) 
	      | mass <- [2000.0] , ga <- [2.4] ]  
              

psetuplist :: [ProcessSetup AxiGluon ]
psetuplist = [ psetup_axi_TTBar0or1J ]

sets :: [Int]
sets = [1..10]


eventsets :: [EventSet]
eventsets =  
  [ EventSet  (psetup_axi_TTBar0or1J) 
              (RS { param = p
                  , numevent = 10000
                  , machine = LHC7 
                  , rgrun   = Fixed
                  , rgscale = 200.0
                  , match   = MLM
                  , cut     = DefCut 
                  , pythia  = RunPYTHIA
                  , usercut = NoUserCutDef 
                  , pgs     = NoPGS
                  , jetalgo = KTJet
                  , uploadhep = UploadHEP
                  , setnum  = num 
                  })
   | p <- axiParamSet , num <- sets     ]

webdavdir :: WebDAVRemoteDir
webdavdir = WebDAVRemoteDir "paper3/ttbarLHCwithHEP"
