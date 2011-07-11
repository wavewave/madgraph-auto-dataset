module HEP.Automation.MadGraph.Dataset.Set20110708set1 where

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
  , workname   = "628ZpH_TTBar0or1J"
  }

zphParamSet :: [ModelParam ZpH]
zphParamSet = [ ZpHParam { massZp = m,  
                           gRZp = g } | m <- [200,220..1000] 
                                      , g <- [0.5,0.6..4] ]

-- m <- [200,400,600,800,1000], g <- [1,2,3,4,5] ]
              

psetuplist :: [ProcessSetup ZpH ]
psetuplist = [ psetup_zph_TTBar0or1J ]

sets :: [Int]
sets =  [1]

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
  [ EventSet  (psetup_zph_TTBar0or1J) 
              (RS { param = p
                  , numevent = 10000
                  , machine = LHC7 ATLAS 
                  , rgrun   = Fixed
                  , rgscale = 200.0
                  , match   = MLM
                  , cut     = DefCut 
                  , pythia  = NoPYTHIA
                  , usercut = NoUserCutDef 
                  , pgs     = NoPGS
                  , jetalgo = AntiKTJet 0.4
                  , uploadhep = NoUploadHEP
                  , setnum  = num 
                  })
   | p <- zphParamSet , num <- sets     ]

webdavdir :: WebDAVRemoteDir
webdavdir = WebDAVRemoteDir "paper3/ttbarLHCpartonscan"
