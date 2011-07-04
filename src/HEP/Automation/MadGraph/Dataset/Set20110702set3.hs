module HEP.Automation.MadGraph.Dataset.Set20110702set3 where

import HEP.Storage.WebDAV.Type

import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut
import HEP.Automation.MadGraph.SetupType

import HEP.Automation.MadGraph.Model.ZpH

import HEP.Automation.MadGraph.Dataset.Processes

import HEP.Automation.JobQueue.JobType

psetup_zph_TTBar0or1J :: ProcessSetup ZpH
psetup_zph_TTBar0or1J = PS {  
    mversion = MadGraph4
  , model = ZpH
  , process = preDefProcess TTBar0or1J
  , processBrief = "TTBar0or1J" 
  , workname   = "630ZpH_TTBar0or1J"
  }

zphParamSet :: [ModelParam ZpH]
zphParamSet = [ ZpHParam { massZp = 800.0,  
                           gRZp = 3.4 } ]
              

psetuplist :: [ProcessSetup ZpH ]
psetuplist = [ psetup_zph_TTBar0or1J ]

sets :: [Int]
sets = [1..10] 

eventsets :: [EventSet]
eventsets =  
  [ EventSet  (psetup_zph_TTBar0or1J) 
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
                  , jetalgo = KTJet 0.5
                  , uploadhep = UploadHEP
                  , setnum  = num 
                  })
   | p <- zphParamSet , num <- sets     ]

webdavdir :: WebDAVRemoteDir
webdavdir = WebDAVRemoteDir "paper3/ttbarLHCwithHEP"
