module HEP.Automation.MadGraph.Dataset.Set20110628set1 where

import HEP.Storage.WebDAV.Type

import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine.V2
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.SetupType.V2

import HEP.Automation.MadGraph.Model.ZpH

import HEP.Automation.MadGraph.Dataset.Processes

import HEP.Automation.JobQueue.JobType.V2

psetup_zph_TTBar0or1J :: ProcessSetup ZpH
psetup_zph_TTBar0or1J = PS {  
    mversion = MadGraph4
  , model = ZpH
  , process = preDefProcess TTBar0or1J
  , processBrief = "TTBar0or1J" 
  , workname   = "628ZpH_TTBar0or1J"
  }

zphParamSet :: [ModelParam ZpH]
zphParamSet = [ ZpHParam { massZp = 400.0,  
                           gRZp = 1.75 } ]
              

psetuplist :: [ProcessSetup ZpH ]
psetuplist = [ psetup_zph_TTBar0or1J ]

sets :: [Int]
sets = [6,16,17,19,27,30,45] -- [1..50]

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
  [ EventSet  (psetup_zph_TTBar0or1J) 
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
                  , jetalgo = KTJet 0.5
                  , uploadhep = NoUploadHEP
                  , setnum  = num 
                  })
   | p <- zphParamSet , num <- sets     ]

webdavdir :: WebDAVRemoteDir
webdavdir = WebDAVRemoteDir "paper3/ttbarLHC"
