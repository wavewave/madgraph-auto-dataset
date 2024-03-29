module HEP.Automation.MadGraph.Dataset.Set20110707set2 where

import HEP.Storage.WebDAV.Type

import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.SetupType

import HEP.Automation.MadGraph.Model.Wp

import HEP.Automation.MadGraph.Dataset.Processes

import HEP.Automation.JobQueue.JobType

psetup_wp_TTBar0or1J :: ProcessSetup Wp
psetup_wp_TTBar0or1J = PS {  
    mversion = MadGraph4
  , model = Wp
  , process = preDefProcess TTBar0or1J
  , processBrief = "TTBar0or1J" 
  , workname   = "707Wp_TTBar0or1J"
  }

wpParamSet :: [ModelParam Wp]
wpParamSet = [ WpParam 400.0 2.55 ]
              

psetuplist :: [ProcessSetup Wp ]
psetuplist = [ psetup_wp_TTBar0or1J ]

sets :: [Int]
sets = [1..50] 

ucut :: UserCut 
ucut = UserCut { 
    uc_metcut = 15.0
  , uc_etacutlep = 2.7
  , uc_etcutlep = 18.0 
  , uc_etacutjet = 2.7
  , uc_etcutjet = 15.0 
}


eventsets :: [EventSet]
eventsets =  
  [ EventSet  (psetup_wp_TTBar0or1J) 
              (RS { param = p
                  , numevent = 100000
                  , machine = LHC7 ATLAS 
                  , rgrun   = Fixed
                  , rgscale = 200.0
                  , match   = MLM
                  , cut     = DefCut 
                  , pythia  = RunPYTHIA
                  , usercut = UserCutDef ucut
                  , pgs     = RunPGS
                  , jetalgo = AntiKTJet 0.4
                  , uploadhep = NoUploadHEP
                  , setnum  = num 
                  })
   | p <- wpParamSet , num <- sets     ]

webdavdir :: WebDAVRemoteDir
webdavdir = WebDAVRemoteDir "paper3/ttbarLHC"
