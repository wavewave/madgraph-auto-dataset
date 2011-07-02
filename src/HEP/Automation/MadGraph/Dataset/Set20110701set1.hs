module HEP.Automation.MadGraph.Dataset.Set20110701set1 where

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
sets = [1..50]

ucut :: UserCut 
ucut = UserCut { 
    uc_metcut = 15.0
  , uc_etacutlep = 1.2
  , uc_etcutlep = 18.0 
  , uc_etacutjet = 2.5
  , uc_etcutjet = 15.0 
}


eventsets :: [EventSet]
eventsets =  
  [ EventSet  (psetup_axi_TTBar0or1J) 
              (RS { param = p
                  , numevent = 100000
                  , machine = LHC7 
                  , rgrun   = Fixed
                  , rgscale = 200.0
                  , match   = MLM
                  , cut     = DefCut 
                  , pythia  = RunPYTHIA
                  , usercut = UserCutDef ucut
                  , pgs     = RunPGS
                  , jetalgo = KTJet
                  , uploadhep = NoUploadHEP
                  , setnum  = num 
                  })
   | p <- axiParamSet , num <- sets     ]

webdavdir :: WebDAVRemoteDir
webdavdir = WebDAVRemoteDir "paper3/ttbarLHC"
